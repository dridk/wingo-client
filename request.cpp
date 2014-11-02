#include "request.h"
#include <QDebug>
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
    mUrl.setHost("labsquare.org");
    mUrl.setPort(9000);




}

void Request::setSource(const QString &source)
{
    mSource = source;
    mUrl.setPath(mSource);
    emit sourceChanged();

}

const QString &Request::source()
{
    return mSource;
}

void Request::get(const QVariant &data)
{

    QUrlQuery query;

    foreach (QString key, data.toMap().keys())
        query.addQueryItem(key,data.toMap().value(key).toString());

    mUrl.setQuery(query);

    QNetworkRequest request = makeRequest(mUrl);

    qDebug()<<mUrl;
    QNetworkReply * reply = mManager->get(QNetworkRequest(mUrl));

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
    return request;

}
