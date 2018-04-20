import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import io.thp.pyotherside 1.2

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'helloworldpy.ldub'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    Page {
        id: page1
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('HelloWorldPy')
        }


        Label {
            id:label
            anchors.top: header.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10
            text: i18n.tr('Hello World!')
        }

        Button {
            id:btn
            anchors.top: label.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 5
            color: "blue"
            text: i18n.tr('click me!')
            onClicked: {
                python.getFiles()
            }
        }


        Label {
            id:listview_title
            anchors.top: btn.bottom
            anchors.left: parent.left
            text: i18n.tr('Directory Listing:')
        }

        ScrollView {

            anchors.top: listview_title.bottom
            anchors.left: parent.left
            width: parent.width
            anchors.bottom: status.top
            anchors.bottomMargin: 10

            ListView {
                id: listView
                anchors.leftMargin: 5

                delegate: 
                    Rectangle {
                        height: childrenRect.height + 5
                        width: parent.width
                        border.width: 1
                        border.color: "lightgray"
                        Text {
                            font.pointSize: 14;
                            color: 'black';
                            text: modelData;
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: listView.currentIndex = index
                        }
                    }
                onCurrentItemChanged: console.log(listView.model[listView.currentIndex] + ' selected')
                    
            }
        }

        Button {
            id:btnPage2
            text: i18n.tr('navigate to page2')
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            color: "green"
            onClicked: {
                stackView.push("qml/Page2.qml")
            }
        }


    }

    PageStack {
        id: stackView
        Component.onCompleted: push(page1)
    }

    Python {
        id: python

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('./'));

            importModule('mymodule', function() {
                console.log('mymodule module imported');
                python.call('mymodule.speak', ['Hello World!'], function(returnValue) {
                    console.log('mymodule.speak returned ' + returnValue);
                    label.text = returnValue
                })

            });
            
        }

        function getFiles(){
            call('mymodule.listdir', ['.'], function(result) {
                        //console.log('dir listing: ' + result);
                        listView.model = result;
            });
        }

        onError: {
            console.log('python error: ' + traceback);
        }
    }
}
