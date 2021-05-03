import QtQuick 2.12
import QtQml 2.15
import QtQuick.Controls 2.15
import QtMultimedia 5.15

Item {
    id: selector

    property var visibleItemCount: 3

    property var defaultValue: [1,0,"sec"] // tumbler values

    property var enabled: false
    
    
    signal remaining(string text)
    

    width: 100
    height: 200

    Component {
        id: delegateComponent

        Label {
            text: modelData
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (visibleItemCount / 2)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 14
            font.family: "Helvetica"
            color: topColor
        }
    }

    Rectangle {
        id: frame
        color: "#A73A3A"
        anchors.fill: parent
        radius: 20

        Rectangle {
            anchors.fill: parent
            color: "#8F3333"
            radius: 62
        }        

        Row {
        id: row
        anchors.centerIn: parent
        
            Tumbler {
                id: tens
                width: selector.width/3
                height: selector.height
                model: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                delegate: delegateComponent
                currentIndex: defaultValue[0]
            }

            Tumbler {
                id: nums
                width: selector.width/3
                height: selector.height
                model: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                delegate: delegateComponent
                currentIndex: defaultValue[1]
            }

            Tumbler {
                id: durs
                width: selector.width/3
                height: selector.height
                model: ["sec", "min"]
                delegate: delegateComponent
                currentIndex: model.indexOf(defaultValue[2])
            }
        }
    }

    
    
    property var _value: [tens.currentIndex, nums.currentIndex, durs.model[durs.currentIndex]]
    
    // value in seconds until next beep
    property var value: valueFromTumblers(_value)
    
    function valueFromTumblers(values) {
        if(values.length !== 3){
            return -1
        }

        let num = values[0]*10 + values[1]

        switch(values[2]){
            case "min": num *= 60
                break
            default:
        }
        return num
    }

    Timer {
        interval: value*1000
        repeat: true
        running: enabled
        onTriggered: {
            beePr.play()
        }
    }

    SoundEffect {
        id: beePr
        source: "piepserFuerGaybel.wav"
    }
    
}