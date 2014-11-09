#ifndef APP_H
#define APP_H

#include <QObject>

class App : public QObject
{
    Q_OBJECT
public:
    explicit App(QObject *parent = 0);


    Q_INVOKABLE static QString getDeviceId();

};

#endif // APP_H
