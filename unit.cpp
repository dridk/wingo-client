#include "unit.h"
#include <QApplication>
#include <QtMath>
#include <QDebug>
Unit::Unit(const QSize& size,QObject *parent) :
    QObject(parent)
{
    mIntendedSize = size;
    mRoudUp = false;

    if (mIntendedSize.isEmpty()){
        mIntendedSize = QSize(640, 480);
    }
    mCurrentSize = qApp->screens().first()->size();
    mScreen = qApp->screens().first();

    computeRatio();
}

Unit::~Unit()
{

}

qreal Unit::pt(int pixel)
{

    return qreal(pixel) / mRatio;
}

int Unit::px(qreal point)
{
    return scale(point, mRatio);
}

int Unit::scale(qreal point, qreal ratio)
{
    return mRoudUp?qCeil(point * ratio) : qFloor(point * ratio);
}

qreal Unit::ratio()
{
    return mRatio;
}

QString Unit::size()
{
    return QString("%1 x %2").arg(mCurrentSize.width()).arg(mCurrentSize.height());
}

void Unit::setRoundUp(bool r)
{

    mRoudUp = r;
}

void Unit::computeRatio()
{

    qreal d= qSqrt(qPow(mIntendedSize.width(),2)+ qPow(mIntendedSize.height(), 2));

    //Compute the diagonal length of the current app window (IS)
    qreal appd =  qSqrt(qPow(mCurrentSize.width(),2)+ qPow(mCurrentSize.height(), 2));

    //Calculate the ration between what IS and what SHOULD be
    mRatio =  appd/d;

    qDebug()<<"RATIO COMPUTED "<<mRatio;

    emit ratioChanged();
}

