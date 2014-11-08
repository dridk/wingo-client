.pragma library

function isNumber(v, permissive) {
    //If permissive is true then
    permissive = permissive || false;
    return permissive? containsNumber(v) : !isNaN(v);
}

function containsNumber(v) {
    if ( isNumber(v) ) return true;
    return v.replace(/\D/g,'') !== "";
}

function isString(v) {
    return typeof v === "string"
}

function isBolean(v) {
    return typeof v === "boolean"
}

function isObject(v) {
    return Object.prototype.toString.call( v ) === '[object Object]';
}

function isDateObject(v) {
    return Object.prototype.toString.call( v ) === '[object Date]';
}

function isArray(v) {
    return Object.prototype.toString.call( v ) === '[object Array]';
}
