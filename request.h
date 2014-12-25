#ifndef REQUEST_H
#define REQUEST_H

#include <QObject>
#include <QQuickItem>
#include <QtNetwork>
#include <QJsonDocument>
#include <QHttpMultiPart>

class Request : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY (bool isLoading READ isLoading NOTIFY isLoadingChanged)
    Q_PROPERTY (double downloadProgress READ downloadProgress NOTIFY downloadProgressChanged)




public:
    explicit Request(QQuickItem *parent = 0);



    void setSource(const QString& source);
    const QString& source();
    Q_INVOKABLE QString host();
    Q_INVOKABLE int port() ;
    bool isLoading();
    double downloadProgress();



public slots:
    void get(const QJsonValue& data = QJsonValue());
    void post(const QJsonValue& data= QJsonValue());
    void put(const QJsonValue& data= QJsonValue());
    void deleteResource();
    void patch(const QJsonValue& data= QJsonValue());
    void postImage(const QString&);

protected:
    void connectReply(QNetworkReply * reply);
    void setLoading(bool enabled);
private slots:
    void parseFinished();
    void parseError(QNetworkReply::NetworkError err);
    void setDownloadProgress(qint64 value, qint64 total);

private:
    QNetworkRequest makeRequest(const QUrl& url);

signals:
    void success(QJsonObject data);
    void error(int code, QString message);
    void sourceChanged();
    void isLoadingChanged();
    void downloadProgressChanged();

private:
    QUrl mUrl;
    QString mSource;
    static QNetworkAccessManager * mManager;
    bool mIsLoading;
    double mDownloadProgress;
    bool mDebug;


};

#endif // REQUEST_H
