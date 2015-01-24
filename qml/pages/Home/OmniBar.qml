import QtQuick 2.0
import Wingo 1.0

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style
import "../../scripts/Utilities.js" as Utilities
import "../../scripts/DistanceFormat.js" as DistanceFormat
import "../../common/OmniBar" as OmniBar

OmniBar.Widget{
    id: filterBar
    icon: Icons.SEARCH
    animateIconOnexpand: false
    fillHeight: false
    z: 2

    property bool sortByDate: true
    property bool sortByPopularity: false
    property double distance: 1000
    property alias search: searchBar.text
    property bool changed: false

    function filterBarSensorLabelText(){
        var t = "";
        if (sortByDate) {t = "Recent"}
        else if (sortByPopularity) {t = "Popular"}
        if (search) t += ", filtered "
        t += " " + DistanceFormat.format(distance, DistanceFormat.METER, ["right here", "m around", "km around", "far-far away"])
        return t
    }

    function updateFilterBarSensorLabelText(){
        text = filterBarSensorLabelText()
    }

    onExpand: {changed = false; tagListView.emptyText = qsTr("Looking for tags around you...");}
    onOpened: tagRequester.refresh()

    text: filterBarSensorLabelText()

    Request {
        id: tagRequester
        source: "/tags"
        onSuccess: {
            if (data.results.length){
                tagModel.clear()
                tagModel.append(data.results)
            } else tagListView.emptyText = qsTr("No active tags found")
        }
        onError: {
            console.debug(message)
        }

        function refresh(){
            tagRequester.get({"lat"   : app.coordinate.latitude,
                              "lon"   : app.coordinate.longitude,
                              "radius": filterBar.distance})
        }
    }

    OmniBar.SearchListItem {
        id: searchBar
    }

    OmniBar.MultiSelectListItem{
        selected: filterBar.sortByDate? 0 : 1
        model : ["Recent notes", "Popular notes"]
        onClick: {
            console.log(value)
            filterBar.sortByDate = index === 0;
            filterBar.sortByPopularity = index === 1;
            filterBar.changed = true;
            tagRequester.refresh()
        }
    }

    OmniBar.MultiSelectListItem{
        selected: 0
        model : ["All", "only takes", "only expirated"]
        onClick: {
            filterBar.changed = true;
        }
    }

    OmniBar.MultiSelectListItem{
        selected: app.config === undefined ? 0 : app.config.allowed_radius.indexOf(filterBar.distance)
        model : app.config === undefined ? 0 : Utilities.applyFunction(app.config.allowed_radius, function(v,i){
            return DistanceFormat.format(v, DistanceFormat.METER);
        })
        onClick: {
            filterBar.distance = app.config.allowed_radius[index];
            filterBar.changed = true;
            tagRequester.refresh();
        }
    }

    OmniBar.SectionHeader{text:"Trending tags"}

    OmniBar.TagListView {
        id: tagListView
        model: ListModel{id:tagModel}
        onClick: {
            filterBar.changed = true;
            searchBar.text = tag
        }
    }
}
