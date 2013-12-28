$(function(){
	$("#search_for_author").bind('click', function() {
  		var request = $.ajax({
  			type: 'POST',
  			url: '/authors',
  			dataType: 'json',
  			data: {
  				search_param: $("#author_search").val()
  			}
  		});
  	
  		request.done(function(data) {
  			'<%= render @author, author: author %>'
  		});
  });
});
