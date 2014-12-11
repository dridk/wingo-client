#include "app.h"
#include <QNetworkInterface>
#include <QCoreApplication>
App::App(QObject *parent) :
    QObject(parent)
{
    mSettings.beginGroup(qApp->applicationName());
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

void App::setConfig(const QString &key, QVariant value)
{

    if ( value != mSettings.value(key)) {

        mSettings.setValue(key, value);
        emit configChanged(key);
    }

}

QVariant App::getConfig(const QString &key)
{

    return mSettings.value(key);

}
