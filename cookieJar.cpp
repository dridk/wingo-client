/*
 * CookieJar.cpp
 *
 *  Created on: 27 janv. 2013
 *      Author: sacha
 */

#include "cookieJar.h"
#include <QDebug>
#include <QStringList>

CookieJar::CookieJar(QObject *parent)
:QNetworkCookieJar(parent)
{

	foreach (QString key, mSettings.allKeys())
	{

	QByteArray array = mSettings.value(key).toByteArray();
	QNetworkCookie cookie = QNetworkCookie::parseCookies(array).first();

	mCurrentCookies[cookie.name()] = cookie;


	}


}

CookieJar::~CookieJar() {
	// TODO Auto-generated destructor stub
}


QList<QNetworkCookie> CookieJar::cookiesForUrl(const QUrl& url) const {


	return mCurrentCookies.values();


}

bool CookieJar::setCookiesFromUrl(const QList<QNetworkCookie>& cookieList,const QUrl& url) {

	Q_UNUSED(url);

	if (cookieList.isEmpty())
		return false;

	foreach (QNetworkCookie cookie, cookieList)
	{
		mCurrentCookies[cookie.name()] = cookie;
		mSettings.setValue(cookie.name(), cookie.toRawForm());
	}




	return true;

}

void CookieJar::removeLocalCookies() {

}




