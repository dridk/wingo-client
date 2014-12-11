#ifndef APP_H
#define APP_H

#include <QObject>
#include <QSettings>

class App : public QObject
{
    Q_OBJECT
public:
    explicit App(QObject *parent = 0);


    Q_INVOKABLE static QString getDeviceId();

    Q_INVOKABLE void setConfig(const QString& key, QVariant value);
    Q_INVOKABLE QVariant getConfig(const QString& key);


signals:
    void configChanged(const QString& key);

    private:
    QSettings mSettings;
};

#endif // APP_H
