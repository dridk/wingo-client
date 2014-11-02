import QtQuick 2.3
import QtQuick.Window 2.0
import QtQuick.Controls 1.2
import Wingo 1.0
import "scripts/AppStyle.js" as Style

ApplicationWindow {
    id: app
    visible: true
    //Needed for QtCreator design mode
    width: 540
    height: 960
    //-----------

    color: Style.Background.WINDOW


    Text{
        id:textId
        anchors.centerIn: parent

    }

    Row {
        anchors.right: parent.right

        Text {
            id: totalId
            width: 100
            text:"1000000"
        }

        TextField {
            id: radiusId
            width: 100
            placeholderText: "radius"
            text:"1000000"
        }
        TextField {
            id: lat
            width: 100
            placeholderText: "latitude"
            text:"43.601337"
        }
        TextField {
            id: longi
            width: 100
            placeholderText: "longitude"
            text:"1.438675"
        }


    }




    Button {
        id:bt
        text: "test"

//        onClicked: request.get({"at": lat.text+","+longi.text,"radius": radiusId.text})
          onClicked: request.post({
                                      "at": lat.text+","+longi.text,
                                      "author":"54553bca12f8034017ad2e3c",
                                      "anonymous":true,
                                      "message":"This is a qml message sended from qml"


                                  })


    }



    Request {
        id:request
        source:"/notes"
        onSuccess: {
            totalId.text = data.total
            listModel.clear()
            for (var index in data.results){
                listModel.append(data.results[index])
            }
        }
    }



    ListModel {
        id:listModel
    }

    ListView {
        width: app.width
        height: 800
        anchors.top: bt.bottom

        model:listModel
        clip:true
        delegate: Rectangle {
            width: app.width
            height: 80
            anchors.margins: 5
            border.color: "red"
            Text {
                anchors.fill: parent
                text:name + " " + count
                wrapMode: Text.WordWrap

            }
        }



    }


    //    StackView {
    //        id: stack
    //        anchors.fill: parent
    //        // Implements back key navigation
    //        focus: true
    //        Keys.onReleased: if (event.key === Qt.Key_Back && stackView.depth > 1) {
    //                             stackView.pop();
    //                             event.accepted = true;
    //                         }

    //        initialItem: Qt.resolvedUrl("pages/Splash.qml")
    //    }




}
