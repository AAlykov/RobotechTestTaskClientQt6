#pragma once

#include <QCoreApplication>
#include <QDebug>
#include <QObject>
#include <QProcess>

class Pinger : public QObject
{
    Q_OBJECT
public:
    explicit Pinger(QObject* parent = nullptr);

    void startPing(const QString& address, const quint16 count, const quint16 size);

signals:
    void pingDataChanged(QString);
    void pingerServiceDataChanged(QString);

private slots:
    void readOutput();
    void readError();
    void onFinished(int exitCode, QProcess::ExitStatus exitStatus);

private:
    QProcess* process;
    QString outputProcessMessage;
};
