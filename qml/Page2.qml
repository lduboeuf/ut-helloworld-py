import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

Page {
    id:page2
    width: units.gu(45)
    height: units.gu(75)

    anchors.fill: parent

    header: PageHeader {
        id: header
        title: i18n.tr('Page 2')
    }

    
    Label {
            id:label
            anchors.centerIn: parent
            text: i18n.tr('Hello Page2 - var from MainView:') + root.myglobalvar
    }

    

    




}