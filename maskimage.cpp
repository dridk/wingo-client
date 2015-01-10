#include "maskimage.h"
#include <QBitmap>
#include <QRegion>

QNetworkAccessManager * MaskImage::mManager = 0;

MaskImage::MaskImage()
{
    mSourceMode      = QPainter::CompositionMode_SourceOut;
    mDestinationMode = QPainter::CompositionMode_DestinationOut;
}

MaskImage::~MaskImage()
{

}

void MaskImage::paint(QPainter *painter)
{

    if (!mOriginalPix.isNull())
    {



        painter->setCompositionMode(mSourceMode);
        painter->drawPixmap(boundingRect(),mOriginalPix, mOriginalPix.rect());

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
    mOriginalPix = QPixmap(":"+source.toDisplayString(QUrl::RemoveScheme));

    if (boundingRect().isEmpty())
    {
        setWidth(mOriginalPix.width());
        setHeight(mOriginalPix.height());
    }



    update();

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

void MaskImage::downloadImage()
{






}

