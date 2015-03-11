(function(window){
  $(document).ready(function(){

    $('#clip-play').click(function(){
      var bob = $('.clip')[0];
      bob.play();
    });

    $('.my-play-button').on('click', function() {
      var url = $(this).attr('data');
      new Audio(url).play();
    });

    $('#start-btn').click(function(){
      if($(this).text()==='Grabar'){
        startRecording();
        $(this).text('Parar');
      }else{
        stopRecording();
        $('#meaning').show();
        $(this).text('Grabar');
        $(this).hide();
        $('#clip-play').show();
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
      alert("help!");
      alert("this is the attribute id" + this.getAttribute('id'));
    });

    $('#clipControl').click(function(){
      alert("help!");
    });

  });


  var audio_context;
  var recorder;
  function startUserMedia(stream) {
    var input = audio_context.createMediaStreamSource(stream);

    recorder = new Recorder(input);
  }
  function startRecording() {
    recorder && recorder.record();
  }
  function stopRecording() {
    recorder && recorder.stop();
    createDownloadLink();
    recorder.clear();
  }

  function createDownloadLink() {
    recorder && recorder.exportWAV(function(blob) {
      var url = URL.createObjectURL(blob);
      var li = document.createElement('li');
      var au = document.createElement('audio');
      var clipID = new Date().toISOString() + '.wav';
      au.preload='auto'
      au.className = "clip"
      au.src = url;
      li.appendChild(au);
      recordingslist.appendChild(li);
    });
  }
  
  window.onload = function init() {
    try {
      window.AudioContext = window.AudioContext || window.webkitAudioContext;
      navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia;
      window.URL = window.URL || window.webkitURL;
      audio_context = new AudioContext;
    } catch (e) {
      alert('No web audio support in this browser!');
    }

    navigator.getUserMedia({audio: true}, startUserMedia, function(e) {
      alert("Problems!");
    });
  };
})(window);
