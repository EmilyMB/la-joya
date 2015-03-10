(function(window){
  $(document).ready(function(){
    $("#start-btn").click(function(){
      if($(this).text()==='Grabar'){
        startRecording();
        $(this).text('Parar');
      }else{
        stopRecording();
        $(this).text('Grabar');
      }
      if(!navigator.getUserMedia) {
        $('#start-btn').hide();
        $('#meaning').hide();
        alert("Favor de usar Chrome y permitir acceso al microfono");
      }

      if(!recorder) {
        $('#start-btn').hide();
        $('#meaning').hide();
        alert("Favor de refrescar la página y permitir acceso al microfono");
        $('#warning').show();
      }

    });
    $('.play-btn').click(function(){
      document.getElementById(this.getAttribute('id')).play();
    });
    $('.play-btn2').click(function(){
      alert("help!")
      alert("this is the attribute id" + this.getAttribute('id'))
    });
  });

})(window);
