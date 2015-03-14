(function(window){
  $(document).ready(function(){

    $('#clip-play').click(function(){
      $('.clip')[0].play();
    });

    $('.my-play-button').on('click', function() {
      var url = $(this).attr('data');
      new Audio(url).play();
    });

    $('#start-btn').click(function(){
      if($(this).text() === 'Grabar'){
        startRecording();
        $(this).text('Parar');
      } else {
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
      }

      if(!recorder) {
        $('#start-btn').hide();
        $('#meaning').hide();
        $('#warning').show();
        alert('Favor de usar Chrome, actualizar la página y permitir acceso al micrófono');
      }
    });

    $('.play-btn').click(function(){
      document.getElementById(this.getAttribute('id')).play();
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
      if(blob.size > 70000 && blob.size < 2500000) {
      var url = URL.createObjectURL(blob);
      var li = document.createElement('li');
      var au = document.createElement('audio');
      au.preload='auto';
      au.className = 'clip';
      au.src = url;
      li.appendChild(au);
      recordingslist.appendChild(li);
    } else { alert('Clip tiene que ser entre 1 y 30 segundos'); }

      if(!li){
        $('#start-btn').show();
        $('#start-btn').text('Grabar');
        $('#meaning').hide();
        $('#clip-play').hide();
      }
    });
  }

  window.onload = function init() {
    try {
      window.AudioContext = window.AudioContext || window.webkitAudioContext;
      navigator.getUserMedia = navigator.getUserMedia ||
                              navigator.webkitGetUserMedia;
      window.URL = window.URL || window.webkitURL;
      audio_context = new AudioContext;
    } catch (e) {
      alert('Favor de usar Chrome');
    }

    navigator.getUserMedia({audio: true}, startUserMedia, function(e) {
      alert('Favor de usar Chrome, actualizar la página, y permitir acceso al micrófono');
    });
  };
})(window);
