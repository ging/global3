// initialise plugins


var outerLayout, middleLayout; 

jQuery(function(){
	jQuery('ul.sf-menu').superfish();
});	


$(document).ready(function () { 

	outerLayout = $('body').layout({ 
		center__paneSelector:	".outer-center" 
	,	east__paneSelector:		".outer-east" 
	,	east__size:				136 
	,	spacing_open:			4 // ALL panes
	,	spacing_closed:			8 // ALL panes
	,	north__spacing_open:	0
	,	south__spacing_open:	0
	 
	}); 

	middleLayout = $('div.outer-center').layout({ 
		east__paneSelector:		".middle-east" 
	,	east__size:				256 
	,	spacing_open:			4  // ALL panes
	,	spacing_closed:			8 // ALL panes
	,	north__spacing_open:	0
	,	south__spacing_open:	0
	
	}); 


}); 
