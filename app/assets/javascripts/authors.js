/*
$(function(){
	$("#search_for_author").bind('click', function() {
  		var request = $.ajax({
  			type: 'GET',
  			url: '/authors',
  			dataType: 'json',
  			data: {
  				search_param: $("#author_search").val()
  			}
  		});
  	
  		request.done(function(data) {
  			document.open();
			document.write('<%= render :partial => @author, author: author %>');
			document.close();
  		});
  });
});*/

