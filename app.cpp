#include "app.h"
#include <QNetworkInterface>
App::App(QObject *parent) :
    QObject(parent)
{
}

QString App::getDeviceId()
{
    foreach(QNetworkInterface interface, QNetworkInterface::allInterfaces())
       {
           // Return only the first non-loopback MAC Address
           if (!(interface.flags() & QNetworkInterface::IsLoopBack))
               return interface.hardwareAddress();
       }

    return "0:0:0:0";

}
