import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    id: page
    title: qsTr("Select a destination")
    objectName: "DestinationGroupSelectPage.qml"

    Component.onCompleted: {
        var i = 0, messageDestinations = settings.userProfile.permission.messagedestinations
        while (i < messageDestinations.length)
            listViewModel.append(messageDestinations[i++])
    }

    ListView {
        anchors.fill: parent
        model: ListModel { id: listViewModel }
        topMargin: 5; bottomMargin: 15
        delegate:  ListItem {
            id: wrapper
            img: "qrc:/assets/list.svg"
            title: name
            showSeparator: true
            onClicked: {
                var args = {
                    "urlService": url_service
                }
                if (url_service === "sendMessagesToStudentsOfATeacher") {
                    args.forAllStudentsOfTeacher = true
                    args.destinationName = name || code || ""
                    pageStack.push("SendMessagePage.qml", args)
                } else if (url_service === "sendMessagesToStudentsOfAProgram") {
                    args.forAllStudentsOfProgram = true
                    args.destinationName = name || code || ""
                    pageStack.push("SendMessagePage.qml", args)
                } else if (url_service === "sendMessagesToTeachersOfAProgram") {
                    args.forAllTeachersOfAProgram = true
                    args.destinationName = name || code || ""
                    pageStack.push("SendMessagePage.qml", args)
                } else {
                    pageStack.push("CourseSectionSelectPage.qml", args)
                }
            }
        }
    }
}
