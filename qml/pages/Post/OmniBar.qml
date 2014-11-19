import QtQuick 2.0

import "../../scripts/Icons.js" as Icons
import "../../scripts/AppStyle.js" as Style
import "../../scripts/Utilities.js" as Utilities
import "../../scripts/DistanceFormat.js" as DistanceFormat
import "../../common/OmniBar" as OmniBar
import "../../common/Controls" as Widgets

OmniBar.Widget{
    id: noteProperties
    z: 2
    iconBackgroundColor: Style.Background.VIEW

    property bool postAnonimous: false
    property int expiery: -1
    property int maxTakes: -1

    property alias noteExpieryModel: notePropertiesExpieryWidget.model
    property alias noteTakeLimitModel: notePropertiesLimitWidget.model

    function composeText(){
        var t = ""
        t = postAnonimous? "Anonimous" : "Signed"
        t += ", "
        t += expiery === -1? "no expiery" : "expire in " + notePropertiesExpieryWidget.model[expiery]
        t += ", "
        t += maxTakes === -1? "unlimited" : notePropertiesLimitWidget.model[maxTakes] + " takes"
        return t
    }

    function updateValues() {
        postAnonimous = notePropertiesIdentityWidget.selected === 1;
        expiery = notePropertiesExpieryWidget.selected;
        maxTakes = notePropertiesLimitWidget.selected;
    }

    onPostAnonimousChanged: text = composeText()
    onExpieryChanged: text = composeText()
    onMaxTakesChanged: text = composeText()

    Component.onCompleted: text = composeText()



    OmniBar.MultiSelectListItem{
        id: notePropertiesIdentityWidget
        model: ["Post as yourself", "Post as Anonimous"]
        selected: 0
        onClick: noteProperties.updateValues()
    }

    OmniBar.SectionHeader{
        text: "Note expiery"
    }

    OmniBar.SimpleListItem{
        text: "Never expire"
        Widgets.Checkmark{
            id: widgetNeverExpire
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            checked: true
            onCheckedChanged: notePropertiesExpieryWidget.selected = checked? -1: 0
        }
        onClicked: widgetNeverExpire.toggle()
    }

    OmniBar.MultiSelectListItem{
        id: notePropertiesExpieryWidget
//        model: ["1day", "5day", "15day", "1Mo", "6Mo", "1Yr", "3Yr"]
        selected: -1
        enabled: !widgetNeverExpire.checked
        onSelectedChanged: noteProperties.updateValues()
    }

    OmniBar.SectionHeader{
        text: "Allowed Takes"
    }

    OmniBar.SimpleListItem{
        text: "Unlimited"
        Widgets.Checkmark{
            id: widgetUnlimitedTakes
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            checked: true
            onCheckedChanged: notePropertiesLimitWidget.selected = checked? -1: 0
        }
        onClicked: widgetUnlimitedTakes.toggle()
    }

    OmniBar.MultiSelectListItem{
        id: notePropertiesLimitWidget
//        model: ["5", "10", "15", "30", "80", "100", "300"]
        selected: -1
        enabled: !widgetUnlimitedTakes.checked
        onSelectedChanged: noteProperties.updateValues()
    }

}
