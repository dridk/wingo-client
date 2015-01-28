.pragma library
.import "Utilities.js" as Utilities


/*!
 * CODE FROM::
 * numeral.js
 * version : 1.5.3
 * author : Adam Draper
 * license : MIT
 * http://adamwdraper.github.com/Numeral-js/
 */

/**
 * Implementation of toFixed() that treats floats more like decimals
 *
 * Fixes binary rounding issues (eg. (0.615).toFixed(2) === '0.61') that present
 * problems for accounting- and finance-related software.
 */
function toFixed (value, precision, roundingFunction, optionals) {
    var power = Math.pow(10, precision),
        optionalsRegExp,
        output;

    //roundingFunction = (roundingFunction !== undefined ? roundingFunction : Math.round);
    // Multiply up by precision, round accurately, then divide and use native toFixed():
    output = (roundingFunction(value * power) / power).toFixed(precision);

    if (optionals) {
        optionalsRegExp = new RegExp('0{1,' + optionals + '}$');
        output = output.replace(optionalsRegExp, '');
    }

    return output;
}


/************************************
    OWN CODE
************************************/

var FRACTION = 0.1;
var ZERO = 0;
var ONE  = 1;
var TEN    = 10;
var HUNDRED  = 100;
var THOUSAND  =  1000;
var defaultDictionary = [];
defaultDictionary[FRACTION] = "";
defaultDictionary[ZERO] = "";
defaultDictionary[ONE] = "";
defaultDictionary[TEN] = "";
defaultDictionary[HUNDRED] = "";
defaultDictionary[THOUSAND] = "K";

function stringify(val){
    return val + "";
}

function isZero(val){
    return val === ZERO;
}

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


function toReadableString(val) {
    if (!Utilities.isNumber(val)) return stringify(0);

    switch(getRank(val)){
    case FRACTION:
        return toFixed(val, 2, Math.round);
    case ZERO:
        return "0";
    case ONE:
    case TEN:
    case HUNDRED:
        return stringify(Math.round(val));
    case THOUSAND:
        return toFixed(val / THOUSAND, 1, Math.round) + defaultDictionary[THOUSAND];
    }
    return "";
}
