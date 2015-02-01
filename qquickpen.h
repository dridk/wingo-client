#ifndef QQUICKPEN_H
#define QQUICKPEN_H

#include <QObject>
#include <QColor>


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




#endif // QQUICKPEN_H
