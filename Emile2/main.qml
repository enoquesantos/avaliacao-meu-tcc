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
        visible: settings.isUserLoggedIn && pageStack.depth > 0

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
                property bool isCurrentPageEnableToPop: pageStack.currentItem != null && pageStack.currentItem.state.indexOf("popPage") > -1
            }

            Label {
                text: pageStack.currentItem && pageStack.currentItem.title ? pageStack.currentItem.title : ""
                elide: Label.ElideRight
                verticalAlignment: Qt.AlignVCenter
                anchors { left: toolButtonMenu.right; leftMargin: 20 }
            }

            ToolButton {
                id: toolButtonSave
                anchors.right: parent.right
                visible: pageStack.currentItem && pageStack.currentItem.state.indexOf("withActionButton") > -1
                icon.source: visible && "actionButtonIcon" in pageStack.currentItem ? "qrc:/assets/%1.svg".arg(pageStack.currentItem.actionButtonIcon) : ""
                onClicked: {
                    if (typeof pageStack.currentItem.actionButtonCallback == "function")
                        pageStack.currentItem.actionButtonCallback()
                }
            }
        }
    }

    property var pagesJson: [
        {
            _permission: "teacher, student, coordinator",
            _img: "qrc:/assets/message.svg",
            _description: "Ver mensagens",
            _qmlSourceFile: "ViewMessagesPage.qml"
        },
        {
            _permission: "teacher, coordinator",
            _img: "qrc:/assets/send.svg",
            _description: "Enviar mensagem",
            _qmlSourceFile: "DestinationGroupSelectPage.qml"
        },
        {
            _permission: "teacher, student, coordinator",
            _img: "qrc:/assets/perm_identity.svg",
            _description: "Meu perfil",
            _qmlSourceFile: "ProfileViewPage.qml"
        },
        {
            _permission: "teacher, student, coordinator",
            _img: "qrc:/assets/exit_to_app.svg",
            _description: "Sair",
            _qmlSourceFile: "LogoutPage.qml"
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

    // to the delegate show pretty the sender name, uses this function
    // to create a short name of sender and is called for each message.
    // @param senderName string with full sender name
    function getPrettyUserName(name) {
        var _name = name.split(" ")
        if (!_name || !_name.length)
            return name
        return capitalizeString(_name.shift() + (_name.length > 1 ? " " + _name.pop() : ""))
    }

    // capitalize a string:
    // capitalizeString('this IS THE wOrst string eVeR')
    // return -> "This Is The Worst String Ever"
    // https://stackoverflow.com/questions/2332811/capitalize-words-in-string
    function capitalizeString(s) {
        return s.toLowerCase().replace(/\b./g, function(a) { return a.toUpperCase() })
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

        // starts a request to load the user course sections
        // if user profile permission is a student or teacher.
        Timer {
            running: settings.isUserLoggedIn
            onTriggered: {
                if ("course_sections" in settings.userProfile && settings.userProfile.course_sections.length)
                    return
                requestHttp.post("/course_sections/", JSON.stringify({"id": settings.userProfile.id}), function(status, response) {
                    if (status !== 200) return
                    if (response.length && response !== settings.userProfile.course_sections) {
                        settings.userProfile.course_sections = response
                        // to apply the changes and save in local settings
                        settings.userProfile = settings.userProfile
                    }
                })
            }
        }

        // starts a request to load the user program
        // if the user profile permission is a coordinator.
        Timer {
            id: loaderUserProgramTimer
            running: settings.isUserLoggedIn && settings.userProfile.permission.description === "coordinator"
            onTriggered: {
                if ("program" in settings.userProfile && settings.userProfile.program !== null)
                    return
                requestHttp.get("/program/%1/".arg(settings.userProfile.id), null, function(status, response) {
                    if (status !== 200) return
                    if (response && settings.userProfile.program !== response) {
                        settings.userProfile.program = response
                        // to apply the changes and save in local settings
                        settings.userProfile = settings.userProfile
                    }
                })
            }
        }
    }

    Settings {
        id: settings

        property bool isUserLoggedIn
        onIsUserLoggedInChanged: if (!isUserLoggedIn) pageStack.push("qrc:/LoginPage.qml")

        property var userProfile
        onUserProfileChanged: isUserLoggedIn = (userProfile !== null && "email" in userProfile)
    }

    RequestHttp {
        id: requestHttp
    }

    Connections {
        target: pageStack
        onCurrentItemChanged: drawer.close()
    }

    Toast {
        id: toast
    }

    BusyIndicator {
        id: busyIndicator
        z: 5; anchors.centerIn: parent
        visible: requestHttp.state === "loading" && pageStack.currentItem != null
    }

    Drawer {
        id: drawer
        dragMargin: enabled ? Qt.styleHints.startDragDistance : 0
        enabled: settings.isUserLoggedIn
        width: window.width * 0.85; height: window.height

        Rectangle {
            id: userInfoRectangle
            color: "green"
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
                    highlighted: pageStack.depth && pageStack.currentItem.objectName === _qmlSourceFile
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
    }
}
