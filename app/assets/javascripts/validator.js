
$(function(){
  // form
  var form = $('#contact-form');

  // messages div
  var formAlert = $('#contact-form-message');
  var formMessage = $('#contact-form-message-text')

  // checkbox
  var formCheckbox = $('legal-checkbox');

  $(formAlert).hide();

  // prevent browser from submitting form
  $(form).submit(function(event){
    event.preventDefault();

    // serialize
    var formData = $(form).serialize();
    console.log("FormData:",formData);
  
    // check if Privacy and TOS are in compliance
    if(!$(formCheckbox).is(':checked')){

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
        
        console.log("fail",data);

        $(formAlert).show();

        //$(formAlert).removeClass('alert alert-info');
        //$(formAlert).addClass('alert alert-error');
      
        if(data.responseText !== ''){
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
      $(formMessage).html('<strong>Alerta </strong> Debes aceptar el <a href="http://vr3.io/privacy"> Aviso de Privacidad y los Términos de Uso.</a>');
    }
  });
});