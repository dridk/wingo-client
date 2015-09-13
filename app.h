#ifndef APP_H
#define APP_H

#include <QObject>
#include <QSettings>

class App : public QObject
{
    Q_OBJECT
public:
    static App *instance();

    Q_INVOKABLE static QString getDeviceId();
    Q_INVOKABLE static void setConfig(const QString& key, QVariant value);
    Q_INVOKABLE static QVariant getConfig(const QString& key);
    Q_INVOKABLE QString host() const;
    Q_INVOKABLE int port() const;

    Q_INVOKABLE void cropImage(const QString& filename, int size = 600);

    static void setDomain(const QString& host, int port);

    void setHost(const QString& hostname);
    void setPort(int port);

private:
    explicit App(QObject *parent = 0);



signals:
    void configChanged(const QString& key);

private:
    QSettings mSettings;
    static App* mInstance;
    QString mHost;
    QString mPrefix;
    int mPort;



};

#endif // APP_H
