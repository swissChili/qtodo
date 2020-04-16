import QtQuick 2.0
import QtQuick.LocalStorage 2.0

Item {
    id: root
    signal gotData(variant data)

    function deleteTodo(id) {
        db.transaction(function (tx) {
            console.log("Deleting", id)
            tx.executeSql('DELETE FROM todos WHERE id = ?', [id])

            gotData(getData(tx))
        })
    }

    readonly property var db: LocalStorage.openDatabaseSync("qToDo", "1.0", "qToDo Database", 1024)

    function insertTodo(message) {
        db.transaction(function (tx) {
            tx.executeSql('INSERT INTO todos(message, checked) VALUES(?, ?)',
                          [message, false])

            gotData(getData(tx))
        })
    }

    function onTodoChecked(id, checked) {
        db.transaction(function (tx) {
            tx.executeSql('UPDATE todos SET checked = ? WHERE id = ?', [checked, id])
        })
    }

    function getData(tx) {
        var rs = tx.executeSql('SELECT id, message, checked FROM todos')
        var list = []
        for (var i = 0; i < rs.rows.length; i++) {
            var row = rs.rows.item(i)
            list.push({id: row.id, message: row.message, checked: row.checked})
        }
        return list
    }

    Component.onCompleted: {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS todos(id INTEGER PRIMARY KEY AUTOINCREMENT,' +
                          'message TEXT, checked BOOL)')

            var list = getData(tx)
            gotData(list)
        })
    }
}
