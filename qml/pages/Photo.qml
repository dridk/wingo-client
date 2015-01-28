import QtQuick 2.0

import QtQuick 2.3
import Wingo 1.0
import QtMultimedia 5.4


import "../scripts/Icons.js" as Icons
import "../scripts/AppStyle.js" as Style
import "../common/Layouts" as Layouts
import "../common/Controls" as Widgets
import "../common/ActionBar" as ActionBar

Layouts.Page {
    id: page
    color: "black"
    // DO we provide a dedicated Layout for Photos ?

    signal imageCaptured(string path)







    VideoOutput {
        source: camera
        anchors.fill: parent
        autoOrientation: true




    }

    Camera {
        id: camera
        imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash

        exposure {
            exposureCompensation: -1.0
            exposureMode: Camera.ExposurePortrait
        }

        flash.mode: Camera.FlashRedEyeReduction


        imageCapture {
            onImageSaved: {
                page.imageCaptured(path)
                page.back()
            }
        }
    }



    Rectangle {
        width: 600
        height: 600
        color: "white"
        opacity: 0.4

        MouseArea{
            anchors.fill: parent
            drag.target: parent
            drag.axis: Drag.XAndYAxis
            drag.minimumX: 0
            drag.maximumX: page.width - parent.width
            drag.minimumY: 0
            drag.maximumY: parent.height
            onDoubleClicked: camera.imageCapture.capture()
        }

    }



}
