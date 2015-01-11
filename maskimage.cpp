#include "maskimage.h"
#include <QBitmap>
#include <QRegion>

QNetworkAccessManager * MaskImage::mManager = 0;

MaskImage::MaskImage()
{

    if (mManager == 0)
    {
        mManager = new QNetworkAccessManager;

    }

    mSourceMode = MaskImage::CompositionMode_SourceOut;
    mDestinationMode = MaskImage::CompositionMode_DestinationOut;

    mStatus = MaskImage::Null;


}

MaskImage::~MaskImage()
{

}

void MaskImage::paint(QPainter *painter)
{

    if (!mSourcePix.isNull())
    {

        painter->setRenderHints(QPainter::Antialiasing | QPainter::SmoothPixmapTransform);

        painter->setCompositionMode(QPainter::CompositionMode(mSourceMode));
        painter->drawPixmap(boundingRect(),mSourcePix, mSourcePix.rect());

        painter->setCompositionMode(QPainter::CompositionMode(mDestinationMode));
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
        setStatus(MaskImage::Ready);


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

MaskImage::CompositionMode MaskImage::sourceMode() const
{
    return mSourceMode;
}

void MaskImage::setSourceMode(MaskImage::CompositionMode mode)
{
    mSourceMode = mode;
    update();
    emit sourceModeChanged();
}

MaskImage::CompositionMode MaskImage::destinationMode() const
{
    return mDestinationMode;
}

void MaskImage::setDestinationMode(MaskImage::CompositionMode mode)
{
    mDestinationMode = mode;
    update();
    emit destinationModeChanged();
}

MaskImage::Status MaskImage::status() const
{
    return mStatus;
}

void MaskImage::setStatus(MaskImage::Status status)
{
    mStatus = status;
    emit statusChanged();
}


void MaskImage::downloadImage(const QUrl& url)
{

    QNetworkRequest request(url);
    QNetworkReply * reply =  mManager->get(request);

    setStatus(MaskImage::Loading);

    connect(reply,SIGNAL(finished()),this,SLOT(parseImage()));
    connect(reply,SIGNAL(downloadProgress(qint64,qint64)),SLOT(downloadProgress(qint64,qint64)));




}

void MaskImage::checkSize()
{


    if (boundingRect().isEmpty())
    {
        setWidth(mSourcePix.width());
        setHeight(mSourcePix.height());
    }
}

void MaskImage::downloadProgress(qint64 bytes, qint64 total)
{
    Q_UNUSED(bytes)
    Q_UNUSED(total)


}

void MaskImage::parseImage()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError){
        mSourcePix.loadFromData(reply->readAll());
        if ( mSourcePix.isNull())
            setStatus(MaskImage::Error);

        else {
            checkSize();
            update();
            setStatus(MaskImage::Ready);
        }

    }

    reply->deleteLater();


}

