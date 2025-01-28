#pragma once

#include <QObject>
#include <QTcpSocket>

class TcpClientHandler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString host READ getHost WRITE setHost NOTIFY hostChanged)
    Q_PROPERTY(quint16 port READ getPort WRITE setPort NOTIFY portChanged)

public:
    explicit TcpClientHandler(QString host, quint16 port, QObject* parent = nullptr);
    ~TcpClientHandler();

    Q_INVOKABLE void connectToServer();
    Q_INVOKABLE void sendMessage(const QString& message);
    Q_INVOKABLE void disconnectFromServer();

    void setHost(const QString& host) noexcept;
    QString getHost() const noexcept;
    void setPort(const quint16 port) noexcept;
    quint16 getPort() const noexcept;

signals:
    void connected();
    void disconnected();
    void messageReceived(const QString& message);
    void errorOccurred(const QString& error);
    void serviceDataChanged(const QString&);

    void hostChanged();
    void portChanged();

private slots:
    void onConnected();
    void onDisconnected();
    void onReadyRead();
    void onErrorOccurred(QAbstractSocket::SocketError socketError);

private:
    QTcpSocket* socket;
    QString _host;
    quint16 _port = 8888;
};
