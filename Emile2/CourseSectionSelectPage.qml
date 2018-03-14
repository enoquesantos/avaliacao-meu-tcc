import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    id: page
    title: qsTr("Select a course sections")
    objectName: "DestinationGroupSelectPage.qml"
    state: "popPage"

    Component.onCompleted: {
        var i = 0, objc = {}, coursesSections = settings.userProfile.course_sections
        while (i < coursesSections.length) {
            objc = coursesSections[i++]
            objc.courseSectionId = objc.id
            objc.courseSectionName = objc.name
            listViewModel.append(objc)
        }
    }

    property string urlService

    ListView {
        anchors.fill: parent
        model: ListModel { id: listViewModel }
        topMargin: 5; bottomMargin: 15
        delegate: ListItem {
            id: wrapper
            img: "qrc:/assets/group.svg"
            title: code + ""
            description: name + ""
            onClicked: {
                var args = {
                    "courseSectionId" : courseSectionId,
                    "courseSectionName" : courseSectionName,
                    "destinationName" : name || code || "",
                    "forSpecificStudents" : true,
                    "urlService" : urlService
                }
                pageStack.push("qrc:/SendMessagePage.qml", args)
            }
        }
    }
}
