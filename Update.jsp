<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update</title>
      <style>
        body {
            background-image: url("https://e1.pxfuel.com/desktop-wallpaper/400/157/desktop-wallpaper-abstract-light-background-list-mild.jpg");
            background-size: cover;
            background-position: center center;
            height: 100vh;
            width: 100%;
        }

        h1 {
            color: #007bff;
        }

        h2 {
            margin-top: 20px;
            color: #007bff;
        }

        ul {
            list-style-type: none;
            padding-left: 0;
        }

        li {
            margin-bottom: 5px;
        }

        p {
            margin: 5px 0;
        }

        .back-link {
            display: inline-block;
            padding: 10px 20px;
            background-color: #808080;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            float: right;
            margin-top: 20px; /* Add some space between the Back link and form */
        }

        #updateFormDiv {
            margin-top: 20px; /* Add some space between the heading and form */
        }

        #updateForm {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }

        /* Style the form elements */
        #updateForm input[type="date"] {
            margin-bottom: 10px; /* Add some space between the date inputs */
        }

        /* Style the buttons */
        #updateForm input[type="button"],
        .back-link {
            margin-right: 10px; /* Add some space between the buttons */
            background-color: #808080;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }

        #updateForm input[type="button"]:hover,
        .back-link:hover {
            background-color: #606060;
        }

        #updateForm input[type="button"]:focus,
        .back-link:focus {
            outline: none;
        }
        
        #buttonContainer {
            display: flex;
            align-items: center;
        }

        /* Style the validation message */
        #validationMessage {
            color: red;
            margin-top: 10px; /* Add some space between the validation message and buttons */
        }
         .back-link {
        display: inline-block;
        padding: 10px 20px;
        background-color: #808080;
        color: #fff;
        text-decoration: none;
        border-radius: 5px;
        float: right;
        margin-top: -1px; /* Move the Back button upwards */
    }
    </style>
</head>
<body>
    <div id="updateFormDiv">
        <h1>Slot deatils</h1>

        <form id="updateForm">
            <label for="startDate">Start Date:</label>
            <input type="date" id="startDate" name="startDate">
            <br>
            <label for="endDate">End Date:</label>
            <input type="date" id="endDate" name="endDate">
            <br>
           <div id="buttonContainer">
                <input type="button" value="Search" onclick="validateAndSubmit()">
                <a href="Navbar.jsp" class="back-link">Back</a>
            </div>
        </form>
    </div>

    <div id="slotsInfoDiv">
        <!-- The Slots Information section will be updated dynamically here -->
    </div>

    <div id="validationMessage" style="color: red;"></div>

    <script>
        function validateAndSubmit() {
            const startDateInput = document.getElementById('startDate');
            const endDateInput = document.getElementById('endDate');
            const startDate = new Date(startDateInput.value);
            const endDate = new Date(endDateInput.value);
            const validationMessageElement = document.getElementById('validationMessage');

            if (endDate < startDate) {
                validationMessageElement.textContent = 'End date cannot be before the start date.';
            } else {
                validationMessageElement.textContent = '';

                // Use AJAX to submit the form data without page refresh
                const xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            // Display the response from the server in the Slots Information section
                            const slotsInfoDiv = document.getElementById('slotsInfoDiv');
                            slotsInfoDiv.innerHTML = '' + xhr.responseText;
                        } else {
                            // Handle the error case
                            console.error('Error occurred during form submission.');
                        }
                    }
                };

                const formData = new FormData(document.getElementById('updateForm'));
                xhr.open('GET', 'Slotinfo.jsp?' + new URLSearchParams(formData).toString(), true);
                xhr.send();
            }
        }
    </script>
</body>
</html>
