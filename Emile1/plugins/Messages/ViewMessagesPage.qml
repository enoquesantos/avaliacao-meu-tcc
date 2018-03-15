import QtQuick 2.8
import QtQuick.Controls 2.2
import Database 1.0
import Observer 1.0
import "qrc:/publicComponentes/" as Components

Components.BasePage {
    id: page
    title: qsTr("Message wall")
    absPath: Config.plugins.messages + "ViewMessagesPages.qml"
    listViewDelegate: ViewMessagesPageDelegate { }

    // handle request http responses
    onRequestFinished: {
        if (statusCode == 200 && "results" in response) {
            var i = 0, responseLength = response.results.length
            while (i < responseLength)
                apendObject(response.results[i++])
            if (!totalMessages)
                totalMessages = response.count
            if (response.next)
                nextPage = response.next
        }
    }

    Component.onCompleted: {
        // first, set listview customization
        listView.spacing = 15
        listView.topMargin = 15
        listView.bottomMargin = 10

        // try to load saved data from local storage, if available. Database selection data is asynchronous!
        database.select({}, {"limit": 16, "orderby": "id", "order": "desc"})

        // starts the initial request to load messages from webservice
        request(true)
    }

    // keeps the total messages available in webservice, set after first request
    property int totalMessages: 0

    // keeps the url to paginate (next) messages, loading from webservice
    property string nextPage: ""

    // a shortcute to ListView delegate check if the massage was sent by current user
    property int userProfileId: window.userProfile.profile.id

    // put the messages in ListView, checking if the message already exists
    // on the list, to prevent show duplicated messages.
    // @param message Object the message to append on the list
    // @param moveToTop bool used to check if message will be moved to top, useful for newested messages
    // @param isFromLocalSettings bool used to ignore the exists check message in database
    function apendObject(message, moveToTop, isFromLocalSettings) {
        if (!("id" in message))
            return
        if (database.containsId(message.id) && !isFromLocalSettings)
            return
        listViewModel.append(message)
        if (moveToTop)
            listViewModel.move(listViewModel.count - 1, 0, 1)
        if (!isFromLocalSettings)
            database.insert(message)
    }

    // default request meessages function.
    // @param forceCheckUpdate bool set this parameter to force a new request
    function request(forceCheckUpdate) {
        // abort the request if device is not connected to ethernet or the page
        // is busy (other request pending) or user profile ID not exists.
        if (!Utils.isDeviceOnline() || isPageBusy || !userProfileId)
            return
        // if listview contains all messages available from webservice and forceCheckUpdate is null or false, abort!
        if (listView.count > 0 && listView.count == totalMessages && !forceCheckUpdate)
            return
        else if (forceCheckUpdate)
            requestHttp.get("/messages/%1".arg(userProfileId)) // default request to load messages
        else if (nextPage && listView && listView.count != totalMessages)
            requestHttp.get(nextPage) // request to paginate messages, loading more messages from webservice
    }

    // plugin database handle
    Database {
        id: database
        jsonColumns: ["sender"]
        tableName: "messages"
        onItemLoaded: listViewModel.append(entry)
    }

    // this connection handle flickable movement.
    // After user flick to last item on the listView,
    // check for more messages in local storage. Otherwise, start a new request to webservice
    Connections {
        target: listView
        onMovementEnded: {
            if (listView.atYEnd && listViewModel.count) {
                if (database.totalItens > listView.count)
                    database.select({}, {"limit": 16, "offset": listViewModel.count-1, "orderby": "id", "order": "desc"})
                else
                    request(false)
            }
        }
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
        visible: listView.count === 0 && !isPageBusy
        onClicked: request(true)

        Column {
            spacing: 5
            anchors.centerIn: parent

            Components.AwesomeIcon {
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
}
