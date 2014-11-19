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

    text: filterBarSensorLabelText()

    Request {
        id: tagRequester
        source: "/tags"
        onSuccess: {
            tagModel.clear()
            tagModel.append(data.results)
        }
        onError: {
            console.debug(message)
        }

        function refresh(){
            tagRequester.get({"lat": app.latitude, "lon": app.longitude, "radius": filterBar.distance})
        }
    }

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
}