$(function() {
  $('#books').dataTable({
        "sDom": "<'row'<'span'l><'span'f>r>t<'row'<'span'i><'span'p>>",
        "sPaginationType": "bootstrap",
        "oLanguage": {"sUrl": "dataTables/polish.txt"}
  });
});
    