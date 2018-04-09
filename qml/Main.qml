import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import io.thp.pyotherside 1.2

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'helloworldpy.ldub'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('HelloWorldPy')
        }

        

        Label {
            id:label
            anchors.centerIn: parent
            text: i18n.tr('Hello World!')
        }

        Button {
            id:btn
            anchors.top: label.bottom
            anchors.left: label.left
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
            anchors.bottom: status.top

            ListView {
                id: listView
                
                spacing: 1
                delegate: Text { color: 'black'; text: modelData; }
            }
        }

        Label {
            id:status
            anchors.bottom: parent.bottom
            text: i18n.tr('rien du tout')
        }
    }

    Python {
        id: python

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('./'));

            importModule('module_name', function() {
                console.log('module_name module imported');
                python.call('module_name.speak', ['Hello World!'], function(returnValue) {
                    console.log('module_name.speak returned ' + returnValue);
                    status.text = returnValue
                })

            });

            importModule('os', function() {
                    console.log('Python module "os" is now imported');
/*
                    // Asynchronous function calls
                    call('os.listdir', [], function(result) {
                        console.log('dir listing: ' + result);
                        listView.model = result;
                    });
*/
                });
            
        }

        function getFiles(){
            call('os.listdir', ['/'], function(result) {
                        //console.log('dir listing: ' + result);
                        listView.model = result;
            });
        }

        onError: {
            console.log('python error: ' + traceback);
        }
    }
}
