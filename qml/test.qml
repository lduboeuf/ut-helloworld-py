import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem
MainView {
width: units.gu(48)
height: units.gu(60)
PageStack {
id: pageStack
Component.onCompleted: push(page0)
Page {
id: page0
title: i18n.tr("Root page")
visible: false
Column {
anchors.fill: parent
ListItem.Standard {
text: i18n.tr("Page one")
onClicked: pageStack.push(page1, {color: UbuntuColors.orange})
progression: true
}
ListItem.Standard {
text: i18n.tr("External page")
onClicked: pageStack.push(Qt.resolvedUrl("MyCustomPage.qml"))
progression: true
}
}
}
Page {
title: "Rectangle"
id: page1
visible: false
property alias color: rectangle.color
Rectangle {
id: rectangle
anchors {
fill: parent
margins: units.gu(5)
}
}
}
}
}