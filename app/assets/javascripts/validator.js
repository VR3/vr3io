$(function(){
  // form
  var form = $('#contact-form');

  // messages div
  var formAlert = $('#contact-form-message');
  var formMessage = $('#contact-form-message-text')

  // checkbox
  var formCheckbox = $('#legal-checkbox');

  $(formAlert).hide();

  // prevent browser from submitting form
  $(form).submit(function(event){
    event.preventDefault();
    
    // check if Privacy and TOS are in compliance
    if($(formCheckbox).is(':checked')){
      // serialize
      var formData = $(form).serialize();


      console.log("Form Data:", formData);

      // create the asynch request
      $.ajax({
        type: 'POST',
        url: $(form).attr('action'),
        data: formData,
        crossDomain: true
      })
      //success
      .done(function(res){
        
        console.log("done",res);
        $(formAlert).fadeIn('fast');
        //$(formAlert).removeClass('alert alert-info');
        //$(formAlert).addClass('alert alert-success');
        $(formMessage).html(res);
        $('#name').val('');
        $('#email').val('');
        $('#message').val('');
        $('#option').val('');

        setTimeout(function(){
          $(formAlert).fadeOut('fast');
        }, 7000);

      })
      //fail
      .fail(function(data){

        $(formAlert).fadeIn('fast');

        if(data.responseText !== ''){
          console.log("data", data);
          $(formMessage).html(data.responseText);
        } else{
          $(formAlert).removeClass('alert alert-info');
          $(formAlert).addClass('alert alert-error');
          $(formMessage).html('<strong>Oops!</strong> Ocurrió un error inesperado. Intenta de nuevo.');
        }
        $('#name').val('');
        $('#email').val('');
        $('#message').val('');
        $('#option').val('');

        setTimeout(function(){
          $(formAlert).fadeOut('fast');
        }, 7000);

      });
    } else{
      alert ("Debes aceptar el Aviso de Privacidad y los Términos de Uso.");
    }
  });
});