#include "TcpClientHandler.h"

TcpClientHandler::TcpClientHandler(QString host, quint16 port, QObject* parent)
    : QObject{parent}
    , _host(host)
    , _port(port)
    , socket(new QTcpSocket(this))
{
    connect(socket, &QTcpSocket::connected, this, &TcpClientHandler::onConnected);
    connect(socket, &QTcpSocket::disconnected, this, &TcpClientHandler::onDisconnected);
    connect(socket, &QTcpSocket::readyRead, this, &TcpClientHandler::onReadyRead);
    connect(socket, QOverload<QAbstractSocket::SocketError>::of(&QTcpSocket::errorOccurred), this,
            &TcpClientHandler::onErrorOccurred);
}

void TcpClientHandler::connectToServer()
{
    if (socket->isOpen())
    {
        qDebug() << "Already connected to a server. Disconnecting first.";
        disconnectFromServer();
    }
    qDebug() << "Connecting to server:" << _host << ":" << _port;
    emit serviceDataChanged("Connecting to server: " + _host + ":" + QString::number(_port));
    socket->connectToHost(_host, _port);
}

void TcpClientHandler::disconnectFromServer()
{
    if (socket->isOpen())
    {
        socket->disconnectFromHost();
    }
}

void TcpClientHandler::setHost(const QString& host) noexcept
{
    _host = host;
}

QString TcpClientHandler::getHost() const noexcept
{
    return _host;
}

void TcpClientHandler::setPort(quint16 port) noexcept
{
    _port = port;
}

quint16 TcpClientHandler::getPort() const noexcept
{
    return _port;
}

void TcpClientHandler::sendMessage(const QString& message)
{
    if (socket->isOpen() && socket->state() == QAbstractSocket::ConnectedState)
    {
        socket->write(message.toUtf8());
        socket->flush();
        qDebug() << "Message sent:" << message;
    }
    else
    {
        emit serviceDataChanged(tr("Unable to send message. No connection established."));
        qWarning() << "Unable to send message. No connection established.";
    }
}

void TcpClientHandler::onConnected()
{
    qDebug() << "Connected to server.";
    emit serviceDataChanged("Connected to server");
    emit connected();
}

void TcpClientHandler::onDisconnected()
{
    qDebug() << "Disconnected from server.";
    emit serviceDataChanged("Disconnected from server");
    emit disconnected();
}

void TcpClientHandler::onReadyRead()
{
    while (socket->canReadLine())
    {
        QString message = QString::fromUtf8(socket->readLine()).trimmed();
        qDebug() << "Message received:" << message;
        emit messageReceived(message);
    }
}

void TcpClientHandler::onErrorOccurred(QAbstractSocket::SocketError socketError)
{
    QString errorString = socket->errorString();
    emit serviceDataChanged(tr("Socket error: ") + errorString);
    qWarning() << "Socket error:" << errorString;
    emit errorOccurred(errorString);
}

TcpClientHandler::~TcpClientHandler()
{
    disconnectFromServer();
    delete socket;
}
