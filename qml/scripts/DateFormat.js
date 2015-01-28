.pragma library
.import "Utilities.js" as Utilities

var MINUTE_LENGTH  = 1;
var HOUR_LENGTH    = MINUTE_LENGTH * 60;
var DAY_LENGTH     = HOUR_LENGTH * 24;
var YEAR_LENGTH    = DAY_LENGTH * 365;
var MONTH_LENGTH   = YEAR_LENGTH / 12;

function stringToDate(s) {
    if (!Utilities.isString(s)) return null;
    var d = new Date(s);
//    console.log(">"+d.toLocaleString())
    return new Date(d.getTime() - d.getTimezoneOffset() * 60000 );
//    console.log("??"+s)
//    return d;
}

function timePassedBetweeen(date1, date2){

}

function toNow(date, dict) {
    dict = dict || ["now", "min", "h", "days", "month", "years"];
    date = Utilities.isString(date)? stringToDate(date) : date;
    if (!Utilities.isDateObject(date)) return null;

    var now = new Date(),
        passed = Math.abs(now - date);
        passed /= 1000*60;

    if (passed < MINUTE_LENGTH) {
        return dict[0];
    } else if (passed < HOUR_LENGTH) {
        return Math.round(passed / MINUTE_LENGTH) + dict[1]
    } else if (passed < DAY_LENGTH) {
        return Math.round(passed / HOUR_LENGTH) + dict[2]
    } else if (passed < MONTH_LENGTH) {
        return Math.round(passed / DAY_LENGTH) + dict[3]
    } else if (passed < YEAR_LENGTH) {
        return Math.round(passed / MONTH_LENGTH) + dict[4]
    } else {
        return Math.round(passed / YEAR_LENGTH) + dict[5]
    }

}
