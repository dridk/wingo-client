import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../scripts/AppStyle.js" as Style
import "../common"

Page {
    id: page
    //Needed for QtCreator design mode
    width: 540
    height: 960
    //-----------

    icon: "wingo48"
    title: "80 Inverlochy Blvd<br><small>Toronto, ON</small>"
    defaultAction: Style.ACTION_BAR_MENU_ACTION

    actionsListModel: ListModel{
        ListElement {
            icon: "refresh48"
            name: "refresh"
        }
        ListElement {
            icon: "pocket48"
            name: "pocket"
        }
    }

    onMenuButtonClicked: console.log("Menu from Home")
    onActionButtonClicked: {
        console.log("Action button " + name + " clicked at index " + index)
        switch (index){
         case 0:
             app.goToPage(app.pages["AddNote"])
             break;
        }
    }

    FilterBar {
        id: filterbar
        anchors.top: parent.top
    }

    Item{
        anchors.top: filterbar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        clip: true

//        Rectangle{
//            id: rectangle1
//                        anchors.left: parent.left
//                        anchors.right: parent.right
//                        height: 96
//                        color: Style.Background.VIEW

//                        RowLayout{
//                            id: rowLayout1
//                            anchors.bottom: parent.bottom
//                            anchors.bottomMargin: 16
//                            anchors.top: parent.top
//                            anchors.topMargin: 16
//                            anchors.left: parent.left
//                            anchors.leftMargin: 32
//                            anchors.right: parent.right
//                            anchors.rightMargin: 8
//                            ColumnLayout{
//                                Layout.fillWidth: true

//                                Label{text: noteAnonymous? "Anonimous" : noteAuthor; font.pointSize: 12; Layout.fillWidth: true}
//                                Label{text: noteMessage; Layout.fillWidth: true}
//                            }
//                            ColumnLayout{
//                                width: 64
//                                Label{text: "30d left"; horizontalAlignment: Text.AlignRight; font.pointSize: 12;Layout.fillWidth: true}
//                                Label{text: "12 takes"; horizontalAlignment: Text.AlignRight; font.pointSize: 12;Layout.fillWidth: true}
//                            }
//                        }

//                        Rectangle{
//                            height: 2
//                            anchors.bottom: parent.bottom
//                            anchors.left: parent.left
//                            anchors.right: parent.right
//                            color: Style.Border.DEFAULT
//                        }
//                    }

        ListView {
            anchors.fill: parent

            model: ListModel{
                ListElement{
                    noteAuthor: "Someone"
                    noteAvatar: "url://"
                    noteAnonymous: false
                    noteMessage: "There is a cute dog here :) Come check it out - it's soooo cuuuute!! I really like dogs, especially cute ones!"
                    noteLocation: []
                    noteExpiration: ""
                    noteTimestamp: ""
                    noteTakes: 5
                    noteLimit: 10
                    noteTags: []
                }
                ListElement{
                    noteAnonymous: true
                    noteMessage: "Hey guys! Mad party going on here >>"
                    noteLocation: []
                    noteExpiration: ""
                    noteTimestamp: ""
                    noteTakes: 5
                    noteLimit: 10
                    noteTags: []
                }
                ListElement{
                    noteAuthor: "Someone2"
                    noteAvatar: "url://"
                    noteAnonymous: false
                    noteMessage: "This is a free online calculator which counts the number of characters or letters in a text, useful for your tweets on Twitter, as well as a multitude of other applications."
                    noteLocation: []
                    noteExpiration: ""
                    noteTimestamp: ""
                    noteTakes: 5
                    noteLimit: 10
                    noteTags: []
                }
            }

            delegate: Rectangle{
                id: rectangle1
                            anchors.left: parent.left
                            anchors.right: parent.right
                            height: Math.max(96, noteMessage.length / 18 * 16 + 48)
                            color: Style.Background.VIEW

                            RowLayout{
                                id: rowLayout1
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 8
                                anchors.top: parent.top
                                anchors.topMargin: 8
                                anchors.left: parent.left
                                anchors.leftMargin: 32
                                anchors.right: parent.right
                                anchors.rightMargin: 8
                                spacing: 8

                                ColumnLayout{
                                    Layout.fillWidth: true

                                    Label{text: (noteAnonymous? "Anonimous" : noteAuthor) + " 1h"; font.pointSize: 12; color: Style.Typography.LINK; Layout.fillWidth: true}
                                    Label{text: noteMessage; Layout.fillWidth: true; Layout.fillHeight: true; wrapMode: Text.WordWrap}
                                }
                                ColumnLayout{
                                    width: 64
                                    Label{text: "30d left"; horizontalAlignment: Text.AlignRight; font.pointSize: 12; color: Style.Typography.LINK ;Layout.fillWidth: true}
                                    Label{text: "12 takes"; horizontalAlignment: Text.AlignRight; font.pointSize: 12; color: Style.Typography.ACCENT ;Layout.fillWidth: true}
                                }
                            }

                            Rectangle{
                                height: 2
                                anchors.bottom: parent.bottom
                                anchors.left: parent.left
                                anchors.right: parent.right
                                color: Style.Border.DEFAULT
                            }
                        }
        }

    }


}
