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

function number(v) {
    if (!containsNumber(v)) return false;
    return v.replace(/\D/g,'') * 1;
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

function isPlural(n){
    if(!isNumber(n))return false;
    return n > 1;
}

//Mathmatical
function toRadians(deg) {
    return deg * ( Math.PI/180 );
}

//Arrays
function copyArray(a) {
    return a.slice(0);
}

function diffArray(a, b) {
    if (!isArray(a) || !isArray(b)) return null;
    return a.filter(function(i) {return b.indexOf(i) < 0;});
}

// function indexDiffArray(a, b) {
//     if (!isArray(a) || !isArray(b)) return null;
//     var ind = [];
//     forEach(b, bunction(val, i){
//         if (a.indexOf(val) < 0) ind[] = i;
//     });
//     return ind;
// }

//Objects
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

function forEach(array, fn){
    if (!isArray(array) || !isFunction(fn)) return array;
    for (var i = 0; i < array.length; i++){
        fn (array[i], i);
    }
}

function applyFunction(array, fn) {
    if (!isArray(array) || !isFunction(fn)) return array;
    var _arr = copyArray(array);
    forEach(_arr, function(v,i){
        _arr[i] = fn(array[i], i);
    });
    return _arr;
}

function isPointInRect(point, rect){
    var width = rect.x + rect.width
    var height = rect.y + rect.height
    return (point.x > rect.x && point.x < width) && (point.y > rect.y && point.y < height)
}
