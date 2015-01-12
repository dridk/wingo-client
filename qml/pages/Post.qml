import QtQuick 2.0
import Wingo 1.0
import QtPositioning 5.3

import "../scripts/Icons.js" as Icons
import "../scripts/AppStyle.js" as Style
import "../common/Layouts" as Layouts
import "../common/Controls" as Widgets

import "Post"

Layouts.Page {
    id: page


    Location {
        id:selectLocation
        coordinate: app.coordinate
    }



    function post() {
        Qt.inputMethod.hide();
        if (addImage.isEmpty)
            postData()
        else
            postImage()
    }


    function postImage(){
        if(noteEdit.textLength === 0) return app.makeToast(qsTr("Please say a few about the image"), Style.MESSAGE_PURPOSE_INFORM);
        actionBar.enabled = false
        var path = Qt.resolvedUrl(addImage.source)
        console.debug(path)
        postImageRequester.postImage(path)
    }

    function postData () {
        if(noteEdit.textLength === 0) return app.makeToast("Can't post empty note", Style.MESSAGE_PURPOSE_INFORM);
        actionBar.enabled = false
        var post = {
            "lat": selectLocation.coordinate.latitude,
            "lon":selectLocation.coordinate.longitude,
            "anonymous": omniBar.postAnonimous,
            "message":noteEdit.text
        }

        if (addImage.pathGenerated != "")
            post["picture"]=addImage.pathGenerated




        if (omniBar.expiery > -1){
            var expiery = new Date();
            var exp = omniBar.noteExpieryModel[omniBar.expiery];
            if (exp.indexOf("day") > 0) {
                expiery.setDate(expiery.getDate() +  exp.replace(/\D/g,'') );
            }else if (exp.indexOf("Mo") > 0) {
                expiery.setMonth(expiery.getMonth() +  exp.replace(/\D/g,'') );
            }else if (exp.indexOf("Yr") > 0) {
                expiery.setYear(expiery.getFullYear() +  exp.replace(/\D/g,'') );
            }
            post["expiration"] = expiery.toISOString();
        }

        if (omniBar.maxTakes > -1)
            post["limit"] = omniBar.noteTakeLimitModel[omniBar.maxTakes] * 1;

        console.debug("POST NOTE")
        postNoteRequester.post(post)
    }

    function back() {
        app.goBack();
        app.currentPage.refresh()

    }


    function updateImage(path){
        addImage.source = " " // needs.. to avoid caching features
        addImage.source = path;
    }

    function updatePos(latitude, longitude){

        selectLocation.coordinate.latitude = latitude
        selectLocation.coordinate.longitude = longitude


    }

    Request{
        id:postNoteRequester
        source:"/notes"
        onSuccess: {
            app.makeToast("Note posted")
            app.mynote_count++
            page.back()
        }
        onError: {
            app.showMessage("ERROR", message)
            actionBar.enabled = true
        }
    }


    Request {
        id:postImageRequester
        source:"/notes/picture"
        onSuccess: {
            addImage.pathGenerated =  data["results"]["path"]
            page.postData()
        }
        onError: {
            app.showMessage("ERROR", "Could not uploading image" + message)
            actionBar.enabled = true
        }
    }


    ActionBar {
        id: actionBar
        anchors.top: parent.top
    }

    OmniBar {
        id: omniBar
        anchors.top: actionBar.bottom
        noteExpieryModel: ["1day", "5day", "15day", "1Mo", "6Mo", "1Yr", "3Yr"]
        noteTakeLimitModel: ["5", "10", "15", "30", "80", "100", "300"]
    }

    Widgets.EntryArea {
        id: noteEdit
        anchors.top: omniBar.bottom
        placeholder: qsTr("Type your note text here...")
        z: 1

        anchors.left: parent.left
        anchors.right: parent.right

        maxTextLength: 255

        onFocusChanged: {
            if(focus) {
                Qt.inputMethod.setInputItemRectangle(Qt.rect(x,y,width,height))
            }
        }

        Component.onCompleted: noteEdit.forceActiveFocus()
    }

    Widgets.MapView {
        id: mapView
        anchors.top: noteEdit.bottom
        expandable: false
        center: app.coordinate

        z: 0

        onClick: {

            var mapSelector = Qt.resolvedUrl("MapSelector.qml")
            app.goToPage(mapSelector)
            app.currentPage.posChanged.connect(updatePos)

        }
    }

    AddImage{
        id: addImage
        anchors.top: mapView.bottom
        anchors.topMargin: _RES.s_TRIPPLE_MARGIN
        anchors.horizontalCenter: parent.horizontalCenter
        //DO not use url ... It doens't work when you POST to Rest
        property string pathGenerated
        onAdd: {
            var painter = Qt.resolvedUrl("Painter.qml")
            app.goToPage(painter)
            app.currentPage.drawChange.connect(updateImage)
        }

        onEdit: {
            var painter = Qt.resolvedUrl("Painter.qml")
            app.goToPage(painter)
            app.currentPage.drawChange.connect(updateImage)
            app.currentPage.loadImage()
        }

        onRemove: addImage.pathGenerated = ""
    }

//    Widgets.Button {
//        anchors.top : addImage.bottom
//        anchors.topMargin: 20
//        anchors.horizontalCenter: parent.horizontalCenter
//        icon: Icons.LOGO
//        text: "set location"
//        style: "ACTION"
//        onClicked: {

//            var mapSelector = Qt.resolvedUrl("MapSelector.qml")
//            app.goToPage(mapSelector)
//            app.currentPage.posChanged.connect(updatePos)

//        }
//    }

    BusyOverlay {
        enabled: postNoteRequester.isLoading || postImageRequester.isLoading
        z: 5
    }

}
