TEMPLATE = app

QT += qml quick network positioning

SOURCES += main.cpp \
    app.cpp \
    request.cpp \
    polygonitem.cpp \
    painteritem.cpp \
    cookieJar.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    app.h \
    request.h \
    polygonitem.h \
    painteritem.h \
    cookieJar.h

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += \
    android/AndroidManifest.xml
