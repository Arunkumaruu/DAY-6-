$(document).ready(function() {
    const $passwordInput = $('#password');
    const $passwordStrengthIndicator = $('#password-strength');
    const $showPasswordCheckbox = $('#showPassword');

    // Toggle password visibility
    $showPasswordCheckbox.on('change', function() {
        if ($(this).is(':checked')) {
            $passwordInput.attr('type', 'text');
        } else {
            $passwordInput.attr('type', 'password');
        }
    });

    // Password strength check
    $passwordInput.on('input', function() {
        const password = $(this).val();
        const strength = checkPasswordStrength(password);
        $passwordStrengthIndicator.text(strength.message).css('color', strength.color);
    });

    function checkPasswordStrength(password) {
        let strength = {
            message: 'Weak',
            color: '#ff0000' // Red
        };

        if (password.length >= 8) {
            strength.message = 'Medium';
            strength.color = 'blue'; // Blue
        }

        if (password.length >= 12 && /[A-Z]/.test(password) && /[0-9]/.test(password) && /[!@#$%^&*]/.test(password)) {
            strength.message = 'Strong';
            strength.color = '#00ff00'; // Green
        }

        return strength;
    }
});
function validateUserName() {
    const name = $('#username').val();
    const namePattern = /^[a-zA-Z\s]+$/ ;
    if (!namePattern.test(name)) {
        $('#usernameFeedback').text('Please enter a valid name.').css('color', 'red');
    } else {
        $('#usernameFeedback').text('');
    }
}    $('#username').on('input', validateUserName);
