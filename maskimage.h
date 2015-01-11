#ifndef MASKIMAGE_H
#define MASKIMAGE_H

#include <QQuickPaintedItem>
#include <QPixmap>
#include <QPainter>
#include <QtNetwork>

class MaskImage : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QUrl source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(QUrl mask READ mask WRITE setMask NOTIFY maskChanged)
    Q_PROPERTY(CompositionMode sourceMode READ sourceMode WRITE setSourceMode NOTIFY sourceModeChanged)
    Q_PROPERTY(CompositionMode destinationMode READ destinationMode WRITE setDestinationMode NOTIFY destinationModeChanged)
    Q_PROPERTY(Status status READ status NOTIFY statusChanged)

public:
    enum CompositionMode{
        CompositionMode_SourceOver,
        CompositionMode_DestinationOver,
        CompositionMode_Clear,
        CompositionMode_Source,
        CompositionMode_Destination,
        CompositionMode_SourceIn,
        CompositionMode_DestinationIn,
        CompositionMode_SourceOut,
        CompositionMode_DestinationOut,
        CompositionMode_SourceAtop,
        CompositionMode_DestinationAtop,
        CompositionMode_Xor
    };
    Q_ENUMS(CompositionMode)

    enum Status {
        Null,
        Ready,
        Loading,
        Error
    };
    Q_ENUMS(Status)


    MaskImage();
    ~MaskImage();

    virtual void paint(QPainter * painter);


    const QUrl &source() const;
    void setSource(const QUrl& url);

    const QUrl &mask() const;
    void setMask(const QUrl& url);

    CompositionMode sourceMode() const;
    void setSourceMode(CompositionMode mode);

    CompositionMode destinationMode() const;
    void setDestinationMode(CompositionMode mode);

    Status status() const;
    void setStatus(Status status);


protected:
    void downloadImage(const QUrl& url);
    void checkSize();

protected slots:
    void parseImage();
    void downloadProgress(qint64,qint64);

signals:
    void sourceChanged();
    void maskChanged();

    void sourceModeChanged();
    void destinationModeChanged();
    void statusChanged();



private:
    QUrl mSource;
    QUrl mMask;
    QPixmap mSourcePix;
    QPixmap mMaskPix;
    static QNetworkAccessManager * mManager;
    CompositionMode mSourceMode;
    CompositionMode mDestinationMode;
    Status mStatus;




};

#endif // MASKIMAGE_H
