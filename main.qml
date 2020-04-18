import QtQuick 2.12
import QtQuick.Window 2.0
import QtQuick.Controls 2.0

ApplicationWindow {
    visible: true
    //width: 640
    //height: 480
    title: qsTr("qToDo")
    id: root
    //minimumWidth: 640
    //minimumHeight: 480

    TodoList {
        id: list
        onTodoChecked: function (id, checked) {
            db.onTodoChecked(id, checked)
        }

        onDeleteTodo: function (id) {
            db.deleteTodo(id)
        }
    }

    TodoDb {
        id: db
        onGotData: function (data) {
            list.model = data
        }
    }

    Rectangle {
        id: rectangle
        height: 45
        color: "lightsteelblue"
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.margins: 5

        TextEdit {
            id: textEdit
            text: qsTr("Text Edit")
            clip: true
            anchors.rightMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.right: newButton.left
            font.pixelSize: 18
            color: "black"
        }

        Button {
            id: newButton
            text: "Add"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right

            onClicked: {
                db.insertTodo(textEdit.text)
                textEdit.clear()
            }
        }
    }
}

/*##^##
Designer {
    D{i:4;anchors_x:53}
}
##^##*/
