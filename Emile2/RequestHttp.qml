import QtQuick 2.9

Item {
    state: "ready"

    readonly property string baseUrl: "http://enoque.pythonanywhere.com"
    readonly property string basicAuthentication: "Basic " + Qt.btoa("apirest:1q2w3e4r5t")

    function request(requestType, requestPath, dataToSend, callback) {
        var xhr = new XMLHttpRequest()
        state = "loading"
        xhr.open(requestType, baseUrl + requestPath, true)
        xhr.onerror = function() {
            state = "error"
        }
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                state = "ready"

                if (xhr.status === 0) {
                    messageDialog.title = qsTr("Error!")
                    messageDialog.text = qsTr("Check your internet connection and try again.")
                    messageDialog.open()
                    return
                }

                try {
                    callback(parseInt(xhr.status), JSON.parse(xhr.responseText))
                    delete xhr
                } catch(e) {
                    console.log("--------------")
                    console.log("exception catch from requestHttp:")
                    console.log(e)
                    console.log("--------------")
                    console.log("responseText: ")
                    console.log(xhr.responseText)
                    console.log("responseStatus:")
                    console.log(xhr.status)
                    callback(0, null)
                }
            }
        }
        xhr.setRequestHeader("Content-Type", "application/json")
        xhr.setRequestHeader("Authorization", basicAuthentication)
        xhr.send(dataToSend)
    }

    function get(path, dataToSend, callback) {
         request("GET", path, dataToSend || 0, callback)
    }

    function post(path, dataToSend, callback) {
        request("POST", path, dataToSend || 0, callback)
    }
}
