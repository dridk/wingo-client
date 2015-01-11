.pragma library

/* APP UI FONTS */
var Font = {
    DEFAULT: "Droid Sans"
}

/* APP COLOR PALETTE */
var Palette = {
    //---Special
    NONE:       "transparent",
    DARKEN:     Qt.rgba(0, 0, 0, 0.4),
    LIGHTEN:    Qt.rgba(255, 255, 255, 0.6),
    //---Grays
    BLACK:      "#29332e",
    GRAY:       "#a1b3aa",
    DARKGRAY:   Qt.darker("#a1b3aa"),
    SILVER:     "#e3e9e7",
    WHITE:      "#ffffff",
    //---Colors
    CYAN:       "#00b8cc",
    MAGENTA:    "#cc00b8",
    YELLOW:     "#ffff00",
    //---Shades
    DEEPSEA:    "#007380",
    AZURES:     "#82d9d9",
    NIGHTSKY:   "#6b47b2",
    SUNRISE:    "#f29149"
}

/* APP UI COLORS */
var Background = {
        WINDOW: Palette.SILVER,
        VIEW: Palette.WHITE,
        OVERLAY: Palette.DARKEN,
        SELECTION: Palette.DEEPSEA,
        Actionbar: {
            DEFAULT: Palette.CYAN,
            ALTERNATIVE: Palette.MAGENTA,        
            BRIGHT: Palette.SUNRISE,
            UTILITY: Palette.GRAY,
            SPECIAL: Palette.NIGHTSKY,
            Action: {
                DEFAULT: Palette.YELLOW,
                ALTERNATIVE: Palette.SUNRISE,
                BRIGHT: Palette.YELLOW,
                UTILITY: Palette.SILVER,
                SPECIAL: Palette.AZURES,
                ACCENT: Palette.DEEPSEA
            }
        },
        Button: {
            DEFAULT: Palette.NONE,
            INVERTED: Palette.NONE,
            DISABLED: Palette.SILVER,
            PRESSED: Qt.rgba(0, 0, 0, 0.3),
            ACTION: Palette.DEEPSEA,
            ACCENT: Palette.YELLOW,
            SUNKEN: Palette.SILVER
        },
        Badge: {
            DEFAULT: Palette.WHITE,
            ALTERNATIVE: Palette.SUNRISE,
            BRIGHT: Palette.YELLOW,
            ACTIONBAR: Palette.WHITE,
            ACCENT: Palette.MAGENTA,
            SPECIAL: Palette.DEEPSEA
        },
        Tag: {
            DEFAULT: Palette.AZURES,
            DISABLED: Palette.SILVER,
            ACTION: Palette.DEEPSEA,
            ACCENT: Palette.SUNRISE,
            HOT: Palette.MAGENTA,
            BRIGHT: Palette.YELLOW
        }
    },
    Border = {
        DEFAULT: Palette.SILVER,
        DARK:   Palette.GRAY,
        SHADOW: Palette.BLACK
    },
    Typography = {
        TEXT: Palette.BLACK,
        QUOTE: Palette.DARKGRAY,
        LINK: Palette.DEEPSEA,
        ACCENT: Palette.AZURES,
        ALERT: Palette.MAGENTA,
        FADE: Palette.GRAY,
        SELECTION: Palette.WHITE,
        SUNKEN: Palette.SILVER,
        Actionbar: {
            DEFAULT: Palette.WHITE,
            ALTERNATIVE: Palette.WHITE,
            BRIGHT: Palette.WHITE,
            UTILITY: Palette.WHITE,
            SPECIAL: Palette.WHITE
        },
        Button: {
            DEFAULT: Palette.BLACK,
            INVERTED: Palette.WHITE,
            DISABLED: Palette.GRAY,
            ACTION: Palette.WHITE,
            ACCENT: Palette.BLACK,
            SUNKEN: Palette.BLACK
        },
        Badge: {
            DEFAULT: Palette.DEEPSEA,
            ALTERNATIVE: Palette.WHITE,
            BRIGHT: Palette.BLACK,
            ACTIONBAR: Palette.MAGENTA,
            ACCENT: Palette.WHITE,
            SPECIAL: Palette.WHITE
        },
        Tag: {
            DEFAULT: Palette.WHITE,
            DISABLED: Palette.DARKGRAY,
            ACTION: Palette.WHITE,
            ACCENT: Palette.WHITE,
            HOT: Palette.WHITE,
            BRIGHT: Palette.BLACK
        }
    },
    Icon = {
        DEFAULT: Palette.BLACK,
        ALTERNATIVE: Palette.MAGENTA,
        SIDELINE: Palette.DARKGRAY,
        ACTION: Palette.WHITE,
        ACCENT: Palette.CYAN,
        FADE: Palette.GRAY,
        SUNKEN: Palette.SILVER,
        Actionbar: {
            DEFAULT: Palette.WHITE,
            ALTERNATIVE: Palette.WHITE,
            BRIGHT: Palette.WHITE,
            UTILITY: Palette.WHITE,
            SPECIAL: Palette.WHITE,
            Action: {
                DEFAULT: Palette.BLACK,
                ALTERNATIVE: Palette.WHITE,            
                BRIGHT: Palette.WHITE,
                UTILITY: Palette.BLACK,
                SPECIAL: Palette.WHITE,
                ACCENT: Palette.WHITE
            }
        }
    },
    Elements = {

    };

//Page styles
var PAGE_DEFAULT = "DEFAULT",
    PAGE_ALTERNATIVE = "ALTERNATIVE",
    PAGE_UTILITY = "UTILITY",
    PAGE_SPECIAL = "SPECIAL",
    ACTION_BAR_MENU_ACTION = "menu",
    ACTION_BAR_BACK_ACTION = "back"

//Avatar styles

//Callout styles
var CALLOUT_TOP = 1,
    CALLOUT_TOP_DOMINANAT = 10,
    CALLOUT_BOTTOM = 2,
    CALLOUT_BOTTOM_DOMINANAT = 20,
    CALLOUT_LEFT = 3,
    CALLOUT_LEFT_DOMINANAT = 30,
    CALLOUT_RIGHT = 4,
    CALLOUT_RIGHT_DOMINANAT = 40;

var MESSAGE_DURATION_SHORT = 5000,
    MESSAGE_DURATION_LONG = 10000,
    MESSAGE_DURATION_NEVER = 0;

var MESSAGE_PURPOSE_INFORM = 0,
    MESSAGE_PURPOSE_NOTIFY = 1,
    MESSAGE_PURPOSE_ALERT = 2;
