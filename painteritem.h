#ifndef PAINTERITEM_H
#define PAINTERITEM_H

#include <QQuickPaintedItem>
#include <QPainter>
#include <QLineF>
#include <QMouseEvent>
class PainterItem : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QColor penColor WRITE setPenColor NOTIFY penChanged)


public:
    explicit PainterItem(QQuickItem *parent = 0);

    void setPenSize(int w);
    void setPenColor(const QColor& color);
    Q_INVOKABLE bool save();
    Q_INVOKABLE bool load();
    Q_INVOKABLE QString path() const;


signals:
    void penChanged();

protected:
    virtual void paint(QPainter * painter);
    void mousePressEvent(QMouseEvent * event);
    void mouseReleaseEvent(QMouseEvent * event);
    void mouseMoveEvent(QMouseEvent * event);




private:
    QColor mColor;
    QPen mPen;
    QPainterPath mPath;
    QPixmap mCachePixmap;
    QPainter mCachePainter;
    QPoint mPenPos;



};

#endif // PAINTERITEM_H
