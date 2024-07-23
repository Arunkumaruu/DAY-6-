$(document).ready(function() {
    $('#sendButton').on('click', async function() {
        const userInput = $('#userInput').val().trim();
        if (userInput === '') return; // Do nothing if input is empty

        // Append user message
        const chatBox = $('#chatBox');
        const userMessage = $('<div>').addClass('message user-message').text(userInput);
        chatBox.append(userMessage);

        // Clear input field
        $('#userInput').val('');

        try {
            // Fetch response from the Stack Exchange API
            const response = await fetch(`https://api.stackexchange.com/2.3/search?order=desc&sort=activity&intitle=${encodeURIComponent(userInput)}&site=stackoverflow`);
            
            if (!response.ok) {
                throw new Error('API error or no results found');
            }

            const data = await response.json();
            
            if (data.items.length === 0) {
                throw new Error('No questions found');
            }

            // Get up to 3 questions
            const questions = data.items.slice(0, 3);

            // Display each question
            questions.forEach(question => {
                const botMessage = $('<div>').addClass('message bot-message').html(`
                    <strong><a href="${question.link}" target="_blank">${question.title}</a></strong><br>
                    ${question.is_answered ? 'Answered' : 'Unanswered'}<br>
                    Score: ${question.score}
                `);
                chatBox.append(botMessage);
            });
        } catch (error) {
            console.error('Error fetching response:', error);
            const botMessage = $('<div>').addClass('message bot-message').text('Sorry, I couldn’t fetch a response at the moment.');
            chatBox.append(botMessage);
        } finally {
            chatBox.scrollTop(chatBox.prop("scrollHeight")); // Scroll to bottom
        }
    });
});
