import QtQuick 2.0
import QtQuick.Layouts 1.1
import Wingo 1.0

import "../scripts/AppStyle.js" as Style
import "../common/OmniBar" as OmniBarWidget
import "../common/SideBar" as SideBarWidget
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

    onMenuButtonClicked: sideBar.toggleTray()

    onActionButtonClicked: {
        console.log("Action button " + name + " clicked at index " + index)

        if (sideBar.expanded) sideBar.contractTray();
        if (filterBar.expanded) filterBar.contractTray();

        switch (index){
        case 0:
            refresh()
            break;
        }
    }

    function refresh(){

        var request = {
            "lat": app.latitude,
            "lon": app.longitude,
            "radius": filterBar.distance,
            "query": filterBar.search,
            "order": filterBar.sortByDate ? "recent" : "popular"
        }

        notesServerRequest.get(request);
    }

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

    SideBarWidget.SideBar{
        id: sideBar

        //This is very-very UGLY@!!!!
        onContract: page.actionBarMenu = false

        OmniBarWidget.SimpleListItem{
            text: "User Name<br><small>user.email@server.com</small>"
        }
        OmniBarWidget.SectionHeader{text:"Places"}
        OmniBarWidget.SimpleListItem{
            text: "New Note"
        }
        OmniBarWidget.SimpleListItem{
            text: "My Notes"
        }
        OmniBarWidget.SimpleListItem{
            text: "My Pocket"
        }
        OmniBarWidget.SectionHeader{text:"Options"}
        OmniBarWidget.SimpleListItem{
            text: "App Settings"
        }
        OmniBarWidget.SimpleListItem{
            text: "About"
        }
        OmniBarWidget.SimpleListItem{
            text: "Legal"
        }
    }

    OmniBarWidget.OmniBar{
        id: filterBar
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
                filterBar.search = text
            }
        }

        OmniBarWidget.SimpleListItem{
            text: "Recent notes"
            onClicked: {
                filterBar.sortByDate = true
                filterBar.sortByPopularity = false
            }
        }
        OmniBarWidget.SimpleListItem{
            text: "Popular notes"
            onClicked: {
                filterBar.sortByDate = false
                filterBar.sortByPopularity = true
            }
        }

        OmniBarWidget.MultiSelectListItem{
            selected: filterBar.distance
            model : app.config === undefined ? 0 : app.config.allowed_radius
            onClick: {
                console.log(value)
                filterBar.distance = value
                tagRequester.refresh()
            }
        }

        OmniBarWidget.SectionHeader{text:"Trending tags"}

        OmniBarWidget.TagListView {
            height: 400 //This has to be automated somehow
            model: ListModel{id:tagModel}
            onClick: filterBar.search = tag
        }

        Request {
            id: tagRequester
            source: "/tags"
            onSuccess: {
                tagModel.clear()
                tagModel.append(data.results)
            }
            function refresh(){

                tagRequester.get({"lat": app.latitude, "lon": app.longitude, "radius": filterBar.distance})
            }
        }

    }


    Item{
        anchors.top: filterBar.bottom
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
