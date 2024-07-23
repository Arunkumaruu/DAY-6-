document.addEventListener('DOMContentLoaded', function() {
    const ourStorySection = document.getElementById('ourStorySection');

    ourStorySection.addEventListener('mouseover', function() {
        ourStorySection.style.color = 'green';

        ourStorySection.style.backgroundImage = 'linear-gradient(90deg, #ff7e5f, #feb47b)';
    });

    ourStorySection.addEventListener('mouseout', function() {
        ourStorySection.style.color = '';
        ourStorySection.style.backgroundImage = ''; 
    });
});
