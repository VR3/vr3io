/*!
 * Start Bootstrap - Agnecy Bootstrap Theme (http://startbootstrap.com)
 * Code licensed under the Apache License v2.0.
 * For details, see http://www.apache.org/licenses/LICENSE-2.0.
 */

//'%c Oh my heavens! ', 'background: #222; color: #bada55'
console.log('%c VR3.io ', 'color: #FFFFFF; background: #DD2128; font-size: 175%;');
console.log('%c  Evolution through technology ', 'color: #FFFFFF; background: #DD2128; font-size: 100%;');
console.log('%c Version 2.1.0 ', 'background: #F5DF4C; color: #0F1E07;');
console.log('%c Contact us at: ' + '%c info@vr3.io', 'color:  #1D0909; ','color: #266CAF; font-style: oblique; font-size: 115%;');


// jQuery for page scrolling feature - requires jQuery Easing plugin
$(function() {
    $('a.page-scroll').bind('click', function(event) {
        var $anchor = $(this);
        $('html, body').stop().animate({
            scrollTop: $($anchor.attr('href')).offset().top
        }, 1500, 'easeInOutExpo');
        event.preventDefault();
    });
});

// Highlight the top nav as scrolling occurs
$('body').scrollspy({
    target: '.navbar-fixed-top'
})

// Closes the Responsive Menu on Menu Item Click
$('.navbar-collapse ul li a').click(function() {
    $('.navbar-toggle:visible').click();
});

$(document).ready(function(){
  $('.clients').slick({
    slidesToShow: 5,
	  slidesToScroll: 1,
	  autoplay: true,
	  draggable: true,
	  pauseOnHover: true,
	  prevArrow: false,
	  nextArrow: false,
	  autoplaySpeed: 3000,
	  responsive: [
    {
      breakpoint: 1024,
      settings: {
        slidesToShow: 3,
        slidesToScroll: 3,
        infinite: true,
      }
    },
    {
      breakpoint: 600,
      settings: {
        slidesToShow: 2,
        slidesToScroll: 2
      }
    },
    {
      breakpoint: 480,
      settings: {
        slidesToShow: 1,
        slidesToScroll: 1
      }
    }
    // You can unslick at a given breakpoint now by adding:
    // settings: "unslick"
    // instead of a settings object
  ]
  });
});