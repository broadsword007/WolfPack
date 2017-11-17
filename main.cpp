#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QApplication>
#include "operationshandler.h"
#include <QQmlContext>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    OperationsHandler* handler= new OperationsHandler() ;
    //handler->setup_database();
    engine.rootContext()->setContextProperty("operationsHandler", handler);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
