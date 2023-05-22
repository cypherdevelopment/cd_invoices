$(function () {
    // Hide Tablet 
    $(".tablet").hide();

    window.addEventListener('message', function(event) {
        // Assign Data 
        let data = event.data;

        // Open UI
        if (data.type === "opentablet") {
            $('.tablet').show();
        }

        // Close UI 
        if (data.type === "closetablet") {
            $('.tablet').hide();
        }

    })
})