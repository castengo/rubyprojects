// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets


( function() {

	// this = window

	$(document).ajaxStart(function() {
		$(".spinner").show();
	});

	$(document).ajaxStop(function() {
		shimmeryShades();
		$(".spinner").hide();
	});

	shimmeryShades();
	instgrm.Embeds.process();

	function shimmeryShades() {
		$(".look-shades .shade-square").each(shimmer);
		$(".product-shades .shade-square").each(shimmer);
		$("#shades-list span:last-child .shade-square").each(shimmer);
		$("#shades-list span:last-child .product-shade").each(shimmer);
		$("#shades-list").removeClass("hidden");
		$(".spinner").hide();
	};


	function shimmer() {
		if ($(this).data('finish') != "Matte") {
			var h = $(this).data('h');
			var s = $(this).data('s');
			var l = $(this).data('l');
			var canvas = $(this).find("canvas");
			var ctx = canvas[0].getContext("2d");
			var colorArray = makeThreeColors(h,s,l);
			for (var y = 0; y < 300; y++) {
				for (var x = 0; x < 300; x++) {
					ctx.fillStyle = colorArray[Math.floor(Math.random()*colorArray.length)];
					ctx.fillRect(x,y,1,1);
				};
			};
		};
	};

	function makeThreeColors(h, s, l) {
		var low = 15;
		var high = 85;
		if (l <= 15) {
			low = 5;
			high = l + 15;
		} else if (l >= 85) {
			high = 95;
			low = l - 15;
		} else {
			low = l - 15;
			high = l + 15;
		}
		// Four times original color for better view
		return [makeHSLString(h,s,low), makeHSLString(h,s,l), makeHSLString(h,s,l), makeHSLString(h,s,l), makeHSLString(h,s,l), makeHSLString(h,s,high)]
	};

	function makeHSLString(h, s, l) {
		var string = "hsl(";
		return string.concat(h, ",", s, "%,", l, "%)")
	};
})();
