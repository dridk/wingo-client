import QtQuick 2.0

Image {
    width: 48
    height: 48

    property string name: ""
    fillMode: Image.PreserveAspectFit
    verticalAlignment: Image.AlignVCenter
    horizontalAlignment: Image.AlignHCenter

    function getIconByName(name)
    {
        if (name !== "")
        {
            return "../Res/icons/" + name + ".png";
        }else return "../Res/icons/wingo48.png"
    }

    source: getIconByName(name)
}
