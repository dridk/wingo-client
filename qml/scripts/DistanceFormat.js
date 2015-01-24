.pragma library
.import "Utilities.js" as Utilities
.import "NumberFormat.js" as Numbers


var EARTH_RADIUS =  6371000; //METER
var METER = 1;
var KM = METER * 1000;
var CM = METER / 100;
var FAR = 100*KM;
var DEFAULT_DICTIONARY = ["here", "m", "km", "very far"];

//function pointObject(lat, lon) {
//    return {
//        "lat": lat,
//        "lon": lon
//    }
//}

//function getDistanceBetween(p1, p2) {
//    if ( !Utilities.isObject(p1) || !Utilities.isObject(p2) ) return null;
//    var dLat = Utilities.toRadians( p2.lat - p1.lat );  // deg2rad below
//    var dLon = Utilities.toRadians( p2.lon - p1.lon );
//    var a =
//      Math.sin(dLat/2) * Math.sin(dLat/2) +
//      Math.cos(Utilities.toRadians(p1.lat)) * Math.cos(Utilities.toRadians(p2.lat)) *
//      Math.sin(dLon/2) * Math.sin(dLon/2)
//      ;
//    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
//    var d = EARTH_RADIUS * c; // Distance in km
//    return d;
//}

//from always in Meter
function convert (value, from, to) {

     return value * to;

//    if (from === METER)
//        return value * to;
//    else if (from === KM && to === METER )
//        return value * METER;
//    else if (from === METER && to === CM )
//        return value * 100;
//    else if (from === CM && to === KM )
//        return value * CM;
//    else if (from === CM && to === METER )
//        return value / 100;

//    return value;
}

function format( distance, units, dict) {
    dict = dict || DEFAULT_DICTIONARY;
    units = units || KM;

    distance = units === METER ? distance : convert(distance, units, KM);

    if (distance < METER * 100) { // less then 5meters is here
        return dict[0];
    } else if (distance < METER * 500) { // less then 500meters is meters
        return Math.round(distance) + dict[1]
    } else if (distance < FAR) {//Less then 100Km is KM
        return Numbers.toFixed(distance / KM, 1, Math.floor) + dict[2]
    } else {//Everything else is too far
        return dict[3]
    }
}

function toHere(here, there, dict) {
    var distance = here.distanceTo(there)
    if (distance === null) return null;
    return format(distance, METER, dict);
}

