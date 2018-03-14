import QtQuick 2.8
import QtQuick.Controls 2.3
import Qt.labs.settings 1.0

Page {
    id: page
    title: qsTr("Message wall")
    objectName: "ViewMessagesPage.qml"

    Component.onCompleted: {
        // first, set listview customization
        listView.spacing = 15
        listView.topMargin = 15
        listView.bottomMargin = 10

        var i = 0, limit = 16, messages = []
        messages = localMessages.savedMessages.slice(i, limit).reverse()
        while (messages.length) apendObject(messages.pop())

        request(true)
    }

    property bool isActivePage: pageStack.currentItem && pageStack.currentItem.objectName === objectName

    // keeps the total messages available in webservice, set after first request
    property int totalMessages: 0

    // keeps the url to paginate (next) messages, loading from webservice
    property string nextPage: ""

    property int userProfileId: settings.userProfile ? settings.userProfile.id : 0

    // to the delegate show pretty the sender name, uses this function
    // to create a short name of sender and is called for each message.
    // @param senderName string with full sender name
    function getSenderName(senderName) {
        senderName = senderName.split(" ")
        return senderName[0] + (senderName.length > 1 ? " " + senderName[senderName.length-1] : "")
    }

    // put the messages in ListView, checking if the message already exists
    // on the list, to prevent show duplicated messages.
    // @param message Object the message to append on the list
    // @param moveToTop bool used to check if message will be moved to top, useful for newested messages
    // @param forceAppend bool used to ignore the exists check message in local settings
    function apendObject(message, moveToTop, forceAppend) {
        if (!("id" in message))
            return
        // if the message is already in local messages, is already on the list view too
        if (localMessages.savedMessages.filter(function(e) { return e.id == message.id }).length > 0 && !forceAppend)
            return
        listViewModel.append(message)
        if (moveToTop)
            listViewModel.move(listViewModel.count - 1, 0, 1)
        localMessages.savedMessages.push(message)
    }

    // handle request http responses
    function handleRequestResponse(statusCode, response) {
        console.log("handleRequestResponse(statusCode, response): ", JSON.stringify(response))
        if (statusCode === 200 && "results" in response) {
            var i = 0, responseLength = response.results.length
            while (i < responseLength)
                apendObject(response.results[i++])
            if (!totalMessages)
                totalMessages = response.count
            if (response.next)
                nextPage = response.next
        }
    }

    // default request meessages function.
    // @param forceCheckUpdate bool set this parameter to force a new request
    function request(forceCheckUpdate) {
        // abort the request if device is not connected to ethernet and the page
        // is busy (other request pending) or user profile ID not exists.
        if (busyIndicator.isPageBusy || !("id" in settings.userProfile))
            return
        // if listview contains all messages available from webservice and forceCheckUpdate is null or false, abort!
        if (listView.count > 0 && listView.count == totalMessages && !forceCheckUpdate)
            return
        else if (forceCheckUpdate)
            requestHttp.get("/messages/%1".arg(userProfileId), null, handleRequestResponse) // default request to load messages
        else if (nextPage && listView && listView.count != totalMessages)
            requestHttp.get(nextPage, null, handleRequestResponse) // request to paginate messages, loading more messages from webservice
    }

    Settings {
        id: localMessages
        property var savedMessages: []
    }

    // this timer start running and repeat after 3 minutes and on triggered,
    // make a request to webservice to check and load for new messages.
    Timer {
        repeat: true; running: isActivePage; interval: 100000
        onTriggered: request(true)
    }

    RoundButton {
        z: 1; flat: true
        anchors.centerIn: parent
        width: parent.width * 0.60; height: width
        visible: listView.count === 0 && !busyIndicator.visible
        onClicked: request(true)

        Column {
            spacing: 5
            anchors.centerIn: parent

            Image {
                width: 75; height: width
                source: "qrc:/assets/error_outline.svg"; smooth: true
                asynchronous: true; cache: true
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                opacity: 0.7
                horizontalAlignment: Text.AlignHCenter
                text: qsTr("None messages available.<br>Click to reload!")
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        model: ListModel { id: listViewModel }
        topMargin: 5; bottomMargin: 15
        delegate: ViewMessagesPageDelegate { }
        onMovementEnded: {
            // After user flick to last item on the listView,
            // check for more messages in local storage. Otherwise, start a new request to webservice
            if (listView.atYEnd && listViewModel.count) {
                if (localMessages.savedMessages.length > listView.count) {
                    var messages = localMessages.savedMessages.slice(listView.count, listView.count + 16)
                    messages.reverse()
                    while (messages.length) apendObject(messages.pop())
                } else {
                    request(false)
                }
            }
        }
    }
}
