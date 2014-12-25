/*
 * CookieJar.cpp
 *
 *  Created on: 27 janv. 2013
 *      Author: sacha
 */

#include "cookieJar.h"
#include <QDebug>
#include <QStringList>
#include <QCoreApplication>

CookieJar::CookieJar(QObject *parent)
    :QNetworkCookieJar(parent)
{


    QByteArray raw = mSettings.value("cookie").toByteArray();

    if (!raw.isEmpty()){
       mCurrentCookies = QNetworkCookie::parseCookies(raw);
    }


}

CookieJar::~CookieJar() {
    // TODO Auto-generated destructor stub
}


QList<QNetworkCookie> CookieJar::cookiesForUrl(const QUrl& url) const {

    Q_UNUSED(url)
    return mCurrentCookies;


}

bool CookieJar::setCookiesFromUrl(const QList<QNetworkCookie>& cookieList,const QUrl& url) {

    Q_UNUSED(url);

    if (cookieList.isEmpty())
        return false;

    mCurrentCookies = cookieList;


    if (mCurrentCookies.length() >= 1) {

        mSettings.setValue("cookie", mCurrentCookies.first().toRawForm());

    }



    return true;

}

void CookieJar::removeLocalCookies() {

}




