$(document).ready(function() {
  // Hide step 2 initially
  $('#step2').hide();

  // Event listener for the "Next" button in step 1
  $('#toStep2').click(function() {
    // Show step 2 and hide step 1
    $('#step1').hide();
    $('#step2').show();

    // Populate coaches based on selected program
    var CoachingProgramId = $('#program').val();
    $.ajax({
      url: '/get_coaches',
      type: 'GET',
      data: { coaching_program_id: CoachingProgramId }, // Changed to coaching_program_id
      dataType: 'json',
      success: function(data) {
        $('#coach').empty(); // Clear previous options
        $.each(data, function(index, coach) {
          $('#coach').append($('<option>', {
            value: coach.id,
            text: coach.name
          }));
        });
      },
      error: function(xhr, status, error) {
        console.error('Error fetching coaches:', error);
      }
    });
  });

  // Event listener for form submission
  $('#registrationForm').submit(function(event) {
    // Prevent default form submission
    event.preventDefault();

    // Gather form data
    var formData = {
      coaching_program_id: $('#program').val(), // Changed to coaching_program_id
      phone: $('#phone').val(),
      coach_id: $('#coach').val()
    };

    // Submit form data via AJAX
    $.ajax({
      url: '/employee_registrations',
      type: 'POST',
      data: formData,
      dataType: 'json',
      success: function(response) {
        alert('Registration successful!');
        // Optionally, redirect user to a new page after successful registration
        window.location.href = '/success_page';
      },
      error: function(xhr, status, error) {
        console.error('Error submitting registration:', error);
      }
    });
  });
});
