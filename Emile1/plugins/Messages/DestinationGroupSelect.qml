import QtQuick 2.8
import QtQuick.Controls 2.1

import "qrc:/publicComponents/" as Components

Components.BasePage {
    id: page
    title: qsTr("Select a destination")
    absPath: Config.plugins.messages + "DestinationGroupSelect.qml"
    listViewDelegate: pageListViewDelegate
    hasNetworkRequest: false

    Component.onCompleted: {
        var i = 0, messageDestinations = user.profile.permission.messagedestinations
        while (i < messageDestinations.length)
            listViewModel.append(messageDestinations[i++])
    }

    Component {
        id: pageListViewDelegate

        Components.ListItem {
            id: wrapper
            primaryIconName: "tags"
            primaryIconColor: Config.theme.colorPrimary
            badgeBackgroundColor: "transparent"
            primaryLabelText: name
            onClicked: {
                var args = {
                    "urlService": url_service,
                    "pluginAbsPath": pluginAbsPath
                }
                if (url_service === "sendMessagesToStudentsOfATeacher") {
                    args.forAllStudentsOfTeacher = true
                    args.destinationName = name || code || ""
                    pageStack.push(Config.plugins.messages + "SendMessage.qml", args)
                } else if (url_service === "sendMessagesToStudentsOfAProgram") {
                    args.forAllStudentsOfProgram = true
                    args.destinationName = name || code || ""
                    pageStack.push(Config.plugins.messages + "SendMessage.qml", args)
                } else if (url_service === "sendMessagesToTeachersOfAProgram") {
                    args.forAllTeachersOfAProgram = true
                    args.destinationName = name || code || ""
                    pageStack.push(Config.plugins.messages + "SendMessage.qml", args)
                } else {
                    pageStack.push(Config.plugins.messages + "CourseSectionSelect.qml", args)
                }
            }
        }
    }
}
