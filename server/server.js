const express = require('express');
const path = require('path');
const paymentRouter = require('./payment');
const productRouter = require('./product');

const app = express();
const PORT = 3000;

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.static(path.join(__dirname, '..', 'public')));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'public', 'payment.html'));
});

app.use(paymentRouter);
app.use(productRouter);

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
