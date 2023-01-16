"use strict"
const fs = require('fs');
const mysql = require('mysql2');

const config = {
    host: 'rc1b-uaae96uh5wdhgzqb.mdb.yandexcloud.net',
    port: 3306,
    user: 'user1',
    password: 'Jhon1989',
    database: 'employees',
    ssl: {
        rejectUnauthorized: true,
        ca: fs.readFileSync('./root.crt').toString(),
    },
}

const conn = mysql.createConnection(config)
conn.connect(err => {
    if (err) throw err
})
conn.execute()
conn.query('SELECT version()', (err, result, fields) => {
    if (err) throw err
    console.log(result[0])
    conn.end()
})


// const fs = require('fs');
// const mysql = require('mysql2');
// const connection = mysql.createConnection({
//     host: 'rc1b-uaae96uh5wdhgzqb.mdb.yandexcloud.net',
//     port: 3306,
//     user: 'user1',
//     password: 'Jhon1989',
//     database: 'db1',
//     ssl: {
//         ca: fs.readFileSync('./root.crt'),
//     }
// });
// connection.connect();
