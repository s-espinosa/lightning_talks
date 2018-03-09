$(document).ready(function() {
  $('#cohort_name').change(function(){
    var value = $(this).val();
    $("ul.talks").find("li").hide()
    $.each($("ul.talks").find("li"),function(){
      if($(this).data('cohort-name') === value)
        $(this).show();
    });
  });
})

