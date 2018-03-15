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
        onTriggered: settings.userProfile = null
        onRunningChanged: {
            if (running) {
                page.opacity = 0.7
                page.state += ",hideToolBar"
            }
        }
    }

    Label {
        id: label
        visible: timer.running
        text: qsTr("Good bye!")
        color: "blue"
        opacity: 0.7; font { pointSize: 20; bold: true }
        anchors.centerIn: parent
    }

    Column {
        id: actionColumn
        anchors.centerIn: parent
        spacing: 50; visible: !timer.running

        Label {
            text: qsTr("Are sure you want to quit the app?")
            color: "blue"
            font { pointSize: 18; bold: true }
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            text: qsTr("Yes! exit now")
            onClicked: timer.running = true
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
