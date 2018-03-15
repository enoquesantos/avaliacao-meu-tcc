import QtQuick 2.9
import QtQuick.Controls 2.2

import "qrc:/publicComponentes/" as Components

Components.BasePage {
    title: qsTr("Logout")
    toolBarState: "goBack"
    absPath: Config.plugins.login + "Logout.qml"
    hasListView: false; hasNetworkRequest: false; showToolBar: !timer.running
    showTabBar: !timer.running // hide the tabBar after user confirm to exit
    lockGoBack: timer.running // disable return to previous page, after user confirm to exit

    // countdown to pop the logout page
    Timer {
        id: timer
        interval: 2000
        onTriggered: Subject.notify(Config.events.logoutUser, 0)
    }

    Label {
        visible: timer.running
        text: qsTr("Good bye!")
        color: "blue"
        opacity: 0.7; font { pointSize: 20; bold: true }
        anchors.centerIn: parent
    }

    Column {
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
