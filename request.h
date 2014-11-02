#ifndef REQUEST_H
#define REQUEST_H

#include <QObject>
#include <QQuickItem>
#include <QtNetwork>
#include <QJsonDocument>

class Request : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)
public:
    explicit Request(QQuickItem *parent = 0);



    void setSource(const QString& source);
    const QString& source();

public slots:
    void get(const QVariant& data = QVariant());
    void post(const QVariant& data= QVariant());
    void put(const QVariant& data= QVariant());
    void deleteResource(const QVariant& data= QVariant());
    void patch(const QVariant& data= QVariant());


private slots:
    void parseFinished();
    void parseError(QNetworkReply::NetworkError err);

private:
    QNetworkRequest makeRequest(const QUrl& url);

signals:
    void success(QVariant data);
    void error(int code, QString message);
    void sourceChanged();

private:
    QUrl mUrl;
    QString mSource;
    static QNetworkAccessManager * mManager;


};

#endif // REQUEST_H
