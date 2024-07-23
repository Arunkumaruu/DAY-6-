document.addEventListener('DOMContentLoaded', function() {
    const sendButton = document.getElementById('sendButton');
    const userInput = document.getElementById('userInput');
    const chatBox = document.getElementById('chatBox');

    sendButton.addEventListener('click', async function() {
        const userInputValue = userInput.value.trim();
        if (userInputValue === '') return; // Do nothing if input is empty

        // Append user message
        const userMessage = document.createElement('div');
        userMessage.className = 'message user-message';
        userMessage.textContent = userInputValue;
        chatBox.appendChild(userMessage);

        // Clear input field
        userInput.value = '';

        try {
            // Fetch response from the Stack Exchange API
            const response = await fetch(`https://api.stackexchange.com/2.3/search?order=desc&sort=activity&intitle=${encodeURIComponent(userInputValue)}&site=stackoverflow`);
            
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
                const botMessage = document.createElement('div');
                botMessage.className = 'message bot-message';
                botMessage.innerHTML = `
                    <strong><a href="${question.link}" target="_blank">${question.title}</a></strong><br>
                    ${question.is_answered ? 'Answered' : 'Unanswered'}<br>
                    Score: ${question.score}
                `;
                chatBox.appendChild(botMessage);
            });
        } catch (error) {
            console.error('Error fetching response:', error);
            const botMessage = document.createElement('div');
            botMessage.className = 'message bot-message';
            botMessage.textContent = 'Sorry, I couldn’t fetch a response at the moment.';
            chatBox.appendChild(botMessage);
        } finally {
            chatBox.scrollTop = chatBox.scrollHeight; // Scroll to bottom
        }
    });
});
