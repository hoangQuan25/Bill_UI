const { Pool } = require('pg');

const DATABASE = 'cua_hang_banh_mi';
const USER = 'postgres';
const PASSWORD = 'sinhvien';

const pool = new Pool({
    user: USER,
    host: 'localhost',
    database: DATABASE,
    password: PASSWORD,
    port: 5432,
});

module.exports = pool;
