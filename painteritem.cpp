#include "painteritem.h"
#include <QDebug>
PainterItem::PainterItem(QQuickItem *parent) :
    QQuickPaintedItem(parent)
{

setAcceptedMouseButtons(Qt::LeftButton);
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

