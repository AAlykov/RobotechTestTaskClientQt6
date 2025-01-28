#include "Pinger.h"

Pinger::Pinger(QObject* parent): QObject{parent}
{
    process = new QProcess(this);
    connect(process, &QProcess::readyReadStandardOutput, this, &Pinger::readOutput);
    connect(process, &QProcess::readyReadStandardError, this, &Pinger::readError);
    connect(process, QOverload<int, QProcess::ExitStatus>::of(&QProcess::finished), this, &Pinger::onFinished);
}

void Pinger::startPing(const QString& address, const quint16 count, const quint16 size)
{
    if (process->state() == QProcess::Running)
    {
        qDebug() << "The process is already running";
        emit pingerServiceDataChanged(tr("The process is already running"));
        return;
    }

    QStringList arguments;
#ifdef Q_OS_WIN
    arguments << "-n" << QString::number(count) << "-l" << QString::number(size) << address;
    process->start("ping", arguments);
#else
    arguments << "-c" << QString::number(count) << "-s" << QString::number(size) << address;
    process->start("/bin/ping", arguments);
#endif

    if (!process->waitForStarted())
    {
        qCritical() << "The ping process could not be started";
        emit pingerServiceDataChanged(tr("The ping process could not be started"));
    }
    else
    {
        qDebug() << "The ping process is running for the address: " << address;
        emit pingerServiceDataChanged("The ping process is running for the address: " + address);
        outputProcessMessage = "";
    }
}

void Pinger::readOutput()
{
    QByteArray output = process->readAllStandardOutput();
    outputProcessMessage += QString::fromUtf8(output);

    emit pingDataChanged(outputProcessMessage);
}

void Pinger::readError()
{
    auto error = process->readAllStandardError();
    if (!error.isEmpty())
    {
        qWarning() << "Error: " << error;
        emit pingerServiceDataChanged(tr("Error: ") + error);
    }
}

void Pinger::onFinished(int exitCode, QProcess::ExitStatus exitStatus)
{
    if (exitStatus == QProcess::NormalExit)
    {
        qDebug() << "The process was completed successfully. Exit code: " << exitCode;
    }
    else
    {
        qWarning() << "The process ended with an error. Exit code: " << exitCode;
    }
}
