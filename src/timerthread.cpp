#include "timerthread.h"
#include <QMutexLocker>

TimerThread::TimerThread()
    : QThread()
    , m_unit()
    , m_mutex()
    , m_condition()
{
    m_exit = false;
    m_timerConfig = -1;
    m_remainingTime = -1;
    this->start();
}

TimerThread::~TimerThread()
{
    m_exit = true;
    m_condition.wakeOne();
    this->wait();
}

void TimerThread::configureTimer(int tens, int ones, QString unit)
{
    tens *= 10;
    int num = tens + ones;
    m_unit = unit;
    if (m_unit == "min")
    {
        num *= 60;
    }

    QMutexLocker locker(&m_mutex);
    m_remainingTime = num;
    m_timerConfig = num;
    m_condition.wakeOne();
}

void TimerThread::stopTimer()
{
    QMutexLocker locker(&m_mutex);
    m_remainingTime = -1;
    m_timerConfig = -1;
}

void TimerThread::run()
{
    while (true)
    {
        if (m_exit)
        {
            return;
        }

        if (m_remainingTime == -1)
        {
            m_mutex.lock();
            m_condition.wait(&m_mutex);
        }

        if (m_remainingTime == 0)
        {
            m_remainingTime = m_timerConfig;
            emit playSound();
        }

        {
            QMutexLocker locker(&m_mutex);
            m_remainingTime--;
        }

        convertAndUpdateRemainingTime();

        this->sleep(1000);
    }
}

void TimerThread::convertAndUpdateRemainingTime()
{
    int time = m_remainingTime;
    if (m_unit == "min")
    {
        time /= 60;
        time++;
        if (time == 1)
        {
            time = m_remainingTime;
        }
    }
    emit updateRemainingTime(time);
}
