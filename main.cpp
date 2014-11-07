#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "request.h"
#include "polygonitem.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<Request>("Wingo",1,0,"Request");
    qmlRegisterType<PolygonItem>("Wingo",1,0,"PolygonItem");
    app.setApplicationName("Wingo - Xu Fu");
    app.setOrganizationDomain("localhost");
    app.setApplicationVersion("0.1.0-alpha");


    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}
