(function(window){
  $(document).ready(function(){
    $('#start-btn').click(function(){
      if($(this).text()==='Grabar'){
        startRecording();
        $(this).text('Parar');
      }else{
        stopRecording();
        $('#meaning').show();
        $(this).text('Grabar');
        $(this).hide();
      }

      if(navigator.getUserMedia) {
        $('#warning').hide();
      } else {
        $('#start-btn').hide();
        $('#meaning').hide();

        alert("Favor de usar Chrome y permitir acceso al micrófono");
      }

      if(!recorder) {
        $('#start-btn').hide();
        $('#meaning').hide();
        $('#warning').show();
        alert("Favor de actualizar la página y permitir acceso al microfono");
      }

    });
    $('.play-btn').click(function(){
      document.getElementById(this.getAttribute('id')).play();
    });
    $('.play-btn2').click(function(){
      alert("help!")
      alert("this is the attribute id" + this.getAttribute('id'))
    });

    $('#clipControl').click(function(){
      alert("help!");
    });

  });

})(window);
