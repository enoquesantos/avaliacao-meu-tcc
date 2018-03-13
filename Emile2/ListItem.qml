import QtQuick 2.9
import QtQuick.Controls 2.2

ItemDelegate {
    id: rootItem
    width: parent.width; height: visible ? 50 : 0

    property url img
    property string title
    property string description
    property bool showSeparator: false

    Row {
        spacing: 30
        anchors { left: parent.left; right: parent.right; margins: 15; verticalCenter: parent.verticalCenter }

        Image {
            id: _image
            source: rootItem.img
            width: 30; height: width
            asynchronous: true; cache: true
            anchors.verticalCenter: parent.verticalCenter
        }

        Column {
            spacing: 5
            anchors.verticalCenter: parent.verticalCenter

            Text {
                id: _text
                text: rootItem.title
                font.pointSize: 14
            }

            Text {
                id: _description
                text: rootItem.description
                font.pointSize: 10; opacity: 0.8
            }
        }
    }

    Rectangle {
        id: _separator
        visible: rootItem.showSeparator
        width: parent.width; height: 1
        color: "#000"; opacity: 0.1
        anchors.bottom: parent.bottom
    }
}
