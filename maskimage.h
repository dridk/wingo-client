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
public:
    MaskImage();
    ~MaskImage();

    virtual void paint(QPainter * painter);


    const QUrl &source() const;
    void setSource(const QUrl& url);

    const QUrl &mask() const;
    void setMask(const QUrl& url);

    Q_INVOKABLE void setComposition(QPainter::CompositionMode source,QPainter::CompositionMode destination);

protected:
    void downloadImage(const QUrl& url);
    void checkSize();

protected slots:
    void parseImage();

signals:
    void sourceChanged();
    void maskChanged();


private:
    QUrl mSource;
    QUrl mMask;
    QPixmap mSourcePix;
    QPixmap mMaskPix;
    static QNetworkAccessManager * mManager;
    QPainter::CompositionMode mSourceMode;
    QPainter::CompositionMode mDestinationMode;


};

#endif // MASKIMAGE_H
