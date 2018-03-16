import QtQuick 2.8
import QtQuick.Controls 2.3

Page {
    id: page
    title: qsTr("Write the message ")
    objectName: "DestinationGroupSelectPage.qml"
    state: "popPage,withActionButton"

    property int courseSectionId
    property string actionButtonIcon: "send"
    property string courseSectionName
    property string destinationName
    property string urlService
    property bool forAllStudentsOfProgram: false
    property bool forAllStudentsOfTeacher: false
    property bool forAllTeachersOfAProgram: false
    property bool forSpecificStudents: false

    // handle request http responses
    function handleRequestResponse(statusCode, response) {
        if (statusCode === 200) {
            // apply the changes for last sent message.
            // Now, the MessavesViewPage
            // push the last message on the list view.
            textarea.clear()
            toast.show(qsTr("Message successfully sended"), true)
            timerFocusTextArea.running = true
        } else if (statusCode === 400 || statusCode === 404) {
            messagesPendingToView.pop()
            messageDialog.title = qsTr("Error!")
            messageDialog.text = qsTr("The message cannot be sent!")
            messageDialog.open()
        } else {
            messagesPendingToView.pop()
            messageDialog.title = qsTr("Error!")
            messageDialog.text = qsTr("An error occur in the server! Please try again.")
            messageDialog.open()
        }
    }

    // handle clicks from 'send icon' added in window toolbar
    function actionButtonCallback() {
        if (requestHttp.state === "loading") {
            return
        } else if (!textarea.text.length) {
            messageDialog.title = qsTr("Error!")
            messageDialog.text = toast.show(qsTr("Please, write the message!"))
            messageDialog.open()
            return
        } else if (textarea.text.length > 300) {
            messageDialog.title = qsTr("Error!")
            messageDialog.text = qsTr("The characteres limit to the message is 300. Please, review the message and try again!")
            messageDialog.open()
            return
        }
        // configure the submit messages arguments
        var postData = ({})
        if (forSpecificStudents) {
            postData.course_section_id = parseInt(courseSectionId)
            var courseSectionNameSplited = courseSectionName.split("-")
            if (courseSectionNameSplited.length > 0)
                courseSectionName = courseSectionNameSplited[0]
            postData.title = qsTr("All students of ") + courseSectionName
        } else if (forAllStudentsOfTeacher) {
            postData.title = qsTr("All students of ") + window.getPrettyUserName(settings.userProfile.name)
        } else if (forAllStudentsOfProgram) {
            postData.program_id = settings.userProfile.program.id
            postData.title = qsTr("All students of program ") + settings.userProfile.program.abbreviation
        } else if (forAllTeachersOfAProgram) {
            postData.program_id = settings.userProfile.program.id
            postData.title = qsTr("All teachers of program ") + settings.userProfile.program.abbreviation
        }
        postData.message = textarea.text
        postData.sender = settings.userProfile.id
        postData.device = Qt.platform.os === "ios" ? "IOS_DEVICE" : "ANDROID_DEVICE"
        requestHttp.post("/%1/".arg(urlService), JSON.stringify(postData), handleRequestResponse)
    }

    Timer {
        id: timerFocusTextArea
        running: true
        onTriggered: textarea.forceActiveFocus()
    }

    Row {
        id: infoRow
        spacing: 5
        anchors {
            top: parent.top
            topMargin: 16
            horizontalCenter: parent.horizontalCenter
        }

        AwesomeIcon {
            size: 15
            name: "comments_o"
            color: _destinationNameMessage.color
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: _destinationNameMessage
            font.pointSize: 18
            color: _destinationNameTxt.color
            text: qsTr("Sending a message to: ")
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Text {
        id: _destinationNameTxt
        textFormat: Text.StyledText
        width: parent.width * 0.80; height: 40
        color: "#444"
        text: destinationName
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        font { weight: Font.Bold; pointSize: 12 }
        anchors { top: infoRow.bottom; topMargin: 12; horizontalCenter: parent.horizontalCenter }
    }

    Text {
        id: textMessageCharsLength
        opacity: 0.7; color: textarea.text.length > 300 ? "red" : "#444"
        font.pointSize: 10
        font.bold: textarea.text.length > 300
        text: 300 + qsTr(" chars left")
        anchors {
            top: _destinationNameTxt.bottom
            topMargin: 50
            horizontalCenter: parent.horizontalCenter
        }
    }

    Binding {
        target: textMessageCharsLength
        property: "text"
        value: (300 - textarea.text.length) + " " + qsTr(" chars left")
    }

    Rectangle {
        id: rectangleTextarea
        color: "#eaeaea"; radius: 5; z: 0; border { color: "#cecece"; width: 1 }
        width: parent.width * 0.95; height: page.height * 0.30
        anchors {
            top: textMessageCharsLength.bottom
            topMargin: 5
            horizontalCenter: parent.horizontalCenter
        }

        TextArea {
            id: textarea
            focus: true; z: 1
            selectByMouse: true; opacity: readOnly ? 0.8 : 1
            width: parent.width * 0.95
            readOnly: requestHttp.state === "loading"
            wrapMode: TextArea.WordWrap
            font.capitalization: Font.AllLowercase
            placeholderText: qsTr("Write the text here...")
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle {
                color: "transparent"
                y: (textarea.height-height) - (textarea.bottomPadding / 1.3)
                width: textarea.width; height: textarea.activeFocus ? 2 : 1
                border.width: 0
            }
        }
    }

    Text {
        opacity: 0.7; clip: true
        width: page.width * 0.75
        wrapMode: Text.WordWrap
        font.pointSize: 10
        color: "#444"
        horizontalAlignment: Text.AlignHCenter
        text: qsTr("The message cannot be empty and cannot pass of 300 characters!<br>You can use links prepending with http://.")
        anchors {
            top: rectangleTextarea.bottom
            topMargin: 10
            horizontalCenter: parent.horizontalCenter
        }
    }
}
