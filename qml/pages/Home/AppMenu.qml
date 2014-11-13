import QtQuick 2.0

import "../../scripts/Icons.js" as Icons
import "../../common/SideBar" as SideBar

SideBar.Widget {
    id: appMenu

    SideBar.SimpleListItem{
        text: "User Name<br><small>user.email@server.com</small>"
    }
    SideBar.SectionHeader{text:"Places"}
    SideBar.SimpleListItem{
        text: "New Note"
        icon: Icons.LOGO
        onClicked: {
            appMenu.contractTray();
            page.actionBarMenu = false;
            app.goToPage(app.pages["AddNote"]);
        }
    }
    SideBar.SimpleListItem{
        text: "My Notes"
        icon: Icons.LOCATION
    }
    SideBar.SimpleListItem{
        text: "My Pocket"
        icon: Icons.POCKET
    }
    SideBar.SectionHeader{text:"Options"}
    SideBar.SimpleListItem{
        text: "App Settings"
    }
    SideBar.SimpleListItem{
        text: "About"
    }
    SideBar.SimpleListItem{
        text: "Legal"
    }
}
