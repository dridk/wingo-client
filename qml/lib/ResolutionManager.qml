import QtQuick 2.0

ResolutionManagerCahce{
    intendedScreenWidth: 540
    intendedScreenHeight: 960

    //        refreshOnResize: true

    /*Preset app-wide sizes
      These are only recalculated one
      */
    //Base point size
    property int s_BASE_UNIT: 8

    //Fonts::
    property int s_TEXT_SIZE_MEDIUM: 22
    property int s_TEXT_SIZE_SMALL: 18
    property int s_TEXT_SIZE_MINI: 14

    //Layouts::
    property int s_MARGIN: 8
    property int s_DOUBLE_MARGIN: 16
    property int s_HALF_DOUBLE_MARGIN: 24
    property int s_TRIPPLE_MARGIN: 32
    property int s_QUADRO_MARGIN: 48
    property int s_HALF_MARGIN: 4

    property int s_BORDER: 2

    property int s_LIST_ITEM_HEIGHT: 48
    property int s_LIST_ITEM_DOUBLE_HEIGHT: 96

    property int s_ICON_SIZE: 48
    property int s_ICON_SIZE_SMALL: 32
    property int s_ICON_SIZE_MINI: 24
    property int s_ICON_SIZE_BIG: 64
    property int s_ICON_SIZE_HUGE: 92

    //Special cases::
    property int s_NOTE_LIST_MIN_HEIGHT: 96
    property int s_ACTION_BAR_HEIGHT: 82
    property int s_ACTION_BAR_BUTTON_SIZE: 40
    property int s_OMNI_BAR_HEIGHT: 56
    property int s_IMAGE_PREVIEWS_SIZE: 210
    property int s_ACTION_BUTTON_SIZE: 96
}
