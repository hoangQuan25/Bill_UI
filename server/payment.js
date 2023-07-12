const express = require('express');
const pool = require('./db');
const paymentRouter = express.Router();

paymentRouter.post('/process_payment', (req, res) => {
    const { employeeName, paymentData, totalCost } = req.body;

    pool.query('SELECT id_nhan_vien FROM nhan_vien WHERE ho_ten = $1', [employeeName], (err, result) => {
        if (err) {
            console.error(err);
            res.status(500).send('Internal Server Error');
        } else if (result.rows.length === 0) {
            res.status(400).send('Invalid employee name');
        } else {
            const employeeId = result.rows[0].id_nhan_vien;

            pool.query(
                'INSERT INTO hoa_don (id_nhan_vien, thoi_gian_thanh_toan, tong_tien) VALUES ($1, NOW(), $2) RETURNING id_hoa_don',
                [employeeId, totalCost],
                (err, result) => {
                    if (err) {
                        console.error(err);
                        res.status(500).send('Internal Server Error');
                    } else {
                        const billId = result.rows[0].id_hoa_don;

                        const query = 'INSERT INTO chi_tiet_hoa_don (id_hoa_don, id_san_pham, so_luong) VALUES ($1, $2, $3)';
                        paymentData.forEach((detail) => {
                            const { productName, quantity } = detail;

                            pool.query('SELECT id_san_pham FROM san_pham WHERE ten = $1', [productName], (err, result) => {
                                if (err) {
                                    console.error(err);
                                    res.status(500).send('Internal Server Error');
                                } else if (result.rows.length === 0) {
                                    console.error(`Invalid product name: ${productName}`);
                                } else {
                                    const productId = result.rows[0].id_san_pham;
                                    pool.query(query, [billId, productId, quantity], (err) => {
                                        if (err) {
                                            console.error(err);
                                            res.status(500).send('Internal Server Error');
                                        }
                                    });
                                }
                            });
                        });

                        res.send(`Successfully updated data in the database. Invoice ID: ${billId}`);
                    }
                }
            );
        }
    });
});

module.exports = paymentRouter;
