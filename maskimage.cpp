#include "maskimage.h"
#include <QBitmap>
#include <QRegion>

QNetworkAccessManager * MaskImage::mManager = 0;

MaskImage::MaskImage()
{
    mSourceMode      = QPainter::CompositionMode_SourceOut;
    mDestinationMode = QPainter::CompositionMode_DestinationOut;

    if (mManager == 0)
    {
        mManager = new QNetworkAccessManager;

    }

}

MaskImage::~MaskImage()
{

}

void MaskImage::paint(QPainter *painter)
{

    if (!mSourcePix.isNull())
    {



        painter->setCompositionMode(mSourceMode);
        painter->drawPixmap(boundingRect(),mSourcePix, mSourcePix.rect());

        painter->setCompositionMode(mDestinationMode);
        painter->drawPixmap(boundingRect(),mMaskPix, mMaskPix.rect());

    }


}

const QUrl &MaskImage::source() const
{
    return mSource;
}

void MaskImage::setSource(const QUrl &source)
{

    mSource = source;

    if ((mSource.scheme() == "http" ) || (mSource.scheme() == "https")) {

        downloadImage(source);

    }

    else {
        mSourcePix = QPixmap(":"+source.toDisplayString(QUrl::RemoveScheme));
        checkSize();
        update();

    }


}

const QUrl &MaskImage::mask() const
{
    return mMask;
}

void MaskImage::setMask(const QUrl &url)
{


    mMask = url;
    mMaskPix = QPixmap(":"+mMask.toDisplayString(QUrl::RemoveScheme));
    update();

}

void MaskImage::setComposition(QPainter::CompositionMode source, QPainter::CompositionMode destination)
{
    mSourceMode  = source;
    mDestinationMode = destination;
    update();
}

void MaskImage::downloadImage(const QUrl& url)
{

    QNetworkRequest request(url);
    QNetworkReply * reply =  mManager->get(request);


    connect(reply,SIGNAL(finished()),this,SLOT(parseImage()));




}

void MaskImage::checkSize()
{
    if (boundingRect().isEmpty())
    {
        setWidth(mSourcePix.width());
        setHeight(mSourcePix.height());
    }
}

void MaskImage::parseImage()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    qDebug()<<"loaded..";

    if (reply->error() == QNetworkReply::NoError){

        mSourcePix.loadFromData(reply->readAll());
        checkSize();

        update();

    }

    reply->deleteLater();


}

