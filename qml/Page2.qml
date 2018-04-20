import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

Page {
    width: units.gu(45)
    height: units.gu(75)

    title: qsTr("Page 2")

    Label {
        text: qsTr("You are on Page 2. kikou zonote")
        anchors.centerIn: parent
    }


}