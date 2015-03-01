$('#playsound').click(function (e) {
    $('#sound_effect')[0].currentTime = 0;
    $('#sound_effect')[0].play();

    return false;
});
