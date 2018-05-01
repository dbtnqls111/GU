$(function(){
	$(document).on("mouseenter", ".itemBoxes > li", function(){
		$(this).css({ "border":"2px solid black", "cursor":"pointer" });
	}).on("mouseleave", ".itemBoxes > li", function(){
		$(this).css("border", "1px solid #999999");
	});
});