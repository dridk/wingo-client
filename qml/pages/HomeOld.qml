import QtQuick 2.0
import QtQuick.Layouts 1.1
import Wingo 1.0

import "../scripts/Icons.js" as Icons
import "../scripts/AppStyle.js" as Style
import "../scripts/Utilities.js" as Utilities
import "../scripts/DistanceFormat.js" as DistanceFormat
import "../common/OmniBar" as OmniBar
import "../common/SideBar" as SideBar
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
            "order": filterBar.sortByDate ? "recent" : "popular"
        }
        if (filterBar.search !== "")
                request["query"] = filterBar.search;

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

    SideBar.Widget{
        id: sideBar

        //This is very-very UGLY@!!!!
        onContract: page.actionBarMenu = false

        SideBar.SimpleListItem{
            text: "User Name<br><small>user.email@server.com</small>"
        }
        SideBar.SectionHeader{text:"Places"}
        SideBar.SimpleListItem{
            text: "New Note"
            onClicked: {
                sideBar.contractTray();
                page.actionBarMenu = false;
                app.goToPage(app.pages["AddNote"]);
            }
        }
        SideBar.SimpleListItem{
            text: "My Notes"
        }
        SideBar.SimpleListItem{
            text: "My Pocket"
            icon: Icons.POCKET
        }
        SideBar.SectionHeader{text:"Options"}
        SideBar.SimpleListItem{
            text: "App Settings"
        }
        SideBar.SimpleListItem{
            text: "About"
        }
        SideBar.SimpleListItem{
            text: "Legal"
        }
    }

    OmniBar.Widget{
        id: filterBar
        anchors.top: parent.top
        icon: Icons.SEARCH
        animateIconOnexpand: false
        fillHeight: true
        z: 2

        property bool sortByDate: true
        property bool sortByPopularity: false
        property double distance: 1000
        property string search: ""

        function filterBarSensorLabelText(){
            var t = "";
            if (sortByDate) {t = "Recent"}
            else if (sortByPopularity) {t = "Popular"}
            t += " " + DistanceFormat.format(distance, DistanceFormat.METER, ["right here", "m around", "km around", "far-far away"])
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

        OmniBar.SearchListItem{
            text: filterBar.search
            onTextChanged: {
                filterBar.search = text
            }
        }

        OmniBar.MultiSelectListItem{
            selected: filterBar.sortByDate? 0 : 1
            model : ["Recent notes", "Popular notes"]
            onClick: {
                console.log(value)
                filterBar.sortByDate = index === 0;
                filterBar.sortByPopularity = index === 1;
                tagRequester.refresh()
            }
        }

        OmniBar.MultiSelectListItem{
            selected: app.config.allowed_radius.indexOf(filterBar.distance)
            model : app.config === undefined ? 0 : Utilities.applyFunction(app.config.allowed_radius, function(v,i){
                return DistanceFormat.format(v, DistanceFormat.METER);
            })
            onClick: {
                filterBar.distance = app.config.allowed_radius[index];
                tagRequester.refresh();
            }
        }

        OmniBar.SectionHeader{text:"Trending tags"}

        OmniBar.TagListView {
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
        anchors.bottom: footer.top
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
        id: footer
            anchors.right: parent.right
            anchors.left: parent.left
            height: _RES.s_OMNI_BAR_HEIGHT
            color: Style.Background.VIEW
            anchors.bottom: parent.bottom
            Label{
                text: "Post new note..."
                anchors.left: parent.left
                anchors.leftMargin: _RES.s_DOUBLE_MARGIN
                anchors.verticalCenter: parent.verticalCenter
                color: Style.Typography.FADE
            }
            MouseArea{
                anchors.fill: parent
                onClicked: app.goToPage(app.pages["AddNote"])
            }
        }

}
