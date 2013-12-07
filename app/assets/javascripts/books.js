$(function() {
  $('#books').dataTable({
        "sDom": "<'row'<'span'l><'span'f>r>t<'row'<'span'i><'span'p>>",
        "sPaginationType": "bootstrap",
        "oLanguage": {"sUrl": "dataTables/polish.txt"}
  });
  
  $("#save_new_author").bind('click', function() {
  		var request = $.ajax({
  			type: 'POST',
  			url: '/authors',
  			dataType: 'json',
  			data: {
  				author: {
  					name: $("#author_name").val(),
  					surname: $("#author_surname").val()
  				}
  			}
  		});
  	
  		request.done(function(data) {
  			//var select = 
  			$('#book_author_id').html('');
  			$.each(data, function(k,v) {
  				$('#book_author_id').append(
  					 $('<option></option>').val('').html('')
  				);
  				$('#book_author_id').append(
  					 $('<option></option>').val(v.id).html(v.surname + " " + v.name)
  				);
  			});
  			$('#author_name').val('');
  			$('#author_surname').val('');
  			$('#addAuthorModal').modal('hide');
  		});
  		
  });
});
    