#ifndef PAINTERITEM_H
#define PAINTERITEM_H

#include <QQuickPaintedItem>
#include <QPainter>
#include <QLineF>
#include <QMouseEvent>
class PainterItem : public QQuickPaintedItem
{
    Q_OBJECT
public:
    explicit PainterItem(QQuickItem *parent = 0);

protected:
    virtual void paint(QPainter * painter);
    void mousePressEvent(QMouseEvent * event);
    void mouseReleaseEvent(QMouseEvent * event);
    void mouseMoveEvent(QMouseEvent * event);


private:
    QColor mColor;
    QPen mPen;
    QPainterPath mPath;


};

#endif // PAINTERITEM_H
