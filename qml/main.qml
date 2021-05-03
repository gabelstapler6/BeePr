import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
 import QtQuick.Layouts 1.15

Window {
    width: 720
    height: 1280
    visible: true
    title: qsTr("BeePr")

    property var beePrs: [first, second, third]
    
    Rectangle {
        id: bg
        anchors.fill: parent
        color: "gray"
    }

    Text {
        id: currentIntervalText
        text: {
            let val = beePrs[slider.value]._value
            return String(val[0]) + String(val[1]) + " " + val[2]
        }
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: intervalRow.top
        anchors.top: parent.top

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        font.pointSize: 36
    }

    RowLayout {
        id: intervalRow
        anchors.bottom: slider.top
        anchors.bottomMargin: 16
        anchors.left: parent.left
        anchors.leftMargin: 18
        anchors.right: parent.right
        anchors.rightMargin: anchors.leftMargin    
        
        spacing: 12
        BeePrInterval {
            id: first
            Layout.fillWidth: true
            defaultValue: [3, 0, "sec"]
            enabled: slider.value === 0
        }

        BeePrInterval {
            id: second
            Layout.fillWidth: true
            defaultValue: [0, 3, "min"]
            enabled: slider.value === 1
        }

        BeePrInterval {
            id: third
            Layout.fillWidth: true
            defaultValue: [0, 5, "min"]
            enabled: slider.value === 2
        }
    }


    BeePrSlider {
        id: slider
        from: 0
        to: 2
        snapMode: Slider.SnapAlways
        stepSize: 1

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: first.height/2
        anchors.leftMargin: first.width/2
        anchors.rightMargin: first.width/2
    }
}
