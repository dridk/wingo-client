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
    LIGHTEN:    Qt.rgba(255, 255, 255, 0.9),
    //---Grays
    BLACK:      "#29332e",
    GRAY:       "#a1b3aa",
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
        Actionbar: {
            DEFAULT: Palette.CYAN,
            ALTERNATIVE: Palette.MAGENTA,
            UTILITY: Palette.GRAY,
            SPECIAL: Palette.NIGHTSKY,
            Action: {
                DEFAULT: Palette.YELLOW,
                ALTERNATIVE: Palette.SUNRISE,
                UTILITY: Palette.SILVER,
                SPECIAL: Palette.AZURES,
            }
        },
        Button: {
            DEFAULT: Palette.NONE,
            DISABLED: Palette.SILVER,
            PRESSED: Qt.rgba(0, 0, 0, 0.3),
            ACTION: Palette.DEEPSEA,
            ACCENT: Palette.YELLOW,
            SUNKEN: Palette.SILVER
        },
        Badge: {
            DEFAULT: Palette.WHITE,
            ACCENT: Palette.MAGENTA
        }
    },
    Border = {
        DEFAULT: Palette.SILVER,
        DARK:   Palette.GRAY,
        SHADOW: Palette.BLACK
    },
    Typography = {
        TEXT: Palette.BLACK,
        QUOTE: Qt.darker(Palette.GRAY),
        LINK: Palette.DEEPSEA,
        ACCENT: Palette.AZURES,
        FADE: Palette.GRAY,
        Actionbar: {
            DEFAULT: Palette.WHITE,
            ALTERNATIVE: Palette.WHITE,
            UTILITY: Palette.WHITE,
            SPECIAL: Palette.WHITE
        },
        Button: {
            DEFAULT: Palette.BLACK,
            ACTION: Palette.WHITE,
            ACCENT: Palette.BLACK,
            SUNKEN: Palette.BLACK
        },
        Badge: {
            DEFAULT: Palette.DEEPSEA,
            ACCENT: Palette.WHITE
        }
    },
    Icon = {
        DEFAULT: Palette.BLACK,
        ACTION: Palette.WHITE,
        ACCENT: Palette.CYAN,
        FADE: Palette.GRAY,
        SUNKEN: Palette.SILVER,
        Actionbar: {
            DEFAULT: Palette.WHITE,
            ALTERNATIVE: Palette.WHITE,
            UTILITY: Palette.WHITE,
            SPECIAL: Palette.WHITE
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
