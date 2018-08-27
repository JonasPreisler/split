// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require Chart.bundle
//= require chartkick
//= require jquery
//= require jquery_ujs
//= require jquery-ui/effect-highlight
//= require activestorage
//= require turbolinks
//= require bootstrap-sprockets
//= require jquery.easy-autocomplete
//= require chosen-jquery
//= require cocoon
//= require_tree .


// data attributes (my preference because it's explicit and flexible)
$('[data-target=my-form]')

// using jQuery's closest() method; "this" will refer to the radio button you clicked
$(this).closest(form)

// an ID or class
$("#my-form")
$(".my-form")



$(document).on('turbolinks:load', function(){
	$(".chosen-select").chosen();
	allow_single_deselect: true
    no_results_text: 'No results matched';
});

// language dropdown //
function myFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
  window.onclick = function(event) {
    if (!event.target.matches('.dropbtn')) {

      var dropdowns = document.getElementsByClassName("dropdown-content");
      var i;
      for (i = 0; i < dropdowns.length; i++) {
        var openDropdown = dropdowns[i];
        if (openDropdown.classList.contains('show')) {
          openDropdown.classList.remove('show');
        }
      }
    }
  }
}
// end of  language dropdown //
