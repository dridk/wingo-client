import QtQuick 2.0

Image {
    width: _RES.scale(48)
    height: _RES.scale(48)

    property string name: ""

    function getIconByName(name)
    {
        if (name !== "")
        {
            return "../Res/icons/" + name + ".png";
        }else return "../Res/icons/wingo48.png"
    }

    source: getIconByName(name)
}
