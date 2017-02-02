$(window).ready(function($){
  $(window).scroll(function(){
    if($('#homepage').length > 0){
      //console.log("Home Page");
      var height = 450;
    } else if ($('#projectspage').length > 0){
      //console.log("Projects Page");
      var height = 150;
    } else if ($('#companypage').length > 0){
      //console.log("Company Page");
      var height = 150;
    }

    var scroll = $(window).scrollTop(); // scroll gets 0 from the top value

    if(scroll >= height){
      $("nav").addClass("navbar-shrink")
    } else if(scroll < height){
      $("nav").removeClass("navbar-shrink")
    }  
  });
});
