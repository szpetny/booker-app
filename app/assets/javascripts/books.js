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
  
  $("#save_new_author").on('click', function() {
  		$("#save_new_author").attr('disabled', true)
  		 .delay(2000)
    	 .queue(function(next) {$(this).removeAttr('disabled'); next();});
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
  
  var orderCount = 0;
  $('#book_category_ids').multiselect({
  	buttonText: function(options, select) {
					if (options.length == 0) {
						return I18n.none_selected + ' <b class="caret"></b>';
					} else {
						if (options.length > this.numberDisplayed) {
							return I18n.selected + ': ' + options.length + ' <b class="caret"></b>';
						} else {
							var selected = '';
							options.each(function() {
								var label = ($(this).attr('label') !== undefined) ? $(this).attr('label') : $(this).html();
		
								selected += label + ', ';
							});
							return selected.substr(0, selected.length - 2) + ' <b class="caret"></b>';
						}
					}
				},
	
	buttonTitle: function(options, select) {
					if (options.length == 0) {
						return I18n.none_selected;
					} else {
						return I18n.selected + ': ' + options.length;
					}
				},
			
	numberDisplayed: 4,
	
	buttonClass: 'btn btn-default',
	
	buttonWidth: '100%',
	
	buttonContainer: '<div class="btn-group" style="width: 80%">'
   });

    $('#save_new_category').on('click', function() {
    	$("#save_new_category").attr('disabled', true)
  		 .delay(2000)
    	 .queue(function(next) {$(this).removeAttr('disabled'); next();});
  		var request = $.ajax({
  			type: 'POST',
  			url: '/book_categories',
  			dataType: 'json',
  			data: {
  				book_category: {
  					category_name: $("#category_name").val(),
  				}
  			}
  		});
  	
  		request.done(function(data) {
  			if (data.category_name != '') {
	  			$('#book_category_ids').append(
		  			$('<option></option>').val(data.id).html(data.category_name)
	  			);
  			}
  			$('#category_name').val('');
  			$('#add_category_modal').modal('hide');
  			$('#book_category_ids').multiselect('rebuild')
  		});
    });
});
    