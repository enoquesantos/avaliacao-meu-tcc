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

        // load all messages from local settings
        var i = 0, limit = 16, messages = []
        messages = localMessages.savedMessages.slice(i, limit)
        while (i < limit) apendObject(messages[i++], false, true)

        // starts the initial request to load messages from webservice
        request(true)
    }

    // a flag to indicate when the page is active for the user
    property bool isActivePage: pageStack.currentItem && pageStack.currentItem.objectName === objectName

    // keeps the total messages available in webservice, set after first request
    property int totalMessages: 0

    // keeps the url to paginate (next) messages, loading from webservice
    property string nextPage: ""

    // a shortcute to ListView delegate check if the massage was sent by current user
    property int userProfileId: settings.userProfile ? settings.userProfile.id : 0

    // put the messages in ListView, checking if the message already exists
    // on the list, to prevent show duplicated messages.
    // @param message Object the message to append on the list
    // @param moveToTop bool used to check if message will be moved to top, useful for newested messages
    // @param isFromLocalSettings bool used to ignore the exists check message in local settings
    function apendObject(message, moveToTop, isFromLocalSettings) {
        if (!message || typeof message == "undefined")
            return
        try {
            // if the message is already in local messages, is already on the list view too
            if (localMessages.savedMessages.filter(function(o) { return o.id === message.id }).length > 0 && !isFromLocalSettings)
                return
            listViewModel.append(message)
            if (moveToTop)
                listViewModel.move(listViewModel.count - 1, 0, 1)
            if (!isFromLocalSettings)
                localMessages.savedMessages.push(message)
        } catch(e) {
            console.error(e)
            return
        }
    }

    // handle request http responses
    function handleRequestResponse(statusCode, response) {
        if (statusCode === 200 && "results" in response) {
            var i = 0, responseLength = response.results.length
            while (i < responseLength)
                apendObject(response.results[i++], true)
            if (!totalMessages)
                totalMessages = response.count
            if (response.next)
                nextPage = response.next
            localMessages.savedMessages = localMessages.savedMessages
        }
    }

    // default request meessages function.
    // @param forceCheckUpdate bool set this parameter to force a new request
    function request(forceCheckUpdate) {
        // abort the request if device is not connected to ethernet or
        // another request is loading or user profile id not exists.
        if (requestHttp.state === "loading" || !("id" in settings.userProfile))
            return
        // if listview contains all messages available from webservice and forceCheckUpdate is null or false, abort!
        if (listView.count > 0 && listView.count == totalMessages && !forceCheckUpdate)
            return
        else if (forceCheckUpdate)
            requestHttp.get("/messages/%1".arg(userProfileId), null, handleRequestResponse) // default request to load messages
        else if (nextPage && listView && listView.count != totalMessages)
            requestHttp.get(nextPage, null, handleRequestResponse) // request to paginate messages, loading more messages from webservice
    }

    // a simple "database" to user read messages offline :)
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
        visible: listView.count === 0 && requestHttp.state !== "loading"
        onClicked: request(true)

        Column {
            spacing: 5
            anchors.centerIn: parent

            AwesomeIcon {
                size: 75; name: "warning"; clickEnabled: false
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
        add: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 150 }
        }
        displaced: Transition {
            NumberAnimation { properties: "x,y"; duration: 150; easing.type: Easing.InOutQuint }
        }
        ScrollIndicator.vertical: ScrollIndicator { }
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
