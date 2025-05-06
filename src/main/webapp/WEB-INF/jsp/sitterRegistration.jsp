<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sitter Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #c1c1c1;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
            box-sizing: border-box;
        }

        .container {
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            padding: 15px;
            width: 100%;
            max-width: 700px;
            background-color: #d9d9d9;
        }

        .container> form
        {
            height: 100%;
            width: 100%;
        }
        /* Reduce space between label and input */
        .form-group {
            display: flex;
            /*align-items: center;*/
            justify-content: flex-start;
            gap: 10px; /* Reduced gap */
            margin-bottom: 12px;
        }

        /* Adjust label and input width */
        label {
            font-weight: bold;
            width: 20%; /* Reduce width */
            text-align: left;
            padding-right: 10px;
        }

        input, select {
            width: 75%; /* Increase input width */
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        /* Center the button */
        .button-container {
            display: flex;
            justify-content: center;
            margin-top: 15px;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
        }

        button:hover {
            background-color: #218838;
        }

        #map {
            height: 300px;
            width: 70%;
            margin: 10px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            background-color: #f8f9fa;
        }

      h2 {
            text-align: center;
            background-color: #ADD8E6;/* Green background */
            color: lightcoral; /* White text */
            width: 100%;
            height: 50px;
            margin: 5px auto; /* Center horizontally *
            border-radius: 8px; /* Rounded corners */
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                width: 90%;
            }
            .form-group {
                flex-direction: column;
                align-items: flex-start;
            }
            label, input, select {
                width: 100%;
                text-align: left;
            }
            #map {
                width: 100%;
            }
            .button-container {
                justify-content: center;
            }
            button {
                width: 100%;
            }
        }

    </style>
</head>
<body>

    <%@ include file="navbar.jsp" %>

    <div class="container">

    <form action="saveDetails" method="post" enctype="multipart/form-data">

        <div class="form-group">
        <h2 style=" text-align: center;">Sitter Registration</h2>
        </div>
        <div class="form-group">
            <label>Contact Name:</label>
            <input type="text" name="contactname" required>
        </div>
        <div class="form-group">
            <label>Email:</label>
            <input type="email" name="email" required>
        </div>
        <div class="form-group">
            <label>Password:</label>
            <input type="password" name="password" required>
        </div>
        <div class="form-group">
            <label>Company Name:</label>
            <input type="text" name="companyname" required>
        </div>
        <div class="form-group">
            <label>Address:</label>
            <input type="text" id="address" name="address" placeholder="Enter location">
        </div>

        <div class="form-group">
            <label>Location:</label>
            <div id="map"></div>
        </div>

        <div class="form-group">
            <label>Latitude:</label>
            <input type="text" id="latitude" name="lat" required>
        </div>
        <div class="form-group">
            <label>Longitude:</label>
            <input type="text" id="longitude" name="lng" required>
        </div>
        <div class="form-group">
            <label>Opening Time:</label>
            <input type="text" name="opentime" id="opentime" class="form-control" placeholder="Open">

        </div>
        <div class="form-group">
            <label>Closing Time:</label>
            <input type="text" name="closetime" id="closetime" class="form-control" placeholder="Close">
        </div>
        <div class="form-group">
            <label>Charges per Hour:</label>
            <input type="text" name="chargesperhour" step="0.01" required>
        </div>

        <div class="form-group">
            <label>Upload Logo:</label>
            <input type="file" id="logoFile" name="logopart" accept="image/*">
            <input type="hidden" name="logo" id="logoBase64">
        </div>

            <button type="submit" class="button" >Register</button>

    </form>
</div>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $("#logoFile").on("change", function() {
        var file = this.files[0]; // Get the selected file
        if (file) {
            var reader = new FileReader();
            reader.onload = function(e) {
                $("#logoBase64").val(e.target.result.split(",")[1]); // Store Base64 in hidden field
            };
            reader.readAsDataURL(file); // Convert to Base64
        }
    });
</script>

    <script>
        let map;
        let marker;
        let geocoder;

        function initMap() {
            const defaultPosition = { lat: 28.6507, lng: 77.2306 };

            map = new google.maps.Map(document.getElementById("map"), {
                zoom: 10,
                center: defaultPosition,
            });

            geocoder = new google.maps.Geocoder();

            marker = new google.maps.Marker({
                position: defaultPosition,
                map: map,
                label: "A",
                title: "Chandni Chowk",
                draggable: true,
            });

            // Drag marker to get new address
            marker.addListener("dragend", () => {
                const position = marker.getPosition();
                geocodeLatLng(position);
            });

            // Autocomplete for address input
            const input = document.getElementById("address");
            const autocomplete = new google.maps.places.Autocomplete(input);
            autocomplete.bindTo("bounds", map);

            autocomplete.addListener("place_changed", () => {
                const place = autocomplete.getPlace();
                if (!place.geometry) {
                    alert("No details available for this location.");
                    return;
                }

                marker.setPosition(place.geometry.location);
                map.setCenter(place.geometry.location);
                map.setZoom(14);

                updateCoordinates(place.geometry.location);
            });

            // Handle form submission
            document.getElementById("locationForm").addEventListener("submit", (event) => {
                event.preventDefault();
                const query = input.value;
                if (!query) return;

                geocoder.geocode({ address: query }, (results, status) => {
                    if (status === "OK") {
                        const location = results[0].geometry.location;
                        marker.setPosition(location);
                        map.setCenter(location);
                        map.setZoom(14);
                        marker.setTitle(results[0].formatted_address); // Correct title

                        updateCoordinates(location);
                        document.getElementById("locationForm").submit();
                    } else {
                        alert("Location not found: " + status);
                    }
                });
            });
        }
        // Reverse Geocoding for dragged marker
        function geocodeLatLng(position) {
            geocoder.geocode({ location: position }, (results, status) => {
                if (status === "OK" && results[0]) {
                    document.getElementById("address").value = results[0].formatted_address; // Fixed input field
                    updateCoordinates(position);
                } else {
                    document.getElementById("address").value = "Location not found"; // Fixed input field
                }
            });
        }

        // Update Lat/Lng values
        function updateCoordinates(location) {
            document.getElementById("latitude").value = location.lat();
            document.getElementById("longitude").value = location.lng();
        }
    </script>

<script async defer src="https://maps.googleapis.com/maps/api/js?key=EnterKey&libraries=places&callback=initMap"></script>
</body>
</html>
