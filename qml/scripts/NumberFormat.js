.pragma library
.import "Utilities.js" as Utilities

var FRACTION = 0.1;
var ZERO = 0;
var ONE  = 1;
var TEN    = 10;
var HUNDRED  = 100;
var THOUSAND  =  1000;

function getRank(val) {
    if (!Utilities.isNumber(val)) return false;
    if(val < ZERO) return FRACTION;
    else if (val === ZERO ) return ZERO;
    else if (val < TEN) return ONE;
    else if (val < HUNDRED) return TEN;
    else if (val < THOUSAND) return HUNDRED;
    else if (val >= THOUSAND) return THOUSAND;
    return false;
}


function convert(val, to, from){
    from = from || ONE;
    return val * from / to;
}


function toString(val) {

    switch(getRank(val)){
    case FRACTION:
        return new Number(val).toPrecision(2).toLocaleString();
        break;
    case ZERO:
        return "0";
    case ONE:
    case TEN:
    case HUNDRED:
        return Math.round(val) + "";
    case THOUSAND:
        return new Number(val/1000).toPrecision(1).toLocaleString() + "K";
    }
    return "";
}
