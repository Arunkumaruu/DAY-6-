document.addEventListener('DOMContentLoaded', function() {
    function validateName() {
        var name = document.getElementById('name').value;
        if (name === '') {
            document.getElementById('name').style.borderColor = 'red';
            return false;
        } else {
            document.getElementById('name').style.borderColor = 'green';
            return true;
        }
    }

    function validateEmail() {
        var email = document.getElementById('email').value;
        var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(email)) {
            document.getElementById('email').style.borderColor = 'red';
            document.getElementById('emailFeedback').textContent = 'Invalid email address';
            return false;
        } else {
            document.getElementById('email').style.borderColor = 'green';
            document.getElementById('emailFeedback').textContent = '';
            return true;
        }
    }

    function validateSubject() {
        var subject = document.getElementById('subject').value;
        if (subject === '') {
            document.getElementById('subject').style.borderColor = 'red';
            return false;
        } else {
            document.getElementById('subject').style.borderColor = 'green';
            return true;
        }
    }

    function validateMessage() {
        var message = document.getElementById('message').value;
        if (message === '') {
            document.getElementById('message').style.borderColor = 'red';
            return false;
        } else {
            document.getElementById('message').style.borderColor = 'green';
            return true;
        }
    }

    document.getElementById('name').addEventListener('input', validateName);
    document.getElementById('email').addEventListener('input', validateEmail);
    document.getElementById('subject').addEventListener('input', validateSubject);
    document.getElementById('message').addEventListener('input', validateMessage);

    document.getElementById('contactForm').addEventListener('submit', function(event) {
        if (!validateName() || !validateEmail() || !validateSubject() || !validateMessage()) {
            event.preventDefault();
            alert('Please fill out the form correctly.');
        }
    });
});
