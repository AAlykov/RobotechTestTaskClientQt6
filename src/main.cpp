#include "TransferDataHandler.h"
#include "TcpClientHandler.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

static constexpr const quint16 CLIENT_PORT = 8888;
static constexpr const char* const CLIENT_HOST = "127.0.0.1";


int main(int argc, char* argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    TcpClientHandler tcpClientHandler(CLIENT_HOST, CLIENT_PORT);
    TransferDataHandler transferDataHandler(&tcpClientHandler);

    engine.rootContext()->setContextProperty("tcpClientHandler", &tcpClientHandler);
    engine.rootContext()->setContextProperty("transferDataHandler", &transferDataHandler);

    engine.addImportPath("qrc:/qml");
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &app,
        [url](QObject* obj, const QUrl& objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
