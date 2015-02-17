/****************************************************************************
**
** Copyright (C) 2014 Digia Plc
** All rights reserved.
** For any questions to Digia, please use contact form at http://qt.digia.com <http://qt.digia.com/>
**
** This file is part of the Qt Native Client platform plugin.
**
** No Commercial Usage
** This file contains pre-release code and may not be distributed.
** You may use this file in accordance with the terms and conditions
** contained in the Technology Preview License Agreement accompanying
** this package.
**
** If you have questions regarding the use of this file, please use
** contact form at http://qt.digia.com <http://qt.digia.com/>
**
****************************************************************************/

#ifndef QPEPPERPLATFORMWINDOW_H
#define QPEPPERPLATFORMWINDOW_H

#include "qpepperhelpers.h"
#include "qpeppercompositor.h"
#include "qpepperintegration.h"

#include <qpa/qplatformwindow.h>

QT_BEGIN_NAMESPACE

Q_DECLARE_LOGGING_CATEGORY(QT_PLATFORM_PEPPER_WINDOW)

class QPepperWindowSurface;
class QPepperGLContext;
class QPepperPlatformWindow : public QPlatformWindow
{
public:
    QPepperPlatformWindow(QWindow *window);
    ~QPepperPlatformWindow();

    WId winId() const;
    void setVisible(bool visible);
    void setWindowState(Qt::WindowState state);
    void raise();
    void lower();
    void setGeometry(const QRect &rect);
    void setParent(const QPlatformWindow *window);

    bool setKeyboardGrabEnabled(bool grab);
    bool setMouseGrabEnabled(bool grab);

    qreal devicePixelRatio() const;

    bool m_isVisible;
    bool m_trackInstanceSize;

private:
    QPepperIntegration *m_pepperIntegration;
    QPepperCompositor *m_compositor;
};

QT_END_NAMESPACE

#endif
