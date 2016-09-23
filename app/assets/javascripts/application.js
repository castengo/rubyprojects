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

var app = function() {

	$(document).ajaxStart(function() {
		$(".spinner").show();
	});

	$(document).ajaxStop(function() {
		$(".spinner").hide();
		shimmeryShades();
	});

	shimmeryShades();

	function shimmeryShades() {
		$(".shade-square").each(function() {
			if ($(this).data('finish') != "Matte") {
				var h = $(this).data('h');
				var s = $(this).data('s');
				var l = $(this).data('l');
				var canvas = $(this).find("canvas");
				var ctx = canvas[0].getContext("2d");
				var colorArray = makeThreeColors(h,s,l);
				for (var i = 0; i < 300; i++) {
					for (var j = 0; j < 200; j++) {
						ctx.fillStyle = colorArray[Math.floor(Math.random()*colorArray.length)];
						ctx.fillRect(i,j,1,1);
					};
				};
			};
		});
	};

	function makeThreeColors(h, s, l) {
		var low = 25;
		var high = 75;
		if (l <= 25) {
			low = 0;
			high= l + 25;
		} else if (l >=75) {
			high = 100;
			low = l - 25;
		} else {
			low = l - 25;
			high = l + 25;
		}
		// Two times original color for better view
		return [makeHSLString(h,s,low), makeHSLString(h,s,l), makeHSLString(h,s,l),makeHSLString(h,s,l), makeHSLString(h,s,high)]
	};

	function makeHSLString(h, s, l) {
		var string = "hsl(";
		return string.concat(h, ",", s, "%,", l, "%)")
	};
};

$(document).ready(app);
