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
    $('.container').hide();
    axios.post(`https://${GetParentResourceName()}/closeinvoice`, {})
})