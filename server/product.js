const express = require('express');
const pool = require('./db');
const productRouter = express.Router();

productRouter.get('/get_product_price', (req, res) => {
    const productName = req.query.productName;

    pool.query('SELECT gia FROM san_pham WHERE ten = $1', [productName], (err, result) => {
        if (err) {
            console.error(err);
            res.status(500).send('Internal Server Error');
        } else if (result.rows.length === 0) {
            res.status(400).send(`Invalid product name: ${productName}`);
        } else {
            const price = result.rows[0].gia;
            res.json({ price });
        }
    });
});

module.exports = productRouter;
