import QtQuick 2.0
import Wingo 1.0

import "../scripts/Icons.js" as Icons
import "../scripts/AppStyle.js" as Style
import "../common/Layouts" as Layouts
import "../common/Controls" as Widgets
import "../common/ActionBar" as ActionBar
import "../common/Components" as Components
import "Post"

Layouts.Page {
    id: page

    signal posChanged(double latitude, double longitude)

    ActionBar.Widget {
        id: actionBar
        ActionBar.Title {
            icon: Icons.CARRET_LEFT
            text: "Select your place"
            onClicked: page.back()
        }
    }

    Component.onCompleted: {
        placeRequester.get({"lat": app.coordinate.latitude,
                            "lon":app.coordinate.longitude})

    }


    ListModel {
        id:placeModel
        dynamicRoles: true

    }



    ListView {
        width: parent.width
        anchors.top: actionBar.bottom
        anchors.bottom: parent.bottom
        model: placeModel
        header : Rectangle {
            width: parent.width
            height: parent.width
            color: "blue"
        }

        delegate: Rectangle {
            width: parent.width
            height: 100
            color: area.pressed ? "gray" : "white"

            Image {
                anchors.left: parent.left
                anchors.verticalCenter:  parent.verticalCenter
                source: icon
            }

            Widgets.Label {
                anchors.centerIn: parent
                text: title

            }
            Widgets.Label {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                text:distance+" meter"
                font.pixelSize: 20
                color: "lightgray"

            }

            MouseArea {
                id:area
                anchors.fill: parent
                onClicked:  {
                    var lat = latitude
                    var lon = longitude
                    page.posChanged(lat, lon)
                    app.goBack()







                }
            }



        }


    }




    Request {
        id:placeRequester
        source:"/location/arround"
        onSuccess: {
            placeModel.clear()
            placeModel.append(data.results)
        }

        onError: {
            console.debug("error")
        }
    }





}
