import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

Page {
    id: page
    title: qsTr("My profile")
    objectName: Config.plugins.userprofile + "ProfileView.qml"
    ListItem {
        showSeparator: true
        description: field
        img: awesomeIcon
    }

//    toolBarButtons: [
//        {
//            "iconName": "pencil",
//            "callback": function() {
//                pageStack.push(Config.plugins.userprofile + "ProfileEdit.qml")
//            }
//        }
//    ]

    Component.onCompleted: {
        // window.header.row
        for (var i = 0; i < fields.length; ++i)
            listViewModel.append(fields[i])
    }

    property var fields: [
        {
            "description": qsTr("Name"),
            "value": userProfile.profile.name,
            "icon": "user"
        },
        {
            "description": qsTr("Email"),
            "value": userProfile.profile.email,
            "icon": "envelope"
        }
    ]

    Rectangle {
        id: rec
        width: parent.width; height: 180; color: Config.theme.colorPrimary
        anchors { top: parent.top; topMargin: 0; horizontalCenter: parent.horizontalCenter }

        Image {
            width: 32
            source: "pencil"
            anchors { top: parent.top; topMargin: 35; right: parent.right; rightMargin: 20 }

            MouseArea {
                anchors.fill: parent
                onClicked: pageStack.push("qrc:/ProfileEdit.qml")
            }
        }

        Image {
            width: 100; height: width
            source: userProfile.profile.image_path || "qrc:/assets/perm_identity.svg"
            anchors.centerIn: parent
        }
    }

    ListView {
        y: rec.height
        anchors.fill: parent
        model: ListModel { id: listViewModel }
    }
}
