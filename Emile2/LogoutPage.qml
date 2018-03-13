import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    id: page
    title: qsTr("Logout")
    state: "popPage"
    objectName: "LogoutPage.qml"

    // countdown to pop the logout page
    // on triggered, send user to login page, put 'settings.userProfile' value to null
    Timer {
        id: timer
        interval: 2000
        onRunningChanged: if (running) busyIndicator.visible = true
        onTriggered: settings.userProfile = null
    }

    BusyIndicator {
        id: busyIndicator
        visible: timer.running
        anchors.centerIn: parent
    }

    Label {
        id: label
        visible: timer.running
        text: qsTr("Good bye!")
        color: "red"
        opacity: 0.7; font { pointSize: 20; bold: true }
        anchors { bottom: parent.bottom; bottomMargin: 20; horizontalCenter: parent.horizontalCenter }
    }

    Column {
        id: actionColumn
        anchors.centerIn: parent
        spacing: 50; visible: !timer.running

        Label {
            text: qsTr("Are sure you want to quit the app?")
            color: "blue"
            font { pointSize: 12; bold: true }
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            text: qsTr("Yes! exit now")
            onClicked: timer.running = true
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
