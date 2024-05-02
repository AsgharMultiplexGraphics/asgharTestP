 // Function to toggle navbar visibility
 document.getElementById('navbar-toggler').addEventListener('click', function() {
    const toggleButton = document.getElementById('navbar');
    if (toggleButton.style.display === 'none') {
        toggleButton.style.display = 'block';
        document.cookie = "open_menu=false"; // Set cookie to true on open
    } else {
        toggleButton.style.display = 'none';
        document.cookie = "open_menu=false"; // Set cookie to false on close
    }
    });


    // Function to toggle navbar visibility
    document.getElementById('customer-toggler').addEventListener('click', function() {
    const toggleButton = document.getElementById('customer');
    if (toggleButton.style.display === 'none') {
        toggleButton.style.display = 'block';
        document.cookie = "open_menu=true"; // Set cookie to true on open
    } else {
        toggleButton.style.display = 'none';
        document.cookie = "open_menu=false"; // Set cookie to false on close
    }
    });
      