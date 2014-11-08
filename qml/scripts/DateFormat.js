.pragma library
.import "Utilities.js" as Utilities

var MINUTES_LENGTH  = 1000 * 60;
var HOURS_LENGTH    = MINUTES_LENGTH * 60;
var DAYS_LENGTH     = HOURS_LENGTH * 24;
var MONTH_LENGTH     = DAYS_LENGTH * 30;
var YEARS_LENGTH    = DAYS_LENGTH * 365;

function stringToDate(s) {
    if (!Utilities.isString(s)) return null;
    return new Date(s);
}

function toNow(date, dict) {
    dict = dict || ["now", "min", "h", "days", "month", "years"];
    date = Utilities.isString(date)? stringToDate(date) : date;
    if (!Utilities.isDateObject(date)) return null;

    var now = new Date(),
        passed = Math.abs(now.getTime() - date.getTime());

    if (passed < MINUTES_LENGTH) {
        return dict[0];
    } else if (passed < HOURS_LENGTH) {
        return Math.round(passed / MINUTES_LENGTH) + dict[1]
    } else if (passed < DAYS_LENGTH) {
        return Math.round(passed / HOURS_LENGTH) + dict[2]
    } else if (passed < MONTH_LENGTH) {
        return Math.round(passed / DAYS_LENGTH) + dict[3]
    } else if (passed < YEARS_LENGTH) {
        return Math.round(passed / MONTH_LENGTH) + dict[4]
    } else {
        return Math.round(passed / YEARS_LENGTH) + dict[5]
    }

}
