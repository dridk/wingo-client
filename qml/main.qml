import QtQuick 2.3
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.2
import QtPositioning 5.3
import Wingo 1.0

import "common/Layouts"

WingoApplicationWindow{

    id: app
    width: 540//238
    height: 960//428
    visible: true

    //---------------------------
    //Application global property
    //---------------------------
    property alias coordinate    : location.coordinate
    property double accurenty    : 5
    property bool debug          : true
    property bool logged         : false
    property string positionTitle: qsTr("Looking up your<br>current location...")
    property variant config
    property variant currentUser
    property int pocket_count
    property int mynote_count

    //---------------------------
    //Application global function
    //---------------------------

    function updateLocation(){
        gpsSource.start()
    }

    function requestCurrentUser(){
        currentUserRequester.get()
    }

    //---------------------------
    //Application global page
    //---------------------------

    pages: { "Home":     Qt.resolvedUrl("/qml/pages/Home.qml"),
             "Post":     Qt.resolvedUrl("/qml/pages/Post.qml"),
             "Pocket":   Qt.resolvedUrl("/qml/pages/Pocket.qml"),
             "Mynotes":  Qt.resolvedUrl("/qml/pages/Mynotes.qml"),
             "Login":    Qt.resolvedUrl("/qml/pages/Login.qml"),
             "Account":  Qt.resolvedUrl("/qml/pages/Account.qml"),
             "View":     Qt.resolvedUrl("/qml/pages/View.qml"),
             "Settings": Qt.resolvedUrl("/qml/pages/Settings.qml"),
             "Photo":    Qt.resolvedUrl("/qml/pages/Photo.qml")
    }

    //---------------------------
    //Application onLoad Actions
    //---------------------------

    Component.onCompleted: {
        //Request configuration
        configRequester.get()
        //Request current User
        currentUserRequester.get()
        //Request current address
        locationRequest.get({
                                "lat": app.coordinate.latitude,
                                "lon": app.coordinate.longitude
                            })


    }


    //---------------------------
    //Application Global Component
    //---------------------------

    //Current Location Component
    Location {
        id: location
        coordinate {
            latitude: 43.8174759
            longitude: -79.4210148
        }
    }
    //Config Request Comonent
    Request{
        id:configRequester
        source:"/config"
        onSuccess:  app.config = data.results

    }
    //Current address Request
    Request {
        id:locationRequest
        source:"/location/here"
        onSuccess: {
            app.positionTitle  = data["results"]
        }
    }

    //Current User Request
    Request {
        id: currentUserRequester
        source:"/users/me"
        onSuccess: {
            app.currentUser  = data["results"]
            app.pocket_count = app.currentUser["pocket_count"]
            app.mynote_count = app.currentUser["mynote_count"]
            app.logged = true
        }

        onError: {
            console.debug("Cannot load current user. Autentified ?")
            app.logged = false

        }
    }


    //Current Position Request
    PositionSource
    {
        id: gpsSource
        updateInterval: 1000
        active: Qt.platform.os == "android" ? true : false
        onPositionChanged: {
            if ( Qt.platform.os == "android") {
                var pos =  gpsSource.position;
                app.coordinate = pos.coordinate;

                app.accurenty  = 0
                //                //Update location title
                //                locationRequest.get({"lat": app.coordinate.latitude,
                //                                        "lon": app.coordinate.longitude})

                if (pos.horizontalAccuracyValid && pos.verticalAccuracyValid)
                    app.accurenty = (pos.horizontalAccuracy + pos.verticalAccuracy) /2

                else if (pos.horizontalAccuracyValid )
                    app.accurenty = pos.horizontalAccuracy
                else if (pos.verticalAccuracy )
                    app.accurenty = pos.verticalAccuracy





            }

        }
    }


    Text {
        visible: app.debug
        anchors.bottom: parent.bottom
        text: wingo.getDeviceId() + "\n" +
              configRequester.host()+":"+
              configRequester.port()+
              "\n pos:" + app.coordinate.latitude +" , "+app.coordinate.longitude
        opacity: 0.4
    }



}
