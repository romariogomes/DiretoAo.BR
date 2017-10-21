$(document).ready(function() {
    Custom.init();
});

var Custom = {
    init: function() {
        this.autosizeInput();
        this.bindEvents();
    },

    autosizeInput : function() {
    	// $('#comment-box').autosize();
    	// $('#law_project_description').autosize();
        $.each($('textarea'), function( index, value ) {
            $(this).autosize();
        });
	},

	bindEvents : function() {


    	$('#btn-like').click(function() {
    		
            var path = location.pathname.split('/');

            if ($('.like-icon').hasClass('liked')) {

    			$('.like-icon').removeClass('liked');
    			$('#btn-like').removeClass('like-strong');
                $('.badge-like')[0].innerHTML = parseInt($('.badge-like')[0].innerHTML)-1;

                var data = JSON.stringify({ law_project: path[path.length-1], to_delete: true});

    		} else {

    			if ($('.dislike-icon').hasClass("disliked")) {

    				$('.dislike-icon').removeClass('disliked');
    				$('#btn-dislike').removeClass('dislike-strong');
                    $('.badge-dislike')[0].innerHTML = parseInt($('.badge-dislike')[0].innerHTML)-1;

    			} 

    			$('.like-icon').addClass('liked');
    			$('#btn-like').addClass('like-strong');
                $('.badge-like')[0].innerHTML = parseInt($('.badge-like')[0].innerHTML)+1;
    			
    			var data = JSON.stringify({ law_project: path[path.length-1], like: true });
    		}

            $.ajax({
                type: 'POST',
                url: '/like',
                data: data,
                contentType: 'application/json; charset=utf-8'
            });
    	});

		$('#btn-dislike').click(function() {
			
            var path = location.pathname.split('/');

            if ($('.dislike-icon').hasClass("disliked")) {

    			$('.dislike-icon').removeClass('disliked');
    			$('#btn-dislike').removeClass('dislike-strong');
                $('.badge-dislike')[0].innerHTML = parseInt($('.badge-dislike')[0].innerHTML)-1;

                var data = JSON.stringify({ law_project: path[path.length-1], to_delete: true});
    		} else {

    			if ($('.like-icon').hasClass("liked")) {

    				$('.like-icon').removeClass('liked');
    				$('#btn-like').removeClass('like-strong');
                    $('.badge-like')[0].innerHTML = parseInt($('.badge-like')[0].innerHTML)-1;

    			} 

    			$('.dislike-icon').addClass('disliked');
    			$('#btn-dislike').addClass('dislike-strong');
                $('.badge-dislike')[0].innerHTML = parseInt($('.badge-dislike')[0].innerHTML)+1;

                var data = JSON.stringify({ law_project: path[path.length-1], like: 0 });
    		}

            $.ajax({
                type: 'POST',
                url: '/like',
                data: data,
                contentType: 'application/json; charset=utf-8'
            });
    	});

        $('.btnEditComment').click(function() { 

            const btnEdit = $(this);
            const divPai = btnEdit.closest(".comment-item");
            const id = divPai.data("id");
            
            btnEdit.hide();
            $('textarea#'+id).attr('disabled', false);
            $('a#'+id+'.btnSaveComment').show();
        });

        $('.btnSaveComment').click(function() {
            
            var path = location.pathname.split('/');

            const btnEdit = $(this);
            const divPai = btnEdit.closest(".comment-item");
            const id = divPai.data("id");

            commentId = id;
            newComment = $('textarea#'+id).val();

            $('textarea#'+id).attr('disabled', true);
            $('a#'+id+'.btnSaveComment').hide();
            btnEdit.show();

            var data = JSON.stringify({ comment_id: commentId, comment: newComment, law_project: path[path.length-1] });

            $.ajax({
                type: 'POST',
                url: '/update-comment',
                data: data,
                contentType: 'application/json; charset=utf-8'
            });
        });

        $('#by-acceptances').click(function() { 

            var that = $('#by-qtd-projetos');

            if (that.hasClass('active')) {
                that.removeClass('active')    
            }

            if (!$(this).hasClass('active')) {
                $(this).addClass('active')    
            }
        });

        $('#by-qtd-projetos').click(function() { 

            var that = $('#by-acceptances');

            if (that.hasClass('active')) {
                that.removeClass('active')    
            }

            if (!$(this).hasClass('active')) {
                $(this).addClass('active')    
            }
        });
	}
}
