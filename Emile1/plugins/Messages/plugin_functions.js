.pragma library

// to the delegate show pretty the sender name, uses this function
// to create a short name of sender and is called for each message.
// @param senderName string with full sender name
function getPrettyUserName(name) {
    var _name = name.split(" ")
    if (!_name || !_name.length)
        return name
    return capitalizeString(_name.shift() + (_name.length > 1 ? " " + _name.pop() : ""))
}

// capitalize a string:
// capitalizeString('this IS THE wOrst string eVeR')
// return -> "This Is The Worst String Ever"
// https://stackoverflow.com/questions/2332811/capitalize-words-in-string
function capitalizeString(s) {
    return s.toLowerCase().replace(/\b./g, function(a) { return a.toUpperCase() })
}
