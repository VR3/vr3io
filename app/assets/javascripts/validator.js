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

    if($(formCheckbox).is(':checked')){
      // serialize
      var formData = $(form).serialize();
      
      // check if Privacy and TOS are in compliance
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
        $(formAlert).show();
        //$(formAlert).removeClass('alert alert-info');
        //$(formAlert).addClass('alert alert-success');
        $(formMessage).html(res);
        $('#name').val('');
        $('#email').val('');
        $('#message').val('');

        setTimeout(function(){
          $(formAlert).fadeOut('fast');
        }, 5000);

      })
      //fail
      .fail(function(data){

        $(formAlert).show();
        //$(formAlert).removeClass('alert alert-info');
        //$(formAlert).addClass('alert alert-error');
        if(data.responseText !== ''){
          console.log("data", data);
          $(formMessage).html(data.responseText);
        } else{
          $(formMessage).html('<strong>Oops!</strong> Ocurrió un error inesperado. Intenta de nuevo.');
        }
        $('#name').val('');
        $('#email').val('');
        $('#message').val('');

        setTimeout(function(){
          $(formAlert).fadeOut('fast');
        }, 5000);

      });
    } else{
      alert ("Debes aceptar el Aviso de Privacidad y los Términos de Uso.");
    }
  });
});