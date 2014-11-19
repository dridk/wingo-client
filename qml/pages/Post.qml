import QtQuick 2.0
import Wingo 1.0

import "../scripts/Icons.js" as Icons
import "../scripts/AppStyle.js" as Style
import "../common/Layouts" as Layouts
import "../common/Controls" as Widgets

import "Post"

Layouts.Page {
    id: page

    function post () {
        if(noteEdit.textLength === 0) return app.showMessage("Can't post an empty note");

        var post = {
            "lat": app.latitude,
            "lon": app.longitude,
            "author":"darwin", //TIPS... darwin, to make it works without auth
            "anonymous": omniBar.postAnonimous,
            "message":noteEdit.text
        }

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
            post["limit"] = omniBar.noteTakeLimitModel[noteProperties.maxTakes] * 1;

        console.debug("POST NOTE")
        postNoteRequester.post(post)
    }

    function back() {
        app.goBack();
    }


    Request{
        id:postNoteRequester
        source:"/notes"
        onSuccess: {
            app.showMessage("SUCCESS")
        }
        onError: {
            app.showMessage("ERROR " + message)
        }
    }

    ActionBar {
        id: actionBar
        anchors.top: parent.top
        z: omniBar.expanded? 0: 4 //We need this to make sure omniBar tray closes when clicked outside
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

        anchors.left: parent.left
        anchors.right: parent.right

        maxTextLength: 255

        Component.onCompleted: noteEdit.forceActiveFocus()
    }

    AddImage{
        id: addImage
        anchors.top: noteEdit.bottom
        anchors.topMargin: _RES.s_TRIPPLE_MARGIN
        anchors.horizontalCenter: parent.horizontalCenter
        onAdd: source = "../Res/images/anonymous.png"
        onEdit: console.log("Edit")
        onRemove: console.log("Image removed")
    }

}
