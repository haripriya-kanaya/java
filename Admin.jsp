<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Search</title>
    <style>
        /* Add your CSS styles here */
        #searchForm {
            display: flex;
            align-items: center; /* Align form elements vertically */
            margin-bottom: 10px; /* Adjust the margin to move the form downwards */
            font-size: 20px; /* Increase font size for form elements */
        }
        
         /* Style the search bar */
        #category {
            margin-right: 10px; /* Add some space between the search bar and the search button */
        }

 body {
  background-image: url("https://img.freepik.com/premium-photo/abstract-luxury-gradient-blue-background-smooth-dark-blue-with-black-vignette-studio-banner_1258-71715.jpg");
  background-size: cover;
  background-position: center center;
  height: 100vh;
  width: 100%;
  
}
        /* Style the buttons */
        #searchForm input[type="submit"],
        #searchForm input[type="button"] {
            margin-right: 5px; /* Add some space between the buttons */
            display: inline-block; /* Display buttons in the same line */
        }

        /* Style the button container to move buttons downwards */
        #buttonContainer {
            display: flex;
            align-items: center; /* Align buttons vertically with form elements */
            margin-top: 10px; /* Adjust the margin to move buttons downwards */
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h1>Admin Search</h1>
    <form id="searchForm">
        <label for="category" style="font-size: 18px;">Select Category:</label>
        <select name="category" id="category">
          
            <option value="Staff">Staff Booking details</option>
             <option value="Admin">Admin Booking details</option>
            <option value="Ambulance">Ambulance</option>
            <option value="Two Wheeler">Two Wheeler</option>
            <option value="Four Wheeler">Four Wheeler</option>
        </select>
        <input type="submit" value="Search" style="display: inline-block; padding: 10px 20px; background-color:  #808080; color: #fff; text-decoration: none; border-radius: 5px;">
       <input type="button" value="Reset" onclick="resetForm()" style="display: inline-block; padding: 10px 20px; background-color:  #808080; color: #fff; text-decoration: none; border-radius: 5px;">
          <a href="Navbar.jsp" style="display: inline-block; padding: 10px 20px; background-color:  #808080; color: #fff; text-decoration: none; border-radius: 5px;">Back</a>
    </form>

    <div id="results">
        <!-- The booked slots will be displayed here -->
    </div>

    <script>
        // Handle form submission using AJAX
        $(document).ready(function() {
            $('#searchForm').submit(function(e) {
                e.preventDefault(); // Prevent default form submission

                var selectedCategory = $('#category').val();

                // Send the selected category to the server using AJAX
                $.ajax({
                    type: 'POST',
                    url: 'Fetch.jsp', // Point to the new JSP file to handle the booked slots
                    data: { category: selectedCategory },
                    success: function(response) {
                        // Display the response (booked slots) in the results div
                        $('#results').html(response);
                    },
                    error: function() {
                        // Handle error, if any
                    }
                });
            });
        });

        // Function to reset the form
        function resetForm() {
            $('#category').val("Please select category"); // Reset the category dropdown
            $('#results').html(""); // Clear the results div
        }
    </script>
</body>
</html>
