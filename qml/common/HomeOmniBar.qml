import QtQuick 2.0
import "OmniBar" as OmniBarWidget


OmniBarWidget.OmniBar
{

    OmniBarWidget.SimpleListItem{
        text: "Recent notes"
    }

    OmniBarWidget.SimpleListItem{
        text: "Popular notes"
    }
    OmniBarWidget.MultiSelectListItem{
        model : 4
    }

    OmniBarWidget.SectionHeader{text:"Trending tags"}

    OmniBarWidget.TagListView {
        height: 400 //This has to be automated somehow
        model: ListModel{id:tagModel}
        onClick: filterBar.search = tag
    }


}
