#include "app.h"
#include <QNetworkInterface>
#include <QCoreApplication>

App * App::mInstance = NULL;

App::App(QObject *parent) :
    QObject(parent)
{
}


App *App::instance()
{

if (mInstance == NULL) {
    mInstance = new App();
}
return mInstance;
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

    QSettings settings;
    settings.beginGroup(qApp->applicationName());


    if ( value != settings.value(key)) {

        settings.setValue(key, value);
        emit instance()->configChanged(key);
    }

}

QVariant App::getConfig(const QString &key)
{
    QSettings settings;
    settings.beginGroup(qApp->applicationName());

    return settings.value(key);

}

QString App::host() const
{
return mHost;
}

int App::port() const
{
    return mPort;
}

void App::setDomain(const QString &host, int port)
{
    instance()->setHost(host);
    instance()->setPort(port);
}

void App::setHost(const QString &hostname)
{

    mHost = hostname;

}

void App::setPort(int port)
{

    mPort = port;

}


