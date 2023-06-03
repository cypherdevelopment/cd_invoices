$('.container').hide();

$(function() {
    window.addEventListener('message', function(event) {
        let data = event.data; 

        if (data.type === "createinvoice") {
            $(".container").show();
        }
    })
})

document.getElementById('createbtn').addEventListener('click', () => {
    // Hide UI 
    $('.container').hide();

    // Get Field Value 
    let amount = document.getElementById('invoiceamount').value 
    let playerid = document.getElementById('playerid').value
    let title = document.getElementById('invoicetitle').value

    // Checking 
    if (!amount || !playerid || !title) {
        axios.post(`https://${GetParentResourceName()}/closeui`, {})
    } else {
        axios.post(`https://${GetParentResourceName()}/submitinvoice`, {
            playerid,
            amount,
            title
        })
    }

    document.getElementById('invoiceform').reset();
})