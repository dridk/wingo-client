#include "request.h"
#include <QDebug>
QNetworkAccessManager * Request::mManager = new QNetworkAccessManager();

Request::Request(QQuickItem *parent) :
    QObject(parent)
{
    qDebug()<<"SET URL";


    mUrl.setScheme("http");
    mUrl.setHost("localhost");
    mUrl.setPort(5000);




}

void Request::setSource(const QString &source)
{
    mSource = source;
    emit sourceChanged();

}

const QString &Request::source()
{
    return mSource;
}

void Request::get(const QVariant &data)
{


    mUrl.setPath(mSource);

    QUrlQuery query;

    foreach (QString key, data.toMap().keys())
    {
       query.addQueryItem(key,data.toMap().value(key).toString());
    }





    mUrl.setQuery(query);

    QNetworkRequest request = makeRequest(mUrl);

    qDebug()<<mUrl;
    QNetworkReply * reply = mManager->get(request);

    connect(reply,SIGNAL(finished()),this,SLOT(parseFinished()));

    connect(reply,SIGNAL(error(QNetworkReply::NetworkError)),this,
            SLOT(parseError(QNetworkReply::NetworkError)));








}

void Request::post(const QVariant &data)
{

}

void Request::put(const QVariant &data)
{

}

void Request::deleteResource(const QVariant &data)
{

}

void Request::patch(const QVariant &data)
{

}

void Request::parseFinished()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
    qDebug()<<"cpp: "<<doc.object();
    emit success(doc.object());

}

void Request::parseError(QNetworkReply::NetworkError err)
{

    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    qDebug()<<reply->readAll();
    QVariant results = reply->readAll();
    emit error(1, "results");


}

QNetworkRequest Request::makeRequest(const QUrl &url)
{

    return QNetworkRequest(url);

}
