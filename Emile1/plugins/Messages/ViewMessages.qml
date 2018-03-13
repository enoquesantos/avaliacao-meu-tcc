import QtQuick 2.8
import Database 1.0
import Observer 1.0
import "qrc:/publicComponents/" as Components

Components.BasePage {
    id: page
    title: qsTr("Message wall")
    absPath: Config.plugins.messages + "ViewMessages.qml"
    listViewDelegate: pageDelegate
    enableToolBarShadow: listView.contentY > 5

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
        // database.select({}, {"limit": 16, "orderby": "id", "order": "desc"})
        // starts the initial request to load messages from webservice

        request(true)
    }

    // keeps the total messages available in webservice, set after first request
    property int totalMessages: 0

    // keeps the url to paginate (next) messages, loading from webservice
    property string nextPage: ""

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
    // @param forceAppend bool used to ignore the exists check message in database
    function apendObject(message, moveToTop, forceAppend) {
        if (!("id" in message))
            return
        if (database.containsId(message.id) && !forceAppend)
            return
        listViewModel.append(message)
        if (moveToTop)
            listViewModel.move(listViewModel.count - 1, 0, 1)
        database.insert(message)
    }

    // default request meessages function.
    // @param forceCheckUpdate bool set this parameter to force a new request
    function request(forceCheckUpdate) {
        // abort the request if device is not connected to ethernet and the page
        // is busy (other request pending) or user profile ID not exists.
        if (!App.isDeviceOnline() || isPageBusy || !("id" in user.profile))
            return
        // if listview contains all messages available from webservice and forceCheckUpdate is null or false, abort!
        if (listView.count > 0 && listView.count == totalMessages && !forceCheckUpdate)
            return
        else if (forceCheckUpdate)
            requestHttp.get("/messages/" + user.profile.id) // default request to load messages
        else if (nextPage && listView && listView.count != totalMessages)
            requestHttp.get(nextPage) // request to paginate messages, loading more messages from webservice
    }

    // plugin database handle
    Database {
        id: database
        jsonColumns: ["sender"]
        tableName: "wall_messages"
        onItemLoaded: apendObject(data, false, true)
    }

    // the event "newPushMessage" is emited when a new push is received by firebase api,
    // if the app is in foreground or background (but running, not closed), the
    // push notification will be pass to Qt Application via JNI as event data with name "newPushMessage".
    // The "newIntentPushMessage" is passed when user click in some notification and the app is opened or focused
    // and the push message will be pass to application as event data with name "newIntentPushMessage".
    // The eventData contains the push message as json string. We needs to parse to object.
    Observer {
        id: appendPushMessageObserver
        events: [Config.events.newPushMessage, Config.events.newIntentPushMessage]
        onUpdated: {
            try {
                var json = JSON.parse(eventData)
                json.id = parseInt(json.id)
                json.sender = JSON.parse(json.sender)
                apendObject(json, true)
            } catch(e) { }
        }
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

    // this Component is the page message delegate, used in listview and
    // will be instantiate for each message in the listview
    Component {
        id: pageDelegate
        ViewMessagesDelegate { }
    }
}
