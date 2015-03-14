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
        $('#progressbar').show();
        $('.progress-value').show();
        $('.progress-value').text('Espera...Subiendo clip');
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
      sendWaveToPost(blob);

    } else { alert('Clip tiene que ser entre 1 y 30 segundos'); }

      if(!li){
        $('#start-btn').show();
        $('#start-btn').text('Grabar');
        $('#meaning').hide();
        $('#clip-play').hide();
      }
    });
  }

  function sendWaveToPost(blob) {
    var data = new FormData();
    data.append('audio', blob, (new Date()).getTime() + '.mp3');

    var oReq = new XMLHttpRequest();
    oReq.addEventListener('progress', updateProgress, false);
    oReq.addEventListener('load', transferComplete, false);
    oReq.open('POST', '/uploads');
    oReq.setRequestHeader('X-CSRF-Token',
      'xobbGEAxrKTnjkzCcIBB69Df391+sMX6pcqp500R9jmutFCeAv69tCVbngovFHvHaiizJRXDP8R1ugfNxdC61Q');
    oReq.send(data);
    var startTime = (new Date()).getTime();
    console.log('Upload started');

      function updateProgress (oEvent) {
        if (oEvent.lengthComputable) {

        var percentComplete = (oEvent.loaded / oEvent.total) * 100;

        $('#progressbar').val(percentComplete);
        console.log('progress is now: ' + percentComplete);
        $('.progress-value').html(percentComplete + '%');
      } else {
        alert('Algo no funciona');
      }

    }

    function transferComplete(evt) {
      endTime = (new Date()).getTime();
      alert('The transfer is complete after: ' + (endTime - startTime) / 1000 + ' seconds');
    }

    oReq.onload = function(oEvent) {
      if (oReq.status == 200) {
          console.log('Uploaded');
      } else {
          alert('Error ' + oReq.status + ' when uploading your file.');
      }
    };
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
