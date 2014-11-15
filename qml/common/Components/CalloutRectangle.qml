import QtQuick 2.0
import Wingo 1.0

import "../../scripts/AppStyle.js" as Style

Rectangle {
    id: calloutRectangle

    width: 64
    height: 64

    property int tipVerticalAlignment: Style.CALLOUT_BOTTOM
    property int tipHorizontalAlignment: Style.CALLOUT_LEFT_DOMINANAT
    property int tipMargin: 0
    property int tipSize: 12


    PolygonItem {
        id: tip
        width: parent.width * (tipSize/100)
        height: width

        x: -width
        y: parent.height - height - tipMargin

        points:[[0, height], [width, 0], [width, height]]
        color: parent.color
    }
    states: [
        //DEFAULT IS BOTTOM_LEFT_DOMINANT
        State {
            name: "TOP_LEFT_DOMINANAT"
            when: tipVerticalAlignment + tipHorizontalAlignment === 31
            PropertyChanges {
                target: tip
                points:[[0,0], [width, 0], [width,height]]
                x: -width
                y: tipMargin
            }
        },
        State {
            name: "TOP_DOMINANAT_LEFT"
            when: tipVerticalAlignment + tipHorizontalAlignment === 31
            PropertyChanges {
                target: tip
                points:[[0,0], [width,height], [0, height]]
                x: tipMargin
                y: -height
            }
        },
        State {
            name: "TOP_DOMINANAT_RIGHT"
            when: tipVerticalAlignment + tipHorizontalAlignment === 14
            PropertyChanges {
                target: tip
                points:[[0,height], [width,0], [width, height]]
                x: parent.width - width - tipMargin
                y: -height
            }
        },
        State {
            name: "TOP_RIGHT_DOMINANAT"
            when: tipVerticalAlignment + tipHorizontalAlignment === 41
            PropertyChanges {
                target: tip
                points:[[0,0], [width,0], [0, height]]
                x: parent.width
                y: tipMargin
            }
        },
        State {
            name: "BOTTOM_RIGHT_DOMINANAT"
            when: tipVerticalAlignment + tipHorizontalAlignment === 42
            PropertyChanges {
                target: tip
                points:[[0,0], [width,height], [0, height]]
                x: parent.width
                y: parent.height - height - tipMargin
            }
        },
        State {
            name: "BOTTOM_DOMINANAT_RIGHT"
            when: tipVerticalAlignment + tipHorizontalAlignment === 24
            PropertyChanges {
                target: tip
                points:[[0,0], [width,0], [width, height]]
                x: parent.width - width - tipMargin
                y: parent.height
            }
        },
        State {
            name: "BOTTOM_DOMINANAT_LEFT"
            when: tipVerticalAlignment + tipHorizontalAlignment === 23
            PropertyChanges {
                target: tip
                points:[[0,0], [width,0], [0, height]]
                x: tipMargin
                y: parent.height
            }
        }
    ]

}
