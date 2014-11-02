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
    LIGHTEN:    Qt.rgba(255, 255, 255, 0.4),
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
            SPECIAL: Palette.NIGHTSKY
        },
        Button: {
            DEFAULT: Palette.NONE,
            ACTION: Palette.DEEPSEA,
            ACCENT: Palette.YELLOW,
            SUNKEN: Palette.SILVER
        },
        Bage: {
            DEFAULT: Palette.WHITE,
            ACCENT: Palette.MAGENTA
        }
    },
    Border = {
        DEFAULT: Palette.SILVER,
        SHADOW: Palette.BLACK
    },
    Typography = {
        TEXT: Palette.BLACK,
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
        Bage: {
            DEFAULT: Palette.DEEPSEA,
            ACCENT: Palette.WHITE
        }
    },
    Element = {

    };

//Page styles
var PAGE_DEFAULT = "DEFAULT",
    PAGE_ALTERNATIVE = "ALTERNATIVE",
    PAGE_UTILITY = "UTILITY",
    PAGE_SPECIAL = "SPECIAL",
    ACTION_BAR_MENU_ACTION = "menu",
    ACTION_BAR_BACK_ACTION = "back"
