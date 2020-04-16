import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

ListView {
    id: list
    anchors.fill: parent

    signal todoChecked(int index, bool checked)
    signal deleteTodo(int id)

    model: [
        {id: 1, message: 'hi', checked: false}
    ]

    delegate: Rectangle {
        height: 45
        width: parent.width
        CheckBox {
            id: checkBox
            text: modelData.message
            anchors.left: parent.left
            checked: modelData.checked
            anchors.right: deleteButton.left
            onCheckedChanged: todoChecked(modelData.id, checkBox.checked)
        }

        Button {
            id: deleteButton
            text: "Delete"
            anchors.right: parent.right
            Layout.alignment: Qt.AlignRight
            onClicked: {
                deleteTodo(modelData.id)
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1;anchors_width:525;anchors_x:64}
}
##^##*/
