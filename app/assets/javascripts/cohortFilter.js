$(document).ready(function() {
  assignUl();
  assignTable();
})

function assignUl() {
  $('#cohort_name').change(function(){
    var value = $(this).val();
    $("ul.talks").find("li").hide()
    $.each($("ul.talks").find("li"),function(){
      if($(this).data('cohort-name') === value || value === "All Talks")
        $(this).show();
    });
  });
}

function assignTable() {
  $('#cohort_name').change(function(){
    var value = $(this).val();
    $("tbody.talks").find("tr").hide()
    $.each($("tbody.talks").find("tr"),function(){
      if($(this).data('cohort-name') === value || value === "All Talks")
        $(this).show();
    });
  });
}


