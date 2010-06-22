/* jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})
*/


jQuery.ajaxSetup({ 'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")} })

function _ajax_request(url, data, callback, type, method) {
    if (jQuery.isFunction(data)) {
        callback = data;
        data = {};
    }
    return jQuery.ajax({
        type: method,
        url: url,
        data: data,
        success: callback,
        dataType: type
        });
}

jQuery.extend({
    put: function(url, data, callback, type) {
        return _ajax_request(url, data, callback, type, 'PUT');
    },
    delete_: function(url, data, callback, type) {
        return _ajax_request(url, data, callback, type, 'DELETE');
    }
});

//jQuery.fn.submitWithAjax = function() {
//	  this.submit(function() {
//	    $.post(this.action, $(this).serialize(), null, "script");
//	    return false;
//	  })
//	  return this;
//	};

jQuery.fn.submitWithAjax = function() {
  this.unbind('submit', false);
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })

  return this;
};

//Send data via get if JS enabled
jQuery.fn.getWithAjax = function() {
  this.unbind('click', false);
  this.click(function() {
    $.get($(this).attr("href"), $(this).serialize(), null, "script");
    return false;
  })
  return this;
};





//Send data via Post if JS enabled
jQuery.fn.postWithAjax = function() {
  this.unbind('click', false);
  this.click(function() {
    $.post($(this).attr("href"), $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

/*
 * Post ajax submit form
 */

jQuery.fn.postsForm = function(route){
	this.ajaxForm({
		dataType: 'script',
		success: function(data){
			if (data == "") {
				window.location = route;
			}
		}
	});
};


jQuery.fn.putWithAjax = function() {
  this.unbind('click', false);
  this.click(function() {
    $.put($(this).attr("href"), $(this).serialize(), null, "script");
    return false;
  })
  return this;
};



jQuery.fn.deleteWithAjax = function() {
  this.removeAttr('onclick');
  this.unbind('click', false);
  this.click(function() {
    $.delete_($(this).attr("href"), $(this).serialize(), null, "script");
    return false;
  })
  return this;
};


//This will "ajaxify" the links
function ajaxLinks(){
    $('.ajaxForm').submitWithAjax();
    $('a.get').getWithAjax();
    $('a.post').postWithAjax();
    $('a.put').putWithAjax();
    $('a.delete').deleteWithAjax();
}




/*
 * Link with ajax the same url
 */

jQuery.fn.ajaxLink = function(){
  this.click(function(data) {
    $.get(this.href,{},function(data){
		  eval(data);
	  },"script");
    return false;
  })
  return this;
};




/*
 *  Input files style
 */
 
style_file_input = function(){
  $("input[type=file]")
	  .filter(function(index) {
      if ($(this).css("opacity") != "0") return true;
    }).filestyle({ 
        image: "/images/buttons/browse.png",
        imageheight : 23,
        imagewidth : 63,
        width : 115
      });
};


$(document).ready(function() {

// All non-GET requests will add the authenticity token
  // if not already present in the data packet
 $(document).ajaxSend(function(event, request, settings) {
       if (typeof(window.AUTH_TOKEN) == "undefined") return;
       // IE6 fix for http://dev.jquery.com/ticket/3155
       if (settings.type == 'GET' || settings.type == 'get') return;

       settings.data = settings.data || "";
       settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(window.AUTH_TOKEN);
     });

  ajaxLinks();
});









/*
 * Fullscreen online conference
 */

setFullScreen = function(){

	var windowHeight = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : document.body.clientHeight;
          
  $("#header").hide();
  $("#selector").hide();
  $("#menu").hide();
  $("#global-wrapper").hide();
  $("#footer").hide();
  $("#space").css({height:"100%",width:"100%"});
  $("#content").css({height:"100%",width:"100%"});
  $("#main").css({height:"100%",width:"100%"});
  $("#embed").css({height:windowHeight,width:"100%"});
	$("div").css({padding:"0",margin:"0"});
};

unsetFullScreen = function(){
  $("#header").show();
  $("#selector").show();
  $("#menu").show();
  $("#global-wrapper").show();
  $("#footer").show();
  $("#space").css({height:"",width:""});
  $("#content").css({height:"",width:""});
  $("#main").css({height:"",width:""});
  $("#embed").css({height:"",width:""});
	$("div").css({padding:"",margin:""});
};