#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFontDatabase>
#include <QFile>
#include <QDebug>
#include "request.h"
#include "polygonitem.h"
#include "painteritem.h"
#include "maskimage.h"
#include "app.h"
#include "restmodel.h"
#include "unit.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

 App::setDomain("wingo.labsquare.org",80);
//  App::setDomain("localhost",5000);


    qmlRegisterType<Request>("Wingo",1,0,"Request");
    qmlRegisterType<PolygonItem>("Wingo",1,0,"PolygonItem");
    qmlRegisterType<PainterItem>("Wingo",1,0,"PainterItem");
    qmlRegisterType<MaskImage>("Wingo",1,0,"MaskImage");
    qmlRegisterType<RestModel>("Wingo",1,0,"RestModel");
//    qmlRegisterType<Unit>("Wingo",1,0,"ResolutionManager2");

    app.setApplicationName("Wingo");
    app.setOrganizationDomain("localhost");
    app.setApplicationVersion("0.2.1 Thorfinn");




    qDebug()<<app.applicationFilePath();
    QFontDatabase fontdb;

    fontdb.addApplicationFont(":/qml/Res/icons/icons.ttf");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("wingo", App::instance());
#if ((defined(Q_OS_LINUX) && !defined(Q_OS_ANDROID)) || defined(Q_OS_OSX) || defined(Q_OS_WINDOWS))
    engine.rootContext()->setContextProperty("U", new Unit(QSize(540,960)));
#else
    engine.rootContext()->setContextProperty("U", new Unit());
#endif
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}
