$(document).ready(function() {
    function validateName() {
        var name = $('#name').val();
        if (name === '') {
            $('#name').css('border-color', 'red');
            return false;
        } else {
            $('#name').css('border-color', 'green');
            return true;
        }
    }

    function validateEmail() {
        var email = $('#email').val();
        var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(email)) {
            $('#email').css('border-color', 'red');
            $('#emailFeedback').text('Invalid email address');
            return false;
        } else {
            $('#email').css('border-color', 'green');
            $('#emailFeedback').text('');
            return true;
        }
    }

    function validateSubject() {
        var subject = $('#subject').val();
        if (subject === '') {
            $('#subject').css('border-color', 'red');
            return false;
        } else {
            $('#subject').css('border-color', 'green');
            return true;
        }
    }

    function validateMessage() {
        var message = $('#message').val();
        if (message === '') {
            $('#message').css('border-color', 'red');
            return false;
        } else {
            $('#message').css('border-color', 'green');
            return true;
        }
    }

    $('#name').on('input', validateName);
    $('#email').on('input', validateEmail);
    $('#subject').on('input', validateSubject);
    $('#message').on('input', validateMessage);

    $('#contactForm').on('submit', function(event) {
        if (!validateName() || !validateEmail() || !validateSubject() || !validateMessage()) {
            event.preventDefault();
            alert('Please fill out the form correctly.');
        }
    });
});
