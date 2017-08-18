$(document).ready(function() {
    Custom.init();
});

var Custom = {
    init: function() {
        this.autosizeInput();
        this.bindEvents();
    },

    autosizeInput : function() {
    	$('#comment-box').autosize();
    	$('#law_project_description').autosize();
	},

	bindEvents : function() {


    	$('#btn-like').click(function() {
    		if ($('.like-icon').hasClass('liked')) {
    			$('.like-icon').removeClass('liked');
    			$('#btn-like').removeClass('like-strong');
    		} else {
    			if ($('.dislike-icon').hasClass("disliked")) {
    				$('.dislike-icon').removeClass('disliked');
    				$('#btn-dislike').removeClass('dislike-strong');
    			} 
    			$('.like-icon').addClass('liked');
    			$('#btn-like').addClass('like-strong');

    			var path = location.pathname.split('/');
    			var data = JSON.stringify({ law_project: path[path.length-1], like: true });

    			$.ajax({
				  type: 'POST',
				  url: '/like',
				  data: data,
  				contentType: 'application/json; charset=utf-8'
				});
    		}
    	});

		$('#btn-dislike').click(function() {
			if ($('.dislike-icon').hasClass("disliked")) {
    			$('.dislike-icon').removeClass('disliked');
    			$('#btn-dislike').removeClass('dislike-strong');
    		} else {
    			if ($('.like-icon').hasClass("liked")) {
    				$('.like-icon').removeClass('liked');
    				$('#btn-like').removeClass('like-strong');
    			} 
    			$('.dislike-icon').addClass('disliked');
    			$('#btn-dislike').addClass('dislike-strong');	
    		}

            var path = location.pathname.split('/');
            var data = JSON.stringify({ law_project: path[path.length-1], like: 0 });

            $.ajax({
                  type: 'POST',
                  url: '/like',
                  data: data,
                contentType: 'application/json; charset=utf-8'
                });
    	});    	
	}
}
