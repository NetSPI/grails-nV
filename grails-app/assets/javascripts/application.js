// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better 
// to create separate JavaScript files as needed.
//

//= require ie
//= require bootstrap
//= require jquery-ui-extras.
//= require jquery.mockjax
//= require jquery.cookie
//= require jquery.base64
//= require pixel-admin
//= require prism

function resetForm() {
    var values = $.parseJSON($.base64.decode($.cookie("user")));
    $("#firstname").val(values['firstname']);
    $("#lastname").val(values['lastname']);
    $("#description").val(values['description']);
    $("#email").val(values['email']);
}


$(document).ready(function() {
	if ( $("#search-form").length ) {
		// base64 the search query for security!
	    $('#search-form').on('submit', function(e) {
	        e.preventDefault();  //prevent form from submitting
	        window.location.href = $("#search-form").attr("action") + "?q=" + window.btoa($("#q").val());
	    });
	}
});