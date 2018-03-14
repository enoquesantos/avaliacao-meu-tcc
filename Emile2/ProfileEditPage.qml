import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtMultimedia 5.8

Page {
    id: page
    title: qsTr("Edit my profile")
    state: "popPage,withActionButton"
    objectName: "ProfileViewPage.qml"

    property string actionButtonIcon: "save"
    property bool isCameraEnabled: false
    property string cameraImageSavedPath
    onCameraImageSavedPathChanged: isCameraEnabled = false

    function actionButtonCallback() {
        var _regex = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
        email.text = email.text.toString().trim()
        if (!email.text) {
            messageDialog.title = qsTr("Error!")
            messageDialog.text = qsTr("The email field is blank!")
            messageDialog.open()
            return
        } else if (!_regex.test(email.text)) {
            messageDialog.title = qsTr("Error!")
            messageDialog.text = qsTr("The email is not valid!")
            messageDialog.open()
            return
        } else if (password1.text !== password2.text) {
            messageDialog.title = qsTr("Error!")
            messageDialog.text = qsTr("The passwords does not match!")
            messageDialog.open()
            return
        } else if (password1.text && password1.text === password2.text) {
            page.focus = true

            var args = settings.userProfile
            args["email"] = email.text
            args["password"] = password1.text

            // toast.show(qsTr("Updating profile..."), true)
            // Subject.notify(Config.events.updateUserProfile, args)

            password1.text = password2.text = ""
        }
    }

    Item {
        id: photoCapture
        visible: isCameraEnabled
        width: window.width; height: window.height

        Connections {
            target: page
            onIsCameraEnabledChanged: {
                if (isCameraEnabled)
                    camera.start()
                else
                    camera.stop()
            }
        }

        Camera {
            id: camera
            imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash
            flash.mode: Camera.FlashRedEyeReduction
            exposure {
                exposureCompensation: -1.1
                exposureMode: Camera.ExposurePortrait
            }
            imageCapture {
                onImageCaptured: photoPreview.source = preview
                onImageSaved: cameraImageSavedPath = "file://" + path
            }
        }

        Image {
            id: photoPreview
            z: 0; mirror: true
            smooth: true; asynchronous: true
            width: window.width * 1.175; height: window.height * 1.175; clip: true
            fillMode: Image.PreserveAspectFit
            anchors { top: parent.top; topMargin: 0; bottom: parent.bottom; bottomMargin: 0 }

            VideoOutput {
                z: 0; visible: true
                focus: visible // to receive focus and capture key events when visible
                source: camera
                orientation: -90
                anchors.fill: parent
                height: photoPreview.height
                fillMode: VideoOutput.PreserveAspectFit

                MouseArea {
                    z: 0
                    anchors.fill: parent
                    onClicked: capture()
                }
            }
        }
    }

    Rectangle {
        id: rec
        width: parent.width; height: 150; color: "#fafafa"
        anchors { top: parent.top; topMargin: 0; horizontalCenter: parent.horizontalCenter }

        Image {
            width: 70; height: width
            asynchronous: true; smooth: true
            source: settings.userProfile.image_path
            anchors.centerIn: parent

            MouseArea {
                anchors.fill: parent
                onClicked: isCameraEnabled = true
            }
        }
    }

    Flickable {
        id: flickable
        clip: true
        anchors { top: rec.bottom; bottom: parent.bottom; left: parent.left; right: parent.right }
        contentHeight: Math.max(content.implicitHeight, height * 1.5)

        Behavior on contentY {
            NumberAnimation {
                duration: 350
            }
        }

        ColumnLayout {
            id: content
            spacing: 20
            width: page.width * 0.90
            anchors { top: parent.top; topMargin: 15; horizontalCenter: parent.horizontalCenter }

            Rectangle {
                width: parent.width * 0.90; height: 145
                color: "transparent"
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    width: parent.width; height: parent.height
                    elide: Label.ElideRight
                    wrapMode: "WordWrap"
                    color: "green"
                    font.pointSize: 15
                    horizontalAlignment: Text.AlignJustify
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("To update your password, enter the new password's in the fields below. Otherwise, leave the fields empty. We recommend that you create a strong password with characters, letters and numbers!")
                }
            }

            TextField {
                id: email
                selectByMouse: true; cursorVisible: focus
                Layout.fillWidth: true
                renderType: Text.NativeRendering
                anchors.horizontalCenter: parent.horizontalCenter
                text: settings.userProfile.email
                font.capitalization: Font.AllLowercase
                inputMethodHints: Qt.ImhEmailCharactersOnly
                placeholderText: qsTr("youremail@example.com")
                onAccepted: password1.focus = true
                onEditingFinished: text = text.trim()
                onFocusChanged: if (focus) flickable.contentY = email.y
            }

            TextField {
                id: password1
                selectByMouse: true; cursorVisible: focus
                Layout.fillWidth: true
                renderType: Text.NativeRendering
                anchors.horizontalCenter: parent.horizontalCenter
                echoMode: TextInput.Password
                inputMethodHints: Qt.ImhNoPredictiveText
                placeholderText: qsTr("Set the new password")
                onAccepted: password2.focus = true
                onFocusChanged: if (focus) flickable.contentY = email.y
            }

            TextField {
                id: password2
                selectByMouse: true; cursorVisible: focus
                Layout.fillWidth: true
                renderType: Text.NativeRendering
                anchors.horizontalCenter: parent.horizontalCenter
                echoMode: TextInput.Password
                inputMethodHints: Qt.ImhNoPredictiveText
                placeholderText: qsTr("Confirm the new password")
                onAccepted: page.focus = true
                onFocusChanged: if (focus) flickable.contentY = email.y
            }
        }
    }
}
