$(function() {
  $('#books').dataTable({
        "sDom": "<'row'<'span'l><'span'f>r>t<'row'<'span'i><'span'p>>",
        "sPaginationType": "bootstrap",
        "oLanguage": {"sUrl": "dataTables/polish.txt"},
        "aoColumnDefs": [
			      {"sWidth": "25%", "aTargets": [0]},
			      {"sWidth": "20%", "aTargets": [1,2]},
			      {"sWidth": "5%", "aTargets": [3,4]},
			      {"sWidth": "10%", "aTargets": [5]},
			      {"sWidth": "5%", "aTargets": [6]},
			    ]
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
    