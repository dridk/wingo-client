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



        Widgets.PhotoButton {

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            onClicked: camera.imageCapture.capture()

        }

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




}
