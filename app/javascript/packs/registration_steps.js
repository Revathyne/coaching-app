// app/javascript/packs/registration_steps.js

$(document).on('turbolinks:load', function() {
  $('#next-step-1').on('click', function() {
    $('#step-1').hide();
    $('#step-2').show();
  });

  $('#previous-step-2').on('click', function() {
    $('#step-2').hide();
    $('#step-1').show();
  });
});
