#include "qquickpen.h"


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


