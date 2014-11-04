import QtQuick 2.0
import QtQuick.Layouts 1.1
import Wingo 1.0

import "../scripts/AppStyle.js" as Style
import "../common/OmniBar" as OmniBarWidget
import "../common"

Page {
    id: page
    //Needed for QtCreator design mode
    width: 540
    height: 960
    //-----------

    icon: "wingo48"
    title: "80 Inverlochy Blvd<br><small>Toronto, ON</small>"
    defaultAction: Style.ACTION_BAR_MENU_ACTION

    Component.onCompleted: {
        //Init on load
        refresh()

    }

    actionsListModel: ListModel{
        ListElement {
            icon: "refresh48"
            name: "refresh"
        }
        ListElement {
            icon: "pocket48"
            name: "pocket"
        }
    }

    onMenuButtonClicked: console.log("Menu from Home")
    onActionButtonClicked: {
        console.log("Action button " + name + " clicked at index " + index)
        switch (index){
        case 0:
            refresh()
            break;
        }
    }

    function refresh(){
        notesServerRequest.get({"lat": app.latitude, "lon": app.longitude, "radius": filterbar.distance, "query": filterbar.search})
    }

    Request {
        id: notesServerRequest
        source: "/notes"
        onSuccess: {
            notesListModel.clear()
            notesListModel.append(data.results)

        }
        onError: {
            console.debug(message)
        }
    }

    OmniBarWidget.OmniBar{
        id: filterbar
        anchors.top: parent.top

        property bool sortByDate: true
        property bool sortByPopularity: false
        property int distance: 1000
        property string search: ""

        function filterBarSensorLabelText(){
            var t = "";
            if (sortByDate) {t = "Recent"}
            else if (sortByPopularity) {t = "Popular"}
            t += " in " + distance + "m radius"
            return t
        }

        function updateFilterBarSensorLabelText(){
            text = filterBarSensorLabelText()
        }

        onExpand: tagRequester.refresh()

        onContract: {
            //Request list refresh here!!!!
            refresh()
        }

        text: filterBarSensorLabelText()

        OmniBarWidget.SearchListItem{
            onTextChanged: {
                filterbar.search = text
            }
        }

        OmniBarWidget.SimpleListItem{
            text: "Recent notes"
            onClicked: {
                filterbar.sortByDate = true
                filterbar.sortByPopularity = false
                updateFilterBarSensorLabelText()
            }
        }
        OmniBarWidget.SimpleListItem{
            text: "Popular notes"
            onClicked: {
                filterbar.sortByDate = false
                filterbar.sortByPopularity = true
                updateFilterBarSensorLabelText()
            }
        }

        OmniBarWidget.MultiSelectListItem{
            selected: filterbar.distance
            model : app.config === undefined ? 0 : app.config.allowed_radius
            onClick: {
                console.log(value)
                filterbar.distance = value
                tagRequester.refresh()
            }
        }

        OmniBarWidget.SectionHeader{text:"Trending tags:"}

        OmniBarWidget.TagListView {
            height: 400 //This has to be automated somehow
            model: ListModel{id:tagModel}
            onClick: filterbar.search = tag
        }

        Request {
            id: tagRequester
            source: "/tags"
            onSuccess: {
                tagModel.clear()
                tagModel.append(data.results)
            }
            function refresh(){
                tagRequester.get({"lat": app.latitude, "lon": app.longitude, "radius": filterbar.distance})
            }
        }

    }


    Item{
        anchors.top: filterbar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        clip: true

        ListView {
            anchors.fill: parent

            model: ListModel{
                id: notesListModel
            }

            delegate: NoteListItem{}
        }

    }

    Rectangle{
        anchors.right: parent.right
        anchors.left: parent.left
        height: 64
        color: Qt.rgba(255, 255, 255, 0.95)
        anchors.bottom: parent.bottom
        Label{
            text: "Post new note..."
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.verticalCenter: parent.verticalCenter
            color: Style.Typography.FADE
        }
        MouseArea{
            anchors.fill: parent
            onClicked: app.goToPage(app.pages["AddNote"])
        }
    }

}
