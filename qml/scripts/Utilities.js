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

function isFunction(v){
    return Object.prototype.toString.call( v ) === "[object Function]"
}

//Mathmatical
function toRadians(deg) {
    return deg * ( Math.PI/180 );
}

//Objects

function copyArray(a) {
    return a.slice(0);
}

function copyObject(o) {//Shallow copy
    if (!isObject(o)) return o;
    var newO = {};
    for (var key in o){
        newO[key] = o[key]
    }
    return newO;
}

function sortArrayOfObjects(a, fn){
    if(!isArray(a)) return a;
    fn = fn || function(a, b){
        return a < b;
       };
    var newA = copyArray(a);
    return newA.sort(fn);
}

function findRoot(el) {
    var found = false,
        root = el;
    while (!found) {
        if (root.hasOwnProperty("parent") && root.parent !== null) root = root.parent;
        else found = true;
    }
    return root;
}

function getGlobalCoordinates(el) {
    var root = findRoot(el);
    return el.mapToItem(root, 0, 0);
}
