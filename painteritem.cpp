#include "painteritem.h"
#include <QDebug>
PainterItem::PainterItem(QQuickItem *parent) :
    QQuickPaintedItem(parent)
{

    setAcceptedMouseButtons(Qt::LeftButton);
}

void PainterItem::setPenSize(int w)
{
    mPen.setWidth(w);
    emit penChanged();


}

void PainterItem::setPenColor(const QColor &color)
{

    mPen.setColor(color);
    emit penChanged();

}


void PainterItem::paint(QPainter *painter)
{

    painter->setBrush(QBrush(Qt::white));
    painter->drawRect(contentsBoundingRect());

    painter->drawPath(mPath);


}

void PainterItem::mousePressEvent(QMouseEvent *event)
{





}

void PainterItem::mouseReleaseEvent(QMouseEvent *event)
{

}

void PainterItem::mouseMoveEvent(QMouseEvent *event)
{

    mPath.lineTo(event->pos());
    update();

    qDebug()<<"press";



}

