import QtQuick 2.0

Item{
//    intendedScreenWidth: 540
//    intendedScreenHeight: 960

    //        refreshOnResize: true

    /*Preset app-wide sizes
      These are only recalculated one
      */
    //Base point size
    property int s_BASE_UNIT: U.px(8)

    //Fonts::
    property int s_TEXT_SIZE_MEDIUM: U.px(22)
    property int s_TEXT_SIZE_SMALL: U.px(18)
    property int s_TEXT_SIZE_MINI: U.px(14)

    //Layouts::
    property int s_MARGIN: U.px(8)
    property int s_DOUBLE_MARGIN: U.px(16)
    property int s_HALF_DOUBLE_MARGIN: U.px(24)
    property int s_TRIPPLE_MARGIN: U.px(32)
    property int s_QUADRO_MARGIN: U.px(48)
    property int s_HALF_MARGIN: U.px(4)

    property int s_BORDER: U.px(2)

    property int s_LIST_ITEM_HEIGHT: U.px(48)
    property int s_LIST_ITEM_DOUBLE_HEIGHT: U.px(96)

    property int s_ICON_SIZE: U.px(48)
    property int s_ICON_SIZE_SMALL: U.px(32)
    property int s_ICON_SIZE_MINI: U.px(24)
    property int s_ICON_SIZE_BIG: U.px(64)
    property int s_ICON_SIZE_HUGE: U.px(92)

    //Special cases::
    property int s_NOTE_LIST_MIN_HEIGHT: U.px(96)
    property int s_ACTION_BAR_HEIGHT: U.px(82)
    property int s_ACTION_BAR_BUTTON_SIZE: U.px(40)
    property int s_OMNI_BAR_HEIGHT: U.px(56)
    property int s_IMAGE_PREVIEWS_SIZE: U.px(210)
    property int s_ACTION_BUTTON_SIZE: U.px(96)
}
