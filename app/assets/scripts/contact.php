
<?php

  header('content-type: application/json; charset=utf-8');
  header('Access-Control-Allow-Origin: *'); 

  if($_POST){

    $name = strip_tags(trim($_POST['name']));
    $email = filter_var(trim($_POST['email']), FILTER_SANITIZE_EMAIL);
    $message = trim($_POST['message']);
    $option = trim($_POST['option']);
    $budget = trim($_POST['budget']);
    $to = 'info@vr3.io';
    $subject = 'Mensaje de Contacto | VR3.io';

    $headers = "From: " . $name . " <" . $email . ">";

    //reCAPTCHA
    $secret = "6Ld6AR8TAAAAAEk5DJoa7X-d29aUQaFzLRaaDztc";
    $captcha = '';
    if (isset($_POST["g-recaptcha-response"])){
      $captcha = $_POST["g-recaptcha-response"];
    }

    $captchaResponse = json_decode(file_get_contents("https://www.google.com/recaptcha/api/siteverify?secret=".$secret."&response=".$captcha."&remoteip=".$_SERVER["REMOTE_ADDR"]), true);

    if($captchaResponse["success"]){

       $contactMessage =  "Nombre: ". $name . "\nCorreo: ". $email ."\nInterés: " . $option . "\nPresupuesto: ".$budget. "\nMensaje:".$message;
        if(empty($name) or empty($message) or empty($option)or !filter_var($email, FILTER_VALIDATE_EMAIL)){
          http_response_code(400);
          echo "<strong>Oops!</strong> Hubo un problema con tus datos. Intenta de nuevo.";
        } else {
          if(mail($to, $subject, $contactMessage, $headers)){
            http_response_code(200);
            echo "<strong>Gracias!</strong> Tu mensaje ha sido enviado. Nos pondremos en contacto pronto.";
          } else{
            http_response_code(500);
            echo "<strong>Oops!</strong> Hubo un problema con el servidor. Intenta más tarde.";
          }
        }
      } else {
        http_response_code(403);
        echo "<strong>Error</strong> Hubo un problema con tus datos. Intenta de nuevo.";
      }

    } else{
      http_response_code(400);
        echo "<strong>Error</strong> Hubo un problema con tus CAPTCHA. Intenta de nuevo.";
    }

?>
