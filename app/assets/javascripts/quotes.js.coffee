$(document).ready ()->
  $("#location-toggle-button").toggleButtons
    width: 280
    label:
      enabled: "regional"
      disabled: "all-of-Switzerland"
    onChange: ($el, status, e) ->
      $("select#region").toggle(500);
      if status
        $("#project_region_id").val($("#region").val());
      else
        $("#project_region_id").val("");

  $("select#region").change ()->
    if $("#location-toggle-button input[type='checkbox']").is(":checked")
      $("#project_region_id").val($("#region").val());

  $('#quote_details_form').validate
    rules:
      "project[description]": {required: true}
      "project[start_date]": {required: true}
      "project[end_date]": {required: true}