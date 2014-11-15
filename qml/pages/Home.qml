import QtQuick 2.0
import QtQuick.Layouts 1.1
import Wingo 1.0

import "../scripts/Icons.js" as Icons
import "../scripts/AppStyle.js" as Style
import "../common/Layouts" as Layouts
import "../common/ActionBar" as ActionBar
import "../common/Controls" as Widgets

import "Home"

Layouts.Page {
    id: page

    function refresh(){

        var request = {
            "lat": app.latitude,
            "lon": app.longitude,
            "radius": omniBar.distance,
            "order": omniBar.sortByDate ? "recent" : "popular"
        }
        if (omniBar.search !== "")
                request["query"] = omniBar.search;

        notesServerRequest.get(request);
    }
    Component.onCompleted: refresh()

    Request {
        id: notesServerRequest
        source: "/notes"
        onSuccess: {
            console.log( data.results.length )
            notesListModel.clear()
            notesListModel.append(data.results)
        }
        onError: {
            console.debug(message)
        }
    }

    ColumnLayout{
        anchors.fill: parent
        spacing: 0
        ActionBar.Widget {
            id: actionBar
            ActionBar.Title {
                icon: Icons.SANDWICH
                text: "80 Inverlochy Blvd<br><small>Toronto, ON</small>"
                onClicked: appMenu.toggleTray()
            }
            ActionBar.Right{
                ActionBar.Button{
                    icon: Icons.POCKET
                    onClicked: console.log("Pocket")
                }
                ActionBar.Button{
                    icon: Icons.REFRESH
                    onClicked: page.refresh()
                }
            }
            onClick: omniBar.contractTray();
        }

        OmniBar {
            id: omniBar
            onContract: refresh()
        }

        Layouts.NoteListView {
            id: noteList
            model: ListModel{id: notesListModel}
            onVerticalMovementUpChanged: if (verticalMovementUp&&!atYEnd) addNoteActionButton.show()
            onDistancePassed: if(verticalMovementDown) addNoteActionButton.hide()
            onRefresh: page.refresh()
        }
    }

    Widgets.ActionButton{
        id: addNoteActionButton
        onClicked: {
            appMenu.contractTray();
            app.goToPage(app.pages["AddNote"]);
        }
    }

    AppMenu{
        id: appMenu
    }


}
