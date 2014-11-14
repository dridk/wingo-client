#include "painteritem.h"
#include <QDebug>
PainterItem::PainterItem(QQuickItem *parent) :
    QQuickPaintedItem(parent)
{

    setAcceptedMouseButtons(Qt::LeftButton);
    mCachePixmap = QPixmap();

    mPen.setWidth(10);
    mPen.setStyle(Qt::SolidLine);
    mPen.setJoinStyle(Qt::RoundJoin);
    mPen.setCapStyle(Qt::RoundCap);
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
   painter->setRenderHint(QPainter::HighQualityAntialiasing,true);

    painter->drawPixmap(0,0,mCachePixmap);

}

void PainterItem::mousePressEvent(QMouseEvent *event)
{


    if (mCachePixmap.isNull()){
        mCachePixmap = QPixmap(width(),height());
        mCachePixmap.fill(Qt::white);
        mCachePainter.setRenderHint(QPainter::HighQualityAntialiasing,true);
        mCachePainter.begin(&mCachePixmap);
    }

    mCachePainter.setPen(mPen);
    mPenPos = event->pos();


}

void PainterItem::mouseReleaseEvent(QMouseEvent *event)
{

}

void PainterItem::mouseMoveEvent(QMouseEvent *event)
{

    QPoint diff = event->pos() - mPenPos;
    int limit = 10;

    if ((qAbs(diff.x()) > limit) || (qAbs(diff.y()) > limit)){

    mCachePainter.drawLine(mPenPos, event->pos());
    mPenPos = event->pos();

    update();

    }



}

