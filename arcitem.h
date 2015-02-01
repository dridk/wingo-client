#ifndef ARCITEM_H
#define ARCITEM_H

#include <QQuickItem>
#include <QQuickPaintedItem>
#include <QPolygon>
#include <QPainter>
#include <QVariantList>
#include "qquickpen.h"
class ArcItem : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(int startAngle READ startAngle WRITE setStartAngle NOTIFY arcChanged)
    Q_PROPERTY(int spanAngle READ spanAngle WRITE setSpanAngle NOTIFY arcChanged)
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(QQuickPen * border READ border CONSTANT)

public:
    explicit ArcItem(QQuickItem *parent = 0);


    QQuickPen *border();

    void setColor(const QColor& col);
    QColor color() const;


     void setStartAngle(int angle);
     int startAngle();

     void setSpanAngle(int angle);
    int spanAngle();


protected:
    virtual void paint(QPainter *painter);

signals:
    void colorChanged();
    void arcChanged();

private:
    QColor mColor;
    int mStartAngle;
    int mSpanAngle;
    QQuickPen * mBorder;
};

#endif // ARCITEM_H
