
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



    Rectangle {
        id:container
        width: parent.width
        height: parent.width



        VideoOutput {
            source: camera
            anchors.fill: parent
            autoOrientation: true
            fillMode: VideoOutput.PreserveAspectCrop

        MouseArea {
            anchors.fill: parent
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
                resolution: Qt.size(container.width, container.width)
                onImageSaved: {
                    wingo.cropImage(path,400,400)
                    page.imageCaptured(path)
                    page.back()
                }
            }
        }


    }



}
