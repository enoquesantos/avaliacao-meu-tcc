import QtQuick 2.8
import QtQuick.Controls 2.1
import "qrc:/publicComponentes/" as Components

Components.BasePage {
    id: page
    title: qsTr("Select a destination")
    absPath: Config.plugins.messages + "DestinationGroupSelectPage.qml"
    listViewDelegate: pageListViewDelegate; hasNetworkRequest: false

    Component.onCompleted: {
        var i = 0, messageDestinations = userProfile.profile.permission.messagedestinations
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
                    "urlService": url_service
                }
                if (url_service === "sendMessagesToStudentsOfATeacher") {
                    args.forAllStudentsOfTeacher = true
                    args.destinationName = name || code || ""
                    pageStack.push(Config.plugins.messages + "SendMessagePage.qml", args)
                } else if (url_service === "sendMessagesToStudentsOfAProgram") {
                    args.forAllStudentsOfProgram = true
                    args.destinationName = name || code || ""
                    pageStack.push(Config.plugins.messages + "SendMessagePage.qml", args)
                } else if (url_service === "sendMessagesToTeachersOfAProgram") {
                    args.forAllTeachersOfAProgram = true
                    args.destinationName = name || code || ""
                    pageStack.push(Config.plugins.messages + "SendMessagePage.qml", args)
                } else {
                    pageStack.push(Config.plugins.messages + "CourseSectionSelectPage.qml", args)
                }
            }
        }
    }
}
