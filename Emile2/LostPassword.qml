import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    id: page
    objectName: "LostPassword.qml"
    header: Rectangle {
        width: parent.width; height: 50
        color: "transparent"

        Image {
            z: 2
            width: 35; height: width
            source: "qrc:/assets/chevron_left.svg"
            anchors { verticalCenter: parent.verticalCenter; left: parent.left; leftMargin: 10 }

            MouseArea {
                anchors.fill: parent
                onClicked: pageStack.pop()
            }
        }
    }

    // handle request http responses
    function handleRequestResponse(statusCode, response) {
        if (statusCode === 400 || statusCode === 403 || statusCode === 404)
            messageDialog.text = qsTr("Email not found. try again!")
        else if (statusCode === 200)
            messageDialog.text = qsTr("Your password was sent for your email!")
        else
            messageDialog.text = qsTr("A error occur in the server! Try again!")
        messageDialog.title = qsTr("Error!")
        messageDialog.open()
    }

    Brand {
        id: brand
    }

    Column {
        id: content
        spacing: 45
        width: parent.width * 0.90
        anchors { top: brand.bottom; topMargin: 15; horizontalCenter: parent.horizontalCenter }

        TextField {
            id: email
            width: parent.width
            selectByMouse: true; cursorVisible: focus
            renderType: Text.NativeRendering
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: qsTr("Email")
            inputMethodHints: Qt.ImhEmailCharactersOnly | Qt.ImhLowercaseOnly
            onEditingFinished: text = text.trim()
        }

        Button {
            text: qsTr("Submit")
            width: page.width * 0.40
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                var regex = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
                if (!email.text) {
                    messageDialog.title = qsTr("Error!")
                    messageDialog.text = qsTr("Please! Enter your email!")
                    messageDialog.open()
                } else if (!regex.test(email.text)) {
                    messageDialog.title = qsTr("Error!")
                    messageDialog.text = qsTr("Enter a valid Email!")
                    messageDialog.open()
                } else {
                    requestHttp.get("/recoverPassword/%1/".arg(email.text), handleRequestResponse)
                }
            }
        }
    }
}
