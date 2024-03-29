#include "request.h"
#include <QDebug>
#include <QNetworkInterface>
#include "app.h"
QNetworkAccessManager * Request::mManager = 0;

Request::Request(QQuickItem *parent) :
    QObject(parent)
{
    qDebug()<<"SET URL";


    if (mManager == 0)
    {
        mManager = new QNetworkAccessManager;
    }


    mUrl.setScheme("http");
#ifdef Q_OS_ANDROID
    mUrl.setHost("wingo.labsquare.org");
    mUrl.setPort(80);
#else
    mUrl.setHost("localhost");
    mUrl.setPort(5000);
#endif








}

void Request::setSource(const QString &source)
{
    mSource = source;
    mUrl.setPath(mSource);
    emit sourceChanged();

}

int Request::port()
{
    return mUrl.port();
}

const QString &Request::source()
{
    return mSource;
}

QString Request::host()
{
    return mUrl.host();
}

void Request::get(const QVariant &data)
{

    QUrlQuery query;

    foreach (QString key, data.toMap().keys()){
        if (!data.toMap().value(key).isNull()){
            query.addQueryItem(key,data.toMap().value(key).toString());
        }
    }

    mUrl.setQuery(query);

    QNetworkRequest request = makeRequest(mUrl);
    request.setRawHeader("Content-Type","Content-type: text/plain");
    QNetworkReply * reply = mManager->get(request);

    connect(reply,SIGNAL(finished()),this,SLOT(parseFinished()));

    connect(reply,SIGNAL(error(QNetworkReply::NetworkError)),this,
            SLOT(parseError(QNetworkReply::NetworkError)));


}

void Request::post(const QVariant &data)
{

    QJsonDocument doc = QJsonDocument::fromVariant(data);
    QNetworkRequest request = makeRequest(mUrl);
    QNetworkReply * reply = mManager->post(request, doc.toJson());

    connect(reply,SIGNAL(finished()),this,SLOT(parseFinished()));

    connect(reply,SIGNAL(error(QNetworkReply::NetworkError)),this,
            SLOT(parseError(QNetworkReply::NetworkError)));



}

void Request::put(const QVariant &data)
{
    QJsonDocument doc = QJsonDocument::fromVariant(data);
    QNetworkRequest request = makeRequest(mUrl);
    QNetworkReply * reply = mManager->put(request, doc.toJson());

    connect(reply,SIGNAL(finished()),this,SLOT(parseFinished()));

    connect(reply,SIGNAL(error(QNetworkReply::NetworkError)),this,
            SLOT(parseError(QNetworkReply::NetworkError)));

}

void Request::deleteResource(const QVariant &data)
{

    QNetworkRequest request = makeRequest(mUrl);
    QNetworkReply * reply = mManager->deleteResource(request);

    connect(reply,SIGNAL(finished()),this,SLOT(parseFinished()));

    connect(reply,SIGNAL(error(QNetworkReply::NetworkError)),this,
            SLOT(parseError(QNetworkReply::NetworkError)));


}

void Request::patch(const QVariant &data)
{

}

void Request::parseFinished()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());

    if (doc.object().contains("success")){

        if (doc.object().value("success").toBool()){
            emit success(doc.object());
            return;
        }
        else {

            emit error(1, doc.object().value("message").toString());
            return;
        }
    }
    emit error(1, reply->errorString());
    reply->deleteLater();
    qDebug()<<reply->errorString();

}

void Request::parseError(QNetworkReply::NetworkError err)
{

    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());


    emit error(1, reply->errorString());
    reply->deleteLater();



}

QNetworkRequest Request::makeRequest(const QUrl &url)
{
    QNetworkRequest request(url);
    request.setRawHeader("Content-Type","application/json");
    request.setRawHeader("FROM",App::getDeviceId().toUtf8());
    return request;

}
