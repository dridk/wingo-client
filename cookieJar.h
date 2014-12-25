/*
 * CookieJar.h
 *
 *  Created on: 27 janv. 2013
 *      Author: sacha
 */

#ifndef COOKIEJAR_H_
#define COOKIEJAR_H_
#include <QNetworkCookieJar>
#include <QList>
#include <QSettings>
#include <QtNetwork>
#include <QHash>



class CookieJar : public QNetworkCookieJar {
public:
	CookieJar(QObject * parent = 0);
	virtual ~CookieJar();

	 QList <QNetworkCookie>	cookiesForUrl ( const QUrl & url ) const;
	 bool setCookiesFromUrl ( const QList<QNetworkCookie> & cookieList, const QUrl & url );
	 void removeLocalCookies();

private:
    QList<QNetworkCookie> mCurrentCookies;
	QSettings mSettings;



};
#endif /* COOKIEJAR_H_ */
