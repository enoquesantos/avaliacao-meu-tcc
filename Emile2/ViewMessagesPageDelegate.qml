import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1

Rectangle {
    id: delegate
    color: fromCurrentUser ? "#ffffe7ba" : "#ffdddddd"; radius: 4; z: 0
    anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined
    width: page.width * 0.94; height: topRow.height + labelMessageItem.implicitHeight + bottomRow.implicitHeight + 25
    border { width: 1; color: fromCurrentUser ? "#ff71da5e" : "#ffbbbbbb" }

    property bool fromCurrentUser: sender.id === userProfileId

    Loader {
        asynchronous: true; active: true
        sourceComponent: Pane {
            z: -1; Material.elevation: 1
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width-1; height: parent.height-1
        }
        onLoaded: item.parent = delegate
    }

    RowLayout {
        id: topRow
        spacing: 0; z: 1
        height: 13
        anchors {
            top: parent.top; topMargin: 5
            left: parent.left; leftMargin: 10
            right: parent.right; rightMargin: 10
        }

        Image {
            width: 16; height: width
            source: "qrc:/assets/%1.svg".arg(fromCurrentUser ? "chevron_right" : "message")
            anchors { top: parent.top; topMargin: 0 }
        }

        Text {
            id: authorLabel
            color: labelMessage.color
            font.pointSize: 9
            anchors.verticalCenter: parent.verticalCenter
            text: fromCurrentUser ? qsTr("You") : getSenderName(sender.name)
        }

        Text {
            text: title
            font.pointSize: authorLabel.font.pointSize
            color: authorLabel.color
            anchors { right: parent.right; verticalCenter: parent.verticalCenter }
        }
    }

    Item {
        id: labelMessageItem
        width: parent.width
        height: labelMessage.implicitHeight+10; implicitHeight: height
        anchors.top: topRow.bottom; anchors.topMargin: 15

        Text {
            id: labelMessage
            z: 1
            text: message
            width: parent.width * 0.95
            wrapMode: Text.Wrap
            elide: Label.ElideRight
            textFormat: Text.StyledText
            color: "#444"
            linkColor: "blue"
            font { wordSpacing: 1.1; pointSize: 11 }
            anchors { right: parent.right; left: parent.left; margins: 10 }
            onLinkActivated: Qt.openUrlExternally(link)
        }
    }

    RowLayout {
        id: bottomRow
        spacing: 1; z: 1
        height: 13
        anchors {
            bottom: parent.bottom; bottomMargin: 7
            right: parent.right; rightMargin: 10
        }

        Image {
            width: 12; height: width
            source: "qrc:/assets/date_range.svg"
            visible: dateLabel.text.length > 0
            anchors { top: parent.top; topMargin: 0 }
        }

        Text {
            id: dateLabel
            text: Qt.formatDateTime(date, "dd/MM/yyyy")
            font.pointSize: 9; color: "#888"
            anchors.verticalCenter: parent.verticalCenter
        }

        Item { width: 8; height: parent.height }

        Image {
            width: 12; height: width
            source: "qrc:/assets/access_time.svg"
            visible: timeLabel.text.length > 0
            anchors { top: parent.top; topMargin: 0 }
        }

        Text {
            id: timeLabel
            text: new Date(date).toLocaleTimeString(window.locale).substring(0, 8)
            font.pointSize: dateLabel.font.pointSize
            color: dateLabel.color
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
