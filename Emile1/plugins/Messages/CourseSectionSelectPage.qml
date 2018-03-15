import QtQuick 2.8
import QtQuick.Controls 2.1
import "qrc:/publicComponentes/" as Components

Components.BasePage {
    id: page
    title: qsTr("Select a course sections")
    absPath: Config.plugins.messages + "DestinationGroupSelectPage.qml"
    listViewDelegate: pageListViewDelegate
    toolBarState: "goback"; hasNetworkRequest: false

    Component.onCompleted: {
        var i = 0, objc = {}, coursesSections = userProfile.course_sections
        while (i < coursesSections.length) {
            objc = coursesSections[i++]
            objc.courseSectionId = objc.id
            objc.courseSectionName = objc.name
            listViewModel.append(objc)
        }
    }

    property string urlService

    Component {
        id: pageListViewDelegate

        Components.ListItem {
            parent: listView.contentItem
            primaryIconName: "users"
            primaryLabelText: code + ""
            secondaryLabelText: name + ""
            onClicked: {
                var args = {
                    "courseSectionId" : courseSectionId,
                    "courseSectionName" : courseSectionName,
                    "destinationName" : name || code || "",
                    "forSpecificStudents" : true,
                    "urlService" : urlService
                }
                pageStack.push(Config.plugins.messages + "SendMessagePage.qml", args)
            }
        }
    }
}
