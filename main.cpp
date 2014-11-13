#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFontDatabase>
#include <QFile>
#include <QDebug>
#include "request.h"
#include "polygonitem.h"
#include "app.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<Request>("Wingo",1,0,"Request");
    qmlRegisterType<PolygonItem>("Wingo",1,0,"PolygonItem");
    app.setApplicationName("Wingo");
    app.setOrganizationDomain("localhost");
    app.setApplicationVersion("0.1.0 alpha XuFu");


    qDebug()<<app.applicationFilePath();
    QFontDatabase fontdb;

    fontdb.addApplicationFont(":/qml/Res/icons/icons.ttf");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("wingo", new App());
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}
