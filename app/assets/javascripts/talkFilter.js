$(document).ready(function() {
  assignUl();
  assignTable();
})

function assignUl() {
  $('#cohort_name').change(showLi);
  $('#week_name').change(showLi);
}

function assignTable() {
  $('#cohort_name').change(showRow);
  $('#week_name').change(showRow);
}

function showLi() {
  var cohort = $('#cohort_name').val();
  var week   = $('#week_name').val();

  $("ul.talks").find("li").hide()
  $.each($("ul.talks").find("li"),function(){
    if(($(this).data('cohort-name') === cohort || cohort === "All Talks") && ($(this).data('week') === week || week === "All Weeks"))
      $(this).show();
  });
}

function showRow() {
  var cohort = $('#cohort_name').val();
  var week   = $('#week_name').val();

  $("tbody.talks").find("tr").hide()
  $.each($("tbody.talks").find("tr"),function(){
    if(($(this).data('cohort-name') === cohort || cohort === "All Talks") && ($(this).data('week') === week || week === "All Weeks"))
      $(this).show();
  });

}
