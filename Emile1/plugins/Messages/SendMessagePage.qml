import QtQuick 2.8
import QtQuick.Controls 2.3

import "qrc:/publicComponentes/" as Components
import "plugin_functions.js" as Func

Components.BasePage {
    id: page
    title: qsTr("Write the message ")
    absPath: Config.plugins.messages + "SendMessage.qml"
    hasListView: false
    centralizeBusyIndicator: false
    toolBarState: "goback"

    // add submit icon in window toolbar
    toolBarButtons: [
        {
            "iconName": "send",
            "callback": function() {
                if (isPageBusy || !textarea.text.length) {
                    toast.show(qsTr("Please, write the message!"))
                    return
                } else if (textarea.text.length > 300) {
                    window.alert(qsTr("Error!"), qsTr("The characteres limit to the message is 300. Please, review the message and try again!"), null, null)
                    return
                }
                // configure the submit messages arguments.
                var postData = {}
                if (forSpecificStudents) {
                    postData.course_section_id = parseInt(courseSectionId)
                    var courseSectionNameSplited = courseSectionName.split("-")
                    if (courseSectionNameSplited.length > 0)
                        courseSectionName = courseSectionNameSplited[0]
                    postData.title = qsTr("All students of ") + courseSectionName
                } else if (forAllStudentsOfTeacher) {
                    postData.title = qsTr("All students of ") + Func.getPrettyUserName(userProfile.profile.name)
                } else if (forAllStudentsOfProgram) {
                    postData.program_id = userProfile.program.id
                    postData.title = qsTr("All students of program ") + userProfile.profile.program.abbreviation
                } else if (forAllTeachersOfAProgram) {
                    postData.program_id = userProfile.program.id
                    postData.title = qsTr("All teachers of program ") + userProfile.profile.program.abbreviation
                }
                postData.message = textarea.text
                postData.sender = userProfile.profile.id
                postData.device = Qt.platform.os === "ios" ? "IOS_DEVICE" : "ANDROID_DEVICE"
                requestHttp.post("/%1/".arg(urlService), JSON.stringify(postData))
            }
        }
    ]

    // handle request http responses
    onRequestFinished: {
        if (statusCode === 200) {
            textarea.clear()
            toast.show(qsTr("Message successfully sended"), true)
            timerFocusTextArea.running = true
        } else if (statusCode === 400 || statusCode === 404) {
            snackbar.show(qsTr("The message cannot be sent!"), true)
        } else {
            functions.alert(qsTr("Error!"), qsTr("An error occur in the server! Please try again."))
        }
    }

    property int courseSectionId
    property string courseSectionName
    property string destinationName
    property string urlService
    property bool forAllStudentsOfProgram: false
    property bool forAllStudentsOfTeacher: false
    property bool forAllTeachersOfAProgram: false
    property bool forSpecificStudents: false

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

        Components.AwesomeIcon {
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
        color: Config.theme.textColorPrimary
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
        width: parent.width * 0.95; height: page.height * 0.45
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
            readOnly: isPageBusy
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
        color: Config.theme.textColorPrimary
        horizontalAlignment: Text.AlignHCenter
        text: qsTr("The message cannot be empty and cannot pass of 300 characters!<br>You can use links prepending with http://.")
        anchors {
            top: rectangleTextarea.bottom
            topMargin: 10
            horizontalCenter: parent.horizontalCenter
        }
    }
}
