// A $( document ).ready() block.
$( document ).ready(function() {

	// DropCap.js
	var dropcaps = document.querySelectorAll(".dropcap");
	window.Dropcap.layout(dropcaps, 3);

	// Responsive-Nav
	var nav = responsiveNav(".nav-collapse");

	// Contact Form AJAX
	$.ajax({
	    url: "//formspree.io/brimaidesigns@gmail.com", 
	    method: "POST",
	    data: {message: "hello!"},
	    dataType: "json"
	});

});


