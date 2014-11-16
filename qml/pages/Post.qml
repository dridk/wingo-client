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

    }

    function back() {
        app.goBack();
    }

    Request {
        id: notesServerRequest
        source: "/notes"
        onSuccess: {
            console.log( data.results.length )
            notesListModel.append(data.results)
        }
        onError: {
            console.debug(message)
        }
    }

    Item{
        anchors.fill: parent
        ActionBar {
            id: actionBar
            anchors.top: parent.top
            z: omniBar.expanded? 0: 4 //We need this to make sure omniBar tray closes when clicked outside
        }

        OmniBar {
            id: omniBar
            anchors.top: actionBar.bottom
        }

        EditArea {
            id: noteEdit
            anchors.top: omniBar.bottom
            focus: true

        }

    }

}
