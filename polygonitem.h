#ifndef POLYGONITEM_H
#define POLYGONITEM_H

#include <QQuickPaintedItem>
#include <QPolygon>
#include <QPainter>
#include <QVariantList>

// ==== USAGE ===================
//PolygonItem {
//    id:test
//    width: 200
//    height: 200
//    color:"blue"
//    border.color: "red"
//    border.width : 4
//    points:[[0,0], [200,0], [0,200]]
//    onPointsChanged: console.debug(test.count())
//}

// test.addPoint(4,5)
// test.clear()

// ==== USAGE ===================






class  QQuickPen : public QObject
{
    Q_OBJECT
    Q_PROPERTY(qreal width READ width WRITE setWidth NOTIFY penChanged)
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY penChanged)

public:
    QQuickPen(QObject *parent=0);
    int width() const;
    void setWidth(int w);
    QColor color() const;
    void setColor(const QColor &c);


signals:
    void penChanged();

private:
    QColor mColor;
    int mWidth;



};





class PolygonItem : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QVariantList points READ points WRITE setPoints NOTIFY pointsChanged)
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(QQuickPen * border READ border CONSTANT)
    Q_PROPERTY(int count READ count CONSTANT)

public:
    explicit PolygonItem(QQuickItem *parent = 0);
    QRectF contentsBoundingRect() const;


    QQuickPen * border();

    void setColor(const QColor& col);
    QColor color() const;

    void setPoints(const QVariantList& list);
    QVariantList points() const;

    int count() const;


    Q_INVOKABLE void addPoint(int x, int y);
    Q_INVOKABLE void clear();


protected:
    virtual void paint(QPainter *painter);

signals:
    void pointsChanged();
    void colorChanged();

private:
    QPolygon mPoly;
    QColor mColor;
    QQuickPen * mBorder;


};

#endif // POLYGONITEM_H
