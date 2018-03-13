import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    id: page
    objectName: "LoginPage.qml"

    // handle request http responses
    function handleRequestResponse(statusCode, response) {
        if (statusCode === 400 || statusCode === 403 || statusCode === 404) {
            messageDialog.title = qsTr("Error!")
            messageDialog.text = qsTr("Login or Password is invalid. Check your credentials and try again!")
            messageDialog.open()
        } else if (statusCode === 200) {
            var _response = response.user
            _response.image_path = "qrc:/assets/person.svg"
            _response.enrollment = response.enrollment
            _response.program = response.program
            _response.permission.name = _response.permission.description
            loginResult = _response
        } else {
            messageDialog.title = qsTr("Error!")
            messageDialog.text = qsTr("A error occur in the server! Try again!")
            messageDialog.open()
        }
    }

    property var loginResult: null

    // countdown to pop the login page
    Timer {
        interval: 1500
        running: loginResult != null
        onRunningChanged: if (running) busyIndicator.visible = true
        onTriggered: settings.userProfile = loginResult
    }

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        visible: requestHttp.state === "loading"
    }

    Flickable {
        anchors.fill: parent
        contentHeight: Math.max(content.implicitHeight, height)
        boundsBehavior: Flickable.StopAtBounds

        Brand {
            id: brand
        }

        Column {
            id: content
            spacing: 25
            width: parent.width * 0.90
            anchors { top: brand.bottom; topMargin: 15; horizontalCenter: parent.horizontalCenter }

            TextField {
                id: login
                width: parent.width
                selectByMouse: true; cursorVisible: focus
                renderType: Text.NativeRendering
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("Login")
                onAccepted: password.focus = true
                onEditingFinished: text = text.trim()
            }

            TextField {
                id: password
                width: parent.width
                echoMode: TextInput.Password
                inputMethodHints: Qt.ImhNoPredictiveText
                placeholderText: qsTr("Password")
                onAccepted: loginButton.clicked()
            }

            Button {
                id: loginButton
                width: page.width * 0.50
                enabled: !busyIndicator.visible && loginResult === null
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("LOG IN")
                onClicked: {
                    // Obs: messageDialog is a global object, loaded in window (ApplicationWindow -> main.qml)
                    if (!login.text.length) {
                        messageDialog.title = qsTr("Error!")
                        messageDialog.text = qsTr("Please! Enter your login!")
                        messageDialog.open()
                    } else if (!password.text.length) {
                        messageDialog.title = qsTr("Error!")
                        messageDialog.text = qsTr("Please! Enter your password!")
                        messageDialog.open()
                    } else {
                        // requestHttp is a global object, loaded in main window
                        requestHttp.post("/login/", JSON.stringify({"login":login.text,"password":password.text}), handleRequestResponse)
                    }
                }
            }

            Button {
                id: lostPasswordButton
                flat: true
                width: page.width * 0.50
                anchors.horizontalCenter: parent.horizontalCenter
                enabled: !busyIndicator.visible && loginResult === null
                text: qsTr("Retrieve password")
                onClicked: pageStack.push("LostPassword.qml")
            }
        }
    }
}
