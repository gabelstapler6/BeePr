import QtQuick 2.15
import QtQuick.Controls 2.15

Slider {
    id: control
    value: 0
    
    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 8
        width: control.availableWidth
        height: implicitHeight
        radius: 2
        color: "#4E4E4E"
    }

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 36
        implicitHeight: 36
        radius: 18
        color: control.pressed ? topColor : topColor
        border.color: "#bdbebf"
    }
}