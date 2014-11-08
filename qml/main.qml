import QtQuick 2.3
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.2
import Wingo 1.0
import "common"
import "pages"
import "scripts/AppStyle.js" as Style

WingoApplication {
    id : app

    //Qt.resolve : only load when it's necessary
   pages: {
        "Home": "pages/Home.qml",
     "AddNote": "pages/AddNote.qml"
    }

    initialPage  : Home {

    }





}
