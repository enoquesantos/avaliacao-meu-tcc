import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1

import "qrc:/publicComponents/" as Components

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
                var postData = ({})
                if (forSpecificStudents) {
                    postData.course_section_id = parseInt(courseSectionId)
                    var courseSectionNameSplited = courseSectionName.split("-")
                    if (courseSectionNameSplited.length > 0)
                        courseSectionName = courseSectionNameSplited[0]
                    postData.title = qsTr("All students of ") + courseSectionName
                } else if (forAllStudentsOfTeacher) {
                    postData.title = qsTr("All students of ") + user.shortUsername
                } else if (forAllStudentsOfProgram) {
                    postData.program_id = user.profile.program.id
                    postData.title = qsTr("All students of program ") + user.profile.program.abbreviation
                } else if (forAllTeachersOfAProgram) {
                    postData.program_id = user.profile.program.id
                    postData.title = qsTr("All teachers of program ") + user.profile.program.abbreviation
                }
                postData.message = textarea.text
                postData.sender = user.profile.id
                // postData.device = isIOS ? "IOS_DEVICE" : "ANDROID_DEVICE"
                requestHttp.post("/%1/".arg(urlService), JSON.stringify(postData))
            }
        }
    ]

    // handle request http responses
    onRequestFinished: {
        if (statusCode === 200) {
            textarea.clear()
            toast.show(qsTr("Successfully sended!"), true)
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

        Components.AwesomeIcon {
            size: 15
            name: "comments_o"
            color: _destinationNameMessage.color
        }

        Text {
            id: _destinationNameMessage
            font.pointSize: Config.fontSize.large
            color: _destinationNameTxt.color
            text: qsTr("Sending a message to: ")
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
        font { weight: Font.Bold; pointSize: Config.fontSize.large }
        anchors { top: infoRow.bottom; topMargin: 12; horizontalCenter: parent.horizontalCenter }
    }

    Text {
        id: textMessageCharsLength
        opacity: 0.7
        font.pointSize: Config.fontSize.normal
        color: Config.theme.textColorPrimary
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
            readOnly: isPageBusy
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
        font.pointSize: Config.fontSize.small
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
