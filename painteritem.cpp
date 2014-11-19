#include "painteritem.h"
#include <QDebug>
#include <QStandardPaths>
#include <QDir>
#include <QTime>
PainterItem::PainterItem(QQuickItem *parent) :
    QQuickPaintedItem(parent)
{

    setAcceptedMouseButtons(Qt::LeftButton);
    mCachePixmap = QPixmap();

    mPen.setWidth(10);
    mPen.setStyle(Qt::SolidLine);
    mPen.setJoinStyle(Qt::RoundJoin);
    mPen.setCapStyle(Qt::RoundCap);


    mCachePixmap = QPixmap();



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

bool PainterItem::save()
{

return mCachePixmap.save(path());

}

bool PainterItem::load()
{
    mCachePixmap.load(path());
    mCachePainter.begin(&mCachePixmap);

}

QString PainterItem::path() const
{
    QString filename = QStandardPaths::writableLocation(QStandardPaths::TempLocation) + QDir::separator() + "wingo.png";
    return filename;

}


void PainterItem::paint(QPainter *painter)
{

    if (mCachePixmap.isNull()){
        mCachePixmap = QPixmap(width(),height());
        mCachePixmap.fill(Qt::white);
        mCachePainter.begin(&mCachePixmap);

    }
    painter->setBrush(QBrush(Qt::white));
    painter->drawRect(contentsBoundingRect());
   painter->setRenderHint(QPainter::HighQualityAntialiasing,true);

    painter->drawPixmap(0,0,mCachePixmap);

}

void PainterItem::mousePressEvent(QMouseEvent *event)
{




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

