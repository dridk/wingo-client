import QtQuick 2.0

Flickable {
    flickDeceleration: 1500
    maximumFlickVelocity: 2500
    boundsBehavior: Flickable.DragOverBounds
    flickableDirection: Flickable.VerticalFlick
    property bool verticalMovementUp: verticalVelocity < 0
    property bool verticalMovementDown: verticalVelocity > 0
    property bool contentOverTopBound: contentY < 0
    property bool contentOverBottomBound: contentY > contentHeight
}

