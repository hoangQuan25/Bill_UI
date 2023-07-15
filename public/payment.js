// JavaScript code for handling form submission
var paymentData = [];

function confirmPayment() {
  var productName = document.getElementById('productName').value;
  var quantity = parseInt(document.getElementById('quantity').value);

  var paymentDetail = {
    productName: productName,
    quantity: quantity
  };

  paymentData.push(paymentDetail);

  var paymentDetailsTable = document.getElementById('billTable');
  var tbody = paymentDetailsTable.getElementsByTagName('tbody')[0];
  var row = tbody.insertRow();
  var productNameCell = row.insertCell(0);
  var quantityCell = row.insertCell(1);
  productNameCell.textContent = productName;
  quantityCell.textContent = quantity;

  updateTotalCost();
}

document.getElementById('paymentForm').addEventListener('submit', function (event) {
  event.preventDefault(); // Prevent form submission

  var xhr = new XMLHttpRequest();
  xhr.open('POST', '/process_payment');
  xhr.setRequestHeader('Content-Type', 'application/json');

  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4) {
      if (xhr.status === 200) {
        // Payment processed successfully
        console.log(xhr.responseText);
        alert('Payment processed successfully.');
        resetForm();
      } else {
        // Error occurred during payment processing
        alert('An error occurred while processing the payment.');
        console.error(xhr.responseText);
      }
    }
  };

  // Retrieve form values
  var employeeName = document.getElementById('employeeName').value;
  var totalCost = calculateTotalCost();

  // Send the payment data as JSON
  var data = JSON.stringify({
    employeeName: employeeName,
    paymentData: paymentData,
    totalCost: totalCost
  });

  xhr.send(data);
});

function deleteAllRows() {
  var paymentDetailsTable = document.getElementById('billTable');
  var tbody = paymentDetailsTable.getElementsByTagName('tbody')[0];
  while (tbody.firstChild) {
    tbody.removeChild(tbody.firstChild);
  }

  paymentData = [];
  updateTotalCost();
}

function updateTotalCost() {
  var totalCost = calculateTotalCost();
  var totalCostDiv = document.getElementById('totalCost');
  totalCostDiv.textContent = 'Total Cost: ' + totalCost.toLocaleString() + ' VND';
}

function calculateTotalCost() {
  var totalCost = 0;

  paymentData.forEach(function (detail) {
    var productName = detail.productName;
    var quantity = detail.quantity;

    var xhr = new XMLHttpRequest();
    xhr.open('GET', '/get_product_price?productName=' + encodeURIComponent(productName), false);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send();

    if (xhr.readyState === 4 && xhr.status === 200) {
      var product = JSON.parse(xhr.responseText);
      var price = parseFloat(product.price);
      totalCost += price * quantity;
    }
  });

  return totalCost;
}

function resetForm() {
  document.getElementById('productName').value = '';
  document.getElementById('quantity').value = '';
  var tbody = document.getElementById('billTable').getElementsByTagName('tbody')[0];
  while (tbody.firstChild) {
    tbody.removeChild(tbody.firstChild);
  }
  paymentData = [];
  updateTotalCost();
}
