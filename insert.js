var mysql = require("mysql2");

// create connection

var connection = mysql.createConnection({

    host: "localhost", // or your remote host

    user: "root", // your MySQL username

    password: "qweASD1@2012", // your MySQL password

    database: "School" // your database name

});

// connect to database

connection.connect((err) => {

    if (err) throw err;

    console.log("connected");

    var sql =

        "INSERT INTO Students (Student_ID, Student_FirstName, Student_LastName, Student_City, Student_Grade) VALUES ?";

    var values = [

        [101, "Teenu", "Prashant", "Madurai", 5],

        [103, "Chintu", "Prakash", "Chennai", 6],

        [107, "Caral", "Smith", "Texas", 2],

        [109, "Riya", "Gupta", "Pune", 9],

        [102, "Teka", "Prashant", "Bangalore", 8]

    ];

    connection.query(sql, [values], function (err, result) {

        if (err) throw err;

        console.log("Multiple Data inserted in DB");

    });

});