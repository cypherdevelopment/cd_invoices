// Get Values from Tablet
let customername = document.getElementById("customername");
let customerid = document.getElementById("customerid");
let invoicedesc = document.getElementById("invoicedesc");
let invoiceamt = document.getElementById("invoiceamt");

// $(function () {
//   // Hide Tablet
//   $(".tablet").hide();

//   window.addEventListener("message", function (event) {
//     // Assign Data
//     let data = event.data;

//     // Open UI
//     if (data.type === "opentablet") {
//       $(".tablet").show();
//     }

//     // Close UI
//     if (data.type === "closetablet") {
//       $(".tablet").hide();
//     }
//   });
// });

document.getElementById("sbmtbtn").addEventListener("click", () => {
  console.log(customerid, customername, invoiceamt, invoiceamt);
});
