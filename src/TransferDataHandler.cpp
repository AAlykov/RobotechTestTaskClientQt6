#include "TransferDataHandler.h"

void printFormattedHex(const QByteArray& data)
{
    const int bytesPerLine = 16;

    QString result;
    for (int i = 0; i < data.size(); i += bytesPerLine)
    {
        QByteArray line = data.mid(i, bytesPerLine);      
        QString offset = QString("%1").arg(i, 8, 16, QChar('0')).toUpper();

        QString hexBytes = line.toHex(' ').toUpper();       
        QString asciiText;
        for (char byte : line)
        {
            asciiText += (byte >= 32 && byte <= 126) ? byte : '.';
        }
        result += offset + ": " + hexBytes + " | " + asciiText + "\n";
        qDebug() << offset << ": " << hexBytes << " | " << asciiText;
    }
}

TransferDataHandler::TransferDataHandler(TcpClientHandler* tcpClientHandler,
                                         QObject* parent)
    : QObject{parent}
    , _tcpClientHandler(tcpClientHandler)
{
    connect(_tcpClientHandler, &TcpClientHandler::serviceDataChanged, this,
            &TransferDataHandler::handleServiceDataChanged);

    _pinger = new Pinger();
    connect(_pinger, &Pinger::pingDataChanged, this, &TransferDataHandler::handlePingDataChanged);
    connect(_pinger, &Pinger::pingerServiceDataChanged, this, &TransferDataHandler::handleServiceDataChanged);
}

QStringList TransferDataHandler::serviceData() const noexcept
{
    return _serviceDataList;
}

QString TransferDataHandler::data() const noexcept
{
    return _transferData;
}

QString TransferDataHandler::dataHex() const noexcept
{
    return _transferDataHex;
}

QString TransferDataHandler::dataPing() const noexcept
{
    return _transferDataPing;
}

void TransferDataHandler::ping(const QString& address, const quint16 count, const quint16 size)
{
    _pinger->startPing(address, count, size);
}

void TransferDataHandler::handleDataChanged(const QByteArray& data)
{
    _transferData = QString::fromUtf8(data);
    _transferDataHex = QString::fromUtf8(data.toHex(' '));
    printFormattedHex(data);

    emit dataChanged();
    emit dataHexChanged();
}

void TransferDataHandler::handleServiceDataChanged(const QString& data)
{
    _serviceDataList.append(QDateTime::currentDateTime().toString("dd.MM.yyyy hh:mm:ss") + " | " + data);
    emit serviceDataChanged();
}

void TransferDataHandler::handlePingDataChanged(const QString& data)
{
    _transferDataPing = data;
    emit dataPingChanged();
}

TransferDataHandler::~TransferDataHandler()
{
    _pinger->deleteLater();
}
