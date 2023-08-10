<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Parking Billing</title>
</head>
<body>
    <h1>Parking Billing System</h1>
    
    <h2>Empty Slots: <span id="emptySlots"></span></h2>
    <h2>Full Slots: <span id="fullSlots"></span></h2>
    
    <h2>Charges (Hourly):</h2>
    <p>Ambulance: <span id="hourlyAmbulanceCharge"></span></p>
    <p>Two Wheeler: <span id="hourlyTwoWheelerCharge"></span></p>
    <p>Four Wheeler: <span id="hourlyFourWheelerCharge"></span></p>
    
    <form id="billingForm">
        <h2>Total Charges for Vehicles Left:</h2>
        <label for="vehiclesLeft">Vehicles Left:</label>
        <input type="number" id="vehiclesLeft" name="vehiclesLeft">
        <br>
        <label for="inTime">In Time:</label>
        <input type="time" id="inTime" name="inTime">
        <br>
        <label for="outTime">Out Time:</label>
        <input type="time" id="outTime" name="outTime">
        <br>
        <label for="vehicleNumber">Vehicle Number:</label>
        <input type="text" id="vehicleNumber" name="vehicleNumber">
        <br>
        <input type="button" value="Calculate Billing" onclick="calculateBilling()">
    </form>

    <div id="billingResult"></div>

    <script>
        // JavaScript functions to handle calculations
        function calculateBilling() {
            // Get input values
            const hourlyAmbulanceCharge = parseFloat(document.getElementById('hourlyAmbulanceCharge').textContent);
            const hourlyTwoWheelerCharge = parseFloat(document.getElementById('hourlyTwoWheelerCharge').textContent);
            const hourlyFourWheelerCharge = parseFloat(document.getElementById('hourlyFourWheelerCharge').textContent);
            const vehiclesLeft = parseInt(document.getElementById('vehiclesLeft').value);
            const inTime = document.getElementById('inTime').value;
            const outTime = document.getElementById('outTime').value;
            const vehicleNumber = document.getElementById('vehicleNumber').value;

            // Perform billing calculations here
            // ...

            // Display the result
            const billingResultElement = document.getElementById('billingResult');
            billingResultElement.innerHTML = "Billing Result: ..."; // Replace with actual result
        }
    </script>
</body>
</html>
