#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    // Do not forget to add it from wingo.pro ! Otherwise no autocompletion
    engine.addImportPath(QStringLiteral(":/qml"));


    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    qDebug()<<engine.importPathList();

    return app.exec();
}

