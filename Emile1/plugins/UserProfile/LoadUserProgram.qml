import QtQuick 2.9
import Observer 1.0
import RequestHttp 1.0

Item {
    id: rootItem
    visible: false
    objectName: "LoadUserProgram.qml"

    Observer {
        id: observer
        objectName: rootItem.objectName
        event: Config.events.userProfileChanged
        onUpdated: {
            // starts a request to load the user program
            // if the user profile permission is a coordinator.
            if (!userProfile.isLoggedIn || userProfile.profile.permission.description !== "coordinator"  || requestHttp.status === requestHttp.Loading)
                return
            else if ("program" in userProfile.profile && userProfile.profile.program !== null)
                return
            requestHttp.get("/program/%1/".arg(userProfile.profile.id))
        }
        Component.onCompleted: Subject.attach(observer, event)
    }

    RequestHttp {
        id: requestHttp
        onFinished: {
            if (statusCode !== 200)
                return
            else if (response && userProfile.profile.program !== response)
                Subject.notify(Config.events.setUserProperty, {"key": "program", "value": response})
            Subject.dettach(observer, observer.event)
        }
    }
}
