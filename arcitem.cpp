#include "arcitem.h"

ArcItem::ArcItem(QQuickItem * parent):
    QQuickPaintedItem(parent)
{
    mColor = Qt::white;
    setAntialiasing(true);
    mBorder = new QQuickPen();

    mStartAngle = 0;
    mSpanAngle = 360;

}



QQuickPen *ArcItem::border()
{
    return mBorder;
}

void ArcItem::setColor(const QColor &col)
{
    mColor = col;
    update();
}

QColor ArcItem::color() const
{
    return mColor;
}

void ArcItem::setStartAngle(int angle)
{
    mStartAngle = angle;
}

int ArcItem::startAngle()
{
    return mStartAngle;
}

void ArcItem::setSpanAngle(int angle)
{
    mSpanAngle = angle;
    update();
}

int ArcItem::spanAngle()
{
    return mSpanAngle;
    update();
}

void ArcItem::paint(QPainter *painter)
{

    painter->setBrush(QBrush(color()));
    QPen pen;
    pen.setWidth(mBorder->width());
    pen.setColor(mBorder->width()? mBorder->color() : color());
    painter->setPen(pen);


    painter->drawArc(boundingRect().adjusted(mBorder->width(), mBorder->width(), -mBorder->width(), -mBorder->width()), mStartAngle*16, mSpanAngle*16);

    emit arcChanged();

}



