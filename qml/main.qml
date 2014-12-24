import QtQuick 2.3
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.2
import QtPositioning 5.3
import Wingo 1.0

import "common/Layouts"

WingoApplicationWindow {
    id: app
    //Needed for QtCreator design mode
    width: 540//238
    height: 960//428
    //-----------
    debug: true


    ListView {
        anchors.fill: parent
        model: RestListModel {

        }

        delegate : Rectangle {
            width: parent.width
            height: 50
            border.color: "red"

        }


    }



//    pages: {
//        "Home":     Qt.resolvedUrl("/qml/pages/Home.qml"),
//        "Post":     Qt.resolvedUrl("/qml/pages/Post.qml"),
//        "Pocket":   Qt.resolvedUrl("/qml/pages/Pocket.qml"),
//        "Mynotes":  Qt.resolvedUrl("/qml/pages/Mynotes.qml"),
//        "Login":    Qt.resolvedUrl("/qml/pages/Login.qml"),
//        "Account":  Qt.resolvedUrl("/qml/pages/Account.qml"),
//        "View":     Qt.resolvedUrl("/qml/pages/View.qml"),
//        "Settings": Qt.resolvedUrl("/qml/pages/Settings.qml")
//    }

//    Component.onCompleted: {
//        configRequester.get()
//        locationRequest.get({"lat": app.latitude, "lon": app.longitude})
//        currentUserRequester.get()
//    }


//    //======Added by Sacha
//    Request{
//        id:configRequester
//        source:"/config"
//        onSuccess:  app.config = data.results

//    }

//    Request {
//        id: currentUserRequester
//        source:"/users/me"
//        onSuccess: {
//            console.debug("Current User loaded")
//            console.debug( data["results"])

//            app.currentUser = data["results"]
//            app.logged = true
//        }

//        onError: {
//            console.debug("Cannot load current user. Authified ?")
//            app.logged = false

//        }
//    }


//    //=========== POSITIONNING GPS
//    PositionSource
//    {
//        id: gpsSource
//        updateInterval: 1000
//        active: Qt.platform.os == "android" ? true : false
//        onPositionChanged: {
//            if ( Qt.platform.os == "android") {
//                var coord = gpsSource.position.coordinate;
//                app.longitude = coord.longitude;
//                app.latitude = coord.latitude;
//                //Update location title
//                locationRequest.get({"lat": app.latitude, "lon": app.longitude})
//            }

//            //            console.debug(coord.longitude +" " +coord.latitude )
//        }
//    }

//    Request {
//        id:locationRequest
//        source:"/location/here"
//        onSuccess: {
//            app.positionTitle  = data["results"]
//        }
//    }

}
