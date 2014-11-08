.pragma library
.import "Utilities.js" as Utilities
.import "NumberFormat.js" as Numbers

var EARTH_RADIUS =  6371; //KM
var KM = 1;
var METER = KM / 1000;
var CM = METER / 100;
var FAR = 100;

function pointObject(lat, lon) {
    return {
        "lat": lat,
        "lon": lon
    }
}

function getDistanceBetween(p1, p2) {
    if ( !Utilities.isObject(p1) || !Utilities.isObject(p2) ) return null;
    var dLat = Utilities.toRadians( p2.lat - p1.lat );  // deg2rad below
    var dLon = Utilities.toRadians( p2.lon - p1.lon );
    var a =
      Math.sin(dLat/2) * Math.sin(dLat/2) +
      Math.cos(Utilities.toRadians(p1.lat)) * Math.cos(Utilities.toRadians(p2.lat)) *
      Math.sin(dLon/2) * Math.sin(dLon/2)
      ;
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    var d = EARTH_RADIUS * c; // Distance in km
    return d;
}

function toHere(here, there, dict) {
    var distance = getDistanceBetween(here, there);
    if (distance === null) return null;

    dict = dict || ["here", "m", "km", "very far"];

    if (distance < METER * 5) { // less then 5meters is here
        return dict[0];
    } else if (distance < METER * 500) { // less then 500meters is meters
        return Math.round(distance / METER) + dict[1]
    } else if (distance < FAR) {//Less then 100Km is KM
        return Numbers.toFixed(distance, 1, Math.floor) + dict[2]
    } else {//Everything else is too far
        return dict[3]
    }
}
