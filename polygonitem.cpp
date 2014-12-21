#include "polygonitem.h"
#include <QDebug>



QQuickPen::QQuickPen(QObject *parent)
    :QObject(parent)
{
    mWidth = 0;
    mColor = Qt::black;

}

int QQuickPen::width() const
{
    return mWidth;
}



void QQuickPen::setWidth(int w)
{
    mWidth = w;
    emit penChanged();
}

QColor QQuickPen::color() const
{
    return mColor;

}

void QQuickPen::setColor(const QColor &c)
{
    mColor = c;
    emit penChanged();

}









PolygonItem::PolygonItem(QQuickItem *parent) :
    QQuickPaintedItem(parent)
{

    mPoly.append(QPoint(0,0));
    mPoly.append(QPoint(0,200));
    mPoly.append(QPoint(200,0));

    mColor = Qt::white;
    setAntialiasing(true);
    mBorder = new QQuickPen();

}

void PolygonItem::paint(QPainter *painter)
{

    QPen pen;
    pen.setWidth(mBorder->width());
    pen.setColor(mBorder->width()? mBorder->color() : color());
    painter->setPen(pen);
    painter->setBrush(QBrush(color()));
    painter->drawPolygon(mPoly);
//    qDebug()<<"paint";


}

QRectF PolygonItem::contentsBoundingRect() const
{

    return mPoly.boundingRect();

}

QQuickPen *PolygonItem::border()
{
    return  mBorder;
}

void PolygonItem::setColor(const QColor &col)
{
    mColor = col;
    emit colorChanged();
}

QColor PolygonItem::color() const
{

    return mColor;

}

void PolygonItem::setPoints(const QVariantList &list)
{

    mPoly.clear();
    foreach (QVariant points , list){

        if (points.toList().count() != 2) {
            qDebug()<<"Points list should be define as : [ [x1,y1], [x2,y2] ..]";
            return;
        }

        int x = points.toList().at(0).toInt();
        int y = points.toList().at(1).toInt();

        mPoly.append(QPoint(x,y));

    }

    emit pointsChanged();


}

QVariantList PolygonItem::points() const
{

    QVariantList list;
       for (int i=0; i< mPoly.count(); ++i)
       {

           QVariantList p;
           p.append(mPoly.at(i).x());
           p.append(mPoly.at(i).y());

            list.append(p);



       }


    return list;



}

int PolygonItem::count() const
{
    return mPoly.count();
}

void PolygonItem::addPoint(int x, int y)
{
   mPoly.append(QPoint(x,y));
   emit pointsChanged();
}

void PolygonItem::clear()
{

    mPoly.clear();
    emit pointsChanged();

}

