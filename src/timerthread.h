#ifndef TIMERTHREAD_H
#define TIMERTHREAD_H

#include <QMutex>
#include <QThread>
#include <QWaitCondition>

class TimerThread : public QThread
{
    Q_OBJECT

  public:
    TimerThread();
    ~TimerThread();

    Q_INVOKABLE void configureTimer(int tens, int ones, QString unit);
    Q_INVOKABLE void stopTimer();

  signals:
    void updateRemainingTime(int);

    void playSound();

  protected:
    void run() override;

  private:
    bool m_exit;

    int m_timerConfig;

    int m_remainingTime;
    QString m_unit;
    QMutex m_mutex;
    QWaitCondition m_condition;

    void convertAndUpdateRemainingTime();
};

#endif // TIMERTHREAD_H
