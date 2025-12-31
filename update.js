var mysql = require("mysql");

var connection = mysql.createConnection({

    host: "localhost",

    user: "RzBhqnd1k4",

    password: "password123",

    database: "schooldb"

});

connection.connect((err) => {

    if (err) throw err;

    console.log("Connected to MySQL");

    var sql = "UPDATE Students SET Student_City='Mumbai' WHERE Student_ID=102";

    connection.query(sql, function (err, result) {

        if (err) throw err;

        console.log("Data Updated in Table");

        connection.end();

    });

});