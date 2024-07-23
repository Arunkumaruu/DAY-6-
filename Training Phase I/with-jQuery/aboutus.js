$(document).ready(function() {
    const ourStorySection = $('#ourStorySection');
    
    ourStorySection.on('mouseover', function() {
        ourStorySection.css('color', '#ff7e5f');
        ourStorySection.css('backgroundColor', '#fccec2'); // Change to your desired color
    });

    ourStorySection.on('mouseout', function() {
        ourStorySection.css('color', '');
        ourStorySection.css('backgroundColor', ''); // Resets to the original color
    });
});
