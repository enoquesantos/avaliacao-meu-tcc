import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1

Page {
    id: page
    title: qsTr("Write the message ")
    objectName: "DestinationGroupSelectPage.qml"
    state: "popPage,withActionButton"

    property string actionButtonIcon: "send"
    property int courseSectionId
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
            textarea.clear()
            // toast.show(qsTr("Successfully sended!"), true)
            timerFocusTextArea.running = true
        } else if (statusCode === 400 || statusCode === 404) {
            messageDialog.title = qsTr("Error!")
            messageDialog.text = qsTr("The message cannot be sent!")
            messageDialog.open()
        } else {
            messageDialog.title = qsTr("Error!")
            messageDialog.text = qsTr("An error occur in the server! Please try again.")
            messageDialog.open()
        }
    }

    // add submit icon in window toolbar
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
        // configure the submit messages arguments.
        var postData = ({})
        if (forSpecificStudents) {
            postData.course_section_id = parseInt(courseSectionId)
            var courseSectionNameSplited = courseSectionName.split("-")
            if (courseSectionNameSplited.length > 0)
                courseSectionName = courseSectionNameSplited[0]
            postData.title = qsTr("All students of ") + courseSectionName
        } else if (forAllStudentsOfTeacher) {
            postData.title = qsTr("All students of ") + settings.userProfile.name
        } else if (forAllStudentsOfProgram) {
            postData.program_id = settings.userProfile.program.id
            postData.title = qsTr("All students of program ") + settings.userProfile.program.abbreviation
        } else if (forAllTeachersOfAProgram) {
            postData.program_id = settings.userProfile.program.id
            postData.title = qsTr("All teachers of program ") + settings.userProfile.program.abbreviation
        }
        postData.message = textarea.text
        postData.sender = settings.userProfile.id
        postData.device = isIOS ? "IOS_DEVICE" : "ANDROID_DEVICE"
        requestHttp.post("/%1/".arg(urlService), JSON.stringify(postData), handleRequestResponse)
    }

    Timer {
       id: timerFocusTextArea
       running: true
       onTriggered: textarea.forceActiveFocus()
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        width: parent.width
        height: textarea.focus ? page.height*1.6 : page.height

        Behavior on contentY {
            NumberAnimation {
                duration: 350
            }
        }
    }

    Row {
        id: infoRow
        spacing: 5
        anchors {
            top: parent.top
            topMargin: 16
            horizontalCenter: parent.horizontalCenter
        }

        Image {
            asynchronous: true; smooth: true
            width: 16; height: width
            source: "qrc:/assets/message.svg"
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: _destinationNameMessage
            font.pointSize: 16
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
        font { weight: Font.Bold; pointSize: 10 }
        anchors { top: infoRow.bottom; topMargin: 12; horizontalCenter: parent.horizontalCenter }
    }

    Text {
        id: textMessageCharsLength
        opacity: 0.7
        font.pointSize: 8
        text: 300 + " " + qsTr(" chars left")
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
        color: "#fff"; radius: 15; z: 0
        width: parent.width * 0.90; height: page.height * 0.25
        anchors {
            top: textMessageCharsLength.bottom
            topMargin: 5
            horizontalCenter: parent.horizontalCenter
        }

        Pane {
            z: -1; Material.elevation: 1
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width; height: parent.height
        }

        TextArea {
            id: textarea
            focus: true
            selectByMouse: true
            z: 1; width: parent.width * 0.95
            readOnly: requestHttp.state === "loading"
            renderType: Text.NativeRendering
            wrapMode: TextArea.WordWrap
            mouseSelectionMode: TextEdit.SelectCharacters
            placeholderText: qsTr("Write the text here...")
            anchors.horizontalCenter: parent.horizontalCenter
            onFocusChanged: if (focus) flickable.contentY = textarea.y
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
        font.pointSize: 9
        horizontalAlignment: Text.AlignHCenter
        text: qsTr("The message cannot be empty and cannot pass of 300 characters!<br>You can use links prepending with http://.")
        anchors {
            top: rectangleTextarea.bottom
            topMargin: 10
            horizontalCenter: parent.horizontalCenter
        }
    }
}
