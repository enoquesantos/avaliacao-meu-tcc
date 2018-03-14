import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

Page {
    id: page
    title: qsTr("My profile")
    objectName: "ProfileViewPage.qml"
    state: "withActionButton"

    property string actionButtonIcon: "create"

    function actionButtonCallback() {
        pageStack.push(Qt.resolvedUrl("ProfileEditPage.qml"))
    }

    Component.onCompleted: {
        var userFields = [
            {
                _title: qsTr("Name"),
                _description: settings.userProfile.name,
                _img: "qrc:/assets/person.svg"
            },
            {
                _title: qsTr("Email"),
                _description: settings.userProfile.email,
                _img: "qrc:/assets/mail.svg"
            }
        ]
        for (var i = 0; i < userFields.length; ++i)
            listViewModel.append(userFields[i])
    }

    Rectangle {
        id: rec
        width: parent.width; height: 150; color: "#fafafa"
        anchors { top: parent.top; topMargin: 0; horizontalCenter: parent.horizontalCenter }

        Image {
            width: 70; height: width
            asynchronous: true; smooth: true
            source: settings.userProfile ? settings.userProfile.image_path : ""
            anchors.centerIn: parent
        }
    }

    ListView {
        width: parent.width; y: rec.height
        anchors { top: rec.bottom; bottom: parent.bottom }
        model: ListModel { id: listViewModel }
        delegate: ListItem {
            title: _title
            description: _description
            img: _img
            showSeparator: true
        }
    }
}
