import QtQuick 2.9
import Observer 1.0
import RequestHttp 1.0

Item {
    id: rootItem
    visible: false
    objectName: "LoadUserCourseSections.qml"

    Observer {
        id: observer
        objectName: rootItem.objectName
        event: Config.events.userProfileChanged
        onUpdated: {
            // starts a request to load the user course sections list
            if (!userProfile.isLoggedIn || requestHttp.status === requestHttp.Loading)
                return
            else if ("course_sections" in userProfile.profile && userProfile.profile.course_sections.length)
                return
            requestHttp.post(Config.restService.baseUrl + "/course_sections/", JSON.stringify({"id": userProfile.profile.id}))
        }
        Component.onCompleted: Subject.attach(observer, event)
    }

    RequestHttp {
        id: requestHttp
        onFinished: {
            if (statusCode !== 200)
                return
            else if (response && userProfile.profile.course_sections !== response)
                Subject.notify(Config.events.setUserProperty, {"key": "course_sections", "value": response})
            Subject.dettach(observer, observer.event)
        }
    }
}
