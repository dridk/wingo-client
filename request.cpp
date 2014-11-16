#include "request.h"
#include <QDebug>
#include <QNetworkInterface>
#include <QFileInfo>
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




    mIsLoading = false;
    mDownloadProgress = 0;



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

bool Request::isLoading()
{
    return mIsLoading;
}

double Request::downloadProgress()
{
    return mDownloadProgress;
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

    connectReply(reply);



}

void Request::post(const QVariant &data)
{

    QJsonDocument doc = QJsonDocument::fromVariant(data);
    QNetworkRequest request = makeRequest(mUrl);
    QNetworkReply * reply = mManager->post(request, doc.toJson());

    connectReply(reply);




}

void Request::put(const QVariant &data)
{
    QJsonDocument doc = QJsonDocument::fromVariant(data);
    QNetworkRequest request = makeRequest(mUrl);
    QNetworkReply * reply = mManager->put(request, doc.toJson());

    connectReply(reply);


}

void Request::deleteResource(const QVariant &data)
{

    QNetworkRequest request = makeRequest(mUrl);
    QNetworkReply * reply = mManager->deleteResource(request);

    connectReply(reply);



}

void Request::patch(const QVariant &data)
{

}

void Request::postImage(const QString &filename)
{

    // Open File....
    QFile *file = new QFile(filename);
    QFileInfo info(file->fileName());

    if (!file->exists()){
        qDebug()<<"file doesn't exists...";
        emit error(-1,"ocal file doesn't exists");
        return;
    }
    file->open(QIODevice::ReadOnly);


    //Create multipart request
    QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);

    //Create image part
    QHttpPart imagePart;
    imagePart.setHeader(QNetworkRequest::ContentTypeHeader, QString("image/%1").arg(info.suffix()));
    imagePart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"picture\""));
    imagePart.setBodyDevice(file);


    imagePart.setHeader(QNetworkRequest::ContentDispositionHeader,QString( "form-data; name=\"picture\"; filename=\"%1\"").arg(info.fileName()));

    QString boundary = "--"+ QString::number( qrand() * (90000000000) / (RAND_MAX + 1) + 10000000000, 16);
    multiPart->setBoundary(boundary.toUtf8());
    multiPart->append(imagePart);
    file->setParent(multiPart); // we cannot delete the file now, so delete it with the multiPart


    QNetworkRequest request(mUrl);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "multipart/form-data; boundary=" + boundary);


    QNetworkReply *reply = mManager->post(request, multiPart);
    multiPart->setParent(reply);
    connectReply(reply);

}



void Request::parseFinished()
{
    setLoading(false);
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

    setLoading(false);
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());
    emit error(1, reply->errorString());
    reply->deleteLater();



}

void Request::setDownloadProgress(qint64 value, qint64 total)
{
    mDownloadProgress = total == -1 ? 0: value / total;
    emit downloadProgressChanged();

}

QNetworkRequest Request::makeRequest(const QUrl &url)
{
    QNetworkRequest request(url);
    request.setRawHeader("Content-Type","application/json;charset=UTF-8");
    request.setRawHeader("FROM",App::getDeviceId().toUtf8());
    return request;

}
void Request::connectReply(QNetworkReply *reply)
{

    setLoading(true);
    connect(reply,SIGNAL(finished()),this,SLOT(parseFinished()));
    connect(reply,SIGNAL(error(QNetworkReply::NetworkError)),this,SLOT(parseError(QNetworkReply::NetworkError)));
    connect(reply,SIGNAL(downloadProgress(qint64,qint64)),this,SLOT(setDownloadProgress(qint64,qint64)));

}

void Request::setLoading(bool enabled)
{
    mIsLoading = enabled;
    emit isLoadingChanged();
}
