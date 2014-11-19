import QtQuick 2.0

import "../../scripts/Icons.js" as Icons
import "../../common/SideBar" as SideBar

SideBar.Widget {
    id: appMenu

    SideBar.SimpleListItem{
        text: "User Name<br><small>user.email@server.com</small>"
        onClicked: page.goLogin()
    }
    SideBar.SectionHeader{text:"Places"}
    SideBar.SimpleListItem{
        text: "New Note"
        icon: Icons.POST
        onClicked: page.goPost()
    }
    SideBar.SimpleListItem{
        text: "My Notes"
        icon: Icons.NOTEBOOK
    }
    SideBar.SimpleListItem{
        text: "My Pocket"
        icon: Icons.POCKET
        onClicked: page.goPocket()
    }
    SideBar.SectionHeader{text:"Options"}
    SideBar.SimpleListItem{
        text: "App Settings"
        icon: Icons.GEAR
    }
    SideBar.SimpleListItem{
        text: "About"
        icon: Icons.INFO
    }
    SideBar.SimpleListItem{
        text: "Legal"
        icon: Icons.INFO
    }
}
