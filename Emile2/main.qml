import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import Qt.labs.settings 1.0
import Qt.labs.platform 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 400; height: 600
    header: ToolBar {
        id: toolBar
        visible: settings.isUserLoggedIn

        property alias row: _row

        RowLayout {
            id: _row
            spacing: 25
            anchors.fill: parent

            ToolButton {
                id: toolButtonMenu
                enabled: pageStack.currentItem != null
                icon.source: "qrc:/assets/%1".arg(isCurrentPageEnableToPop ? "chevron_left.svg" : "dehaze.svg")
                onClicked: {
                    if (drawer.position <= 0 && !isCurrentPageEnableToPop)
                        drawer.open()
                    else
                        pageStack.pop()
                }
                property bool isCurrentPageEnableToPop: pageStack.currentItem != null && pageStack.currentItem.state === "popPage"
            }

            Label {
                text: pageStack.currentItem && pageStack.currentItem.title ? pageStack.currentItem.title : ""
                elide: Label.ElideRight
                verticalAlignment: Qt.AlignVCenter
                anchors { left: toolButtonMenu.right; leftMargin: 20 }
            }
        }
    }

    property var pagesJson: [
        {
            _permission: "teacher, student, coordinator",
            _img: "qrc:/assets/message.svg",
            _description: "Ver mensagens",
            _qmlSourceFile: "qrc:/ViewMessagesPage.qml"
        },
        {
            _permission: "teacher, coordinator",
            _img: "qrc:/assets/send.svg",
            _description: "Enviar mensagem",
            _qmlSourceFile: "qrc:/DestinationGroupSelectPage.qml"
        },
        {
            _permission: "teacher, student, coordinator",
            _img: "qrc:/assets/perm_identity.svg",
            _description: "Meu perfil",
            _qmlSourceFile: "qrc:/ProfileViewPage.qml"
        },
        {
            _permission: "teacher, student, coordinator",
            _img: "qrc:/assets/exit_to_app.svg",
            _description: "Sair",
            _qmlSourceFile: "qrc:/LogoutPage.qml"
        }
    ]

    Component.onCompleted: {
        // open window centralized when running in desktop mode
        if (["linux","osx"].indexOf(Qt.platform.os) > -1) {
            setX(Screen.width / 2 - width / 2)
            setY(Screen.height / 2 - height / 2)
        }
        if (!settings.isUserLoggedIn) {
            pageStack.clear()
            pageStack.push("qrc:/LoginPage.qml")
        }
    }

    Item {
        id: internal
        visible: false

        Timer {
            id: createMenuTimer
            running: settings.isUserLoggedIn && settings.userProfile != null
            onTriggered: {
                pageStack.replace("qrc:/ViewMessagesPage.qml")
                drawerListModel.clear()
                for (var i = 0; i < pagesJson.length; ++i)
                    drawerListModel.append(pagesJson[i])
            }
        }
    }

    Settings {
        id: settings

        property bool isUserLoggedIn
        onIsUserLoggedInChanged: if (!isUserLoggedIn) pageStack.push("qrc:/LoginPage.qml")

        property var userProfile
        onUserProfileChanged: isUserLoggedIn = (userProfile != null && "email" in userProfile)
    }

    RequestHttp {
        id: requestHttp
    }

    Connections {
        target: pageStack
        onCurrentItemChanged: drawer.close()
    }

    Drawer {
        id: drawer
        dragMargin: enabled ? Qt.styleHints.startDragDistance : 0
        enabled: settings.isUserLoggedIn
        width: window.width * 0.85; height: window.height

        Rectangle {
            id: userInfoRectangle
            color: "red"
            anchors.top: parent.top
            width: parent.width; height: 180

            Image {
                id: name
                asynchronous: true
                anchors { bottom: parent.bottom; bottomMargin: 70; left: parent.left; leftMargin: 15 }
                source: settings.userProfile ? settings.userProfile.image_path : "qrc:/assets/add_a_photo.svg"
            }

            Text {
                text: settings.userProfile ? (settings.userProfile.name + "<br>" + settings.userProfile.email) : "Enoque Joseneas<br>enoquejoseneas@gmail.com"
                anchors { bottom: parent.bottom; bottomMargin: 25; left: parent.left; leftMargin: 15 }
            }
        }

        ListView {
            id: drawerListView
            clip: true
            anchors.top: userInfoRectangle.bottom
            width: parent.width; height: parent.height - userInfoRectangle.height
            model: ListModel { id: drawerListModel }
            delegate: Component {
                ListItem {
                    Component.onCompleted: console.log("sname: ", settings.userProfile.permission.name)
                    width: drawerListView.width
                    title: _description; img: _img
                    visible: settings.userProfile ? _permission.indexOf(settings.userProfile.permission.name) > -1 : false
                    onClicked: pageStack.push(Qt.resolvedUrl(_qmlSourceFile))
                }
            }
        }
    }

    MessageDialog {
        id: messageDialog
        buttons: StandardButton.Ok | StandardButton.Cancel
    }

    StackView {
        id: pageStack
        anchors.fill: parent

        BusyIndicator {
            anchors.centerIn: parent
            visible: !pageStack.currentItem
        }
    }
}
