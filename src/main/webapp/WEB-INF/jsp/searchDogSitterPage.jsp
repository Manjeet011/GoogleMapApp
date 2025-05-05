<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.misha.model.SitterRegistration" %>
<%@ page import="java.util.List" %>
<%@ page import="org.springframework.beans.factory.annotation.Autowired" %>
<%@ page import="com.misha.repository.SitterRepository" %>
<%@ page import="com.misha.service.RegistrationService" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Google Map Search</title>
    <style>
        * { box-sizing: border-box; font-family: 'Arial', sans-serif; }
        body {
            background-color: #f4f7fc;
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        h3 { color: #222; margin-bottom: 20px; font-size: 26px; text-align: center; }
        #search-container {
            width: 100%;
            max-width: 1500px;
            display: flex;
            justify-content: center;
            margin-bottom: 25px;
        }
        input, button {
            padding: 12px;
            border-radius: 6px;
            font-size: 16px;
        }
        input {
            flex: 1;
            border: 1px solid #ccc;
            outline: none;
        }
        button {
            background: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            margin-left: 10px;
            transition: 0.3s;
        }
        button:hover { background: #0056b3; }
        #main-container {
            display: flex;
            width: 90%;
            max-width: 1200px;
            height: 500px;
            gap: 15px;
        }
        #result-list {
            width: 30%;
            overflow-y: auto;
            background: white;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .sitter-card {
            display: flex;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .sitter-image {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            margin-right: 12px;
        }
        .sitter-details { flex-grow: 1; }
        .sitter-name { font-weight: bold; }
        .sitter-address { color: #666; font-size: 14px; }
        #map {
            flex: 1;
            height: 100%;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<script>
    const userlang=null;
    const userLong=null;
</script>

<%

    List<SitterRegistration> sitters = (List<SitterRegistration>) request.getAttribute("sitters");


%>
<div id="search-container">
    <form id="locationForm" action="searchOperation" method="GET">
        <input type="text" id="search" name="location" value="<%= request.getParameter("location") != null ? request.getParameter("location") : "" %>" placeholder="Enter location" required>
        <input type="hidden" id="latitude" name="latitude">
        <input type="hidden" id="longitude" name="longitude">

        <button type="submit">Submit</button>
    </form>
</div>

<%
    if(sitters==null)
    {

        RegistrationService registrationService=new RegistrationService();

       // sitters= registrationService.findAlllUserNearThisLoccation((double)userLat,(double)userLng);

    }
%>
<div id="main-container">
    <% if (sitters != null) { %>
    <div id="result-list">
        <% for (SitterRegistration sitter : sitters) { %>
        <div class="sitter-card">

            <img src="images/<%= sitter.getLogo() %>" alt="Sitter Logo" class="sitter-image">
            <div>
                <strong><%= sitter.getContactname() %></strong><br>
                <span class="sitter-address"><%= sitter.getAddress() %></span>
            </div>
        </div>
        <% } %>
    </div>
    <% } %>


    <div id="map"></div>
    </div>
<script>
        let map;
        let marker;
        let geocoder;
        let openInfoWindow = null;
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
            animation: google.maps.Animation.DROP,
            draggable: true,
            visible: false,
        });

        marker.addListener("dragend", () => {
          const position = marker.getPosition();
           geocodeLatLng(position);
        });

        const input = document.getElementById("search");
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

        // Add multiple markers if available, else show default marker

        getUserLocation();
        addMultipleMarkers();
    }


    // Call this function when the page loads
    //It finds the latitude and logitude of the user who is searching
    function getUserLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                (position) => {
                    let userLat = position.coords.latitude;
                    let userLng = position.coords.longitude;

                    console.log("User's Location: ", userLat, userLng);

                    userlang=userLat;
                    userLong=userLng;
                    // Update the map to the user's location
                    let userLocation = { lat: userLat, lng: userLng };
                    map.setCenter(userLocation);
                    map.setZoom(14);

                    // Add a marker for the user's location
                    new google.maps.Marker({
                        position: userLocation,
                        map: map,
                        title: "Your Location",
                        icon: {
                            url: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png", // Blue icon for user
                            scaledSize: new google.maps.Size(40, 40)
                        }
                    });

                    // Set the values in hidden input fields (if needed for backend search)
                    document.getElementById("userLat").value = userLat;
                    document.getElementById("userLng").value = userLng;

                    console.log(userLat)
                    console.log(userLng)
                    console.log(typeof userLat)
                },
                (error) => {
                    console.error("Error getting location:", error.message);
                    alert("Location access denied. Please enable location services.");
                }
            );
        } else {
            alert("Geolocation is not supported by this browser.");
        }
    }



    function geocodeLatLng(position) {
        geocoder.geocode({ location: position }, (results, status) => {
            if (status === "OK" && results[0]) {
                document.getElementById("search").value = results[0].formatted_address;
                // updateCoordinates(position);
            } else {
                // document.getElementById("search").value = "Location not found";
            }
        });
    }

    function updateCoordinates(location) {
        document.getElementById("latitude").value = location.lat();
        document.getElementById("longitude").value = location.lng();
    }

    function addMultipleMarkers() {
        let locations = [
            <%
                boolean firstEntry = true;
                if (sitters != null) {
                    for (SitterRegistration sitter : sitters) {
                        try {
                            if (sitter.getLat() != null && sitter.getLng() != null
                                && !sitter.getLat().trim().isEmpty() && !sitter.getLng().trim().isEmpty()) {

                                double lat = Double.parseDouble(sitter.getLat().trim());
                                double lng = Double.parseDouble(sitter.getLng().trim());
                                String name = (sitter.getCompanyname() != null) ? sitter.getCompanyname() : "Unknown";
                                String logo = (sitter.getLogo() != null) ? "/images/" + sitter.getLogo() : "/images/default-logo.png";
                                String openHours = (sitter.getOpentime() != null) ? sitter.getOpentime() : "N/A";
                                String address = (sitter.getAddress() != null) ? sitter.getAddress() : "No Address Provided";

                                if (!firstEntry) { out.print(","); }
                                firstEntry = false;
            %>
            {
                lat: <%= lat %>,
                lng: <%= lng %>,
                logo: "<%= logo %>",
                openHours: "<%= openHours.replace("\"", "\\\"") %>",
                name: "<%= name.replace("\"", "\\\"") %>",
                address: "<%= address.replace("\"", "\\\"") %>"
            }
            <%
                            }
                        } catch (Exception e) {
                            out.println("/* Skipped invalid lat/lng for " + (sitter != null ? sitter.getCompanyname() : "Unknown") + " */");
                        }
                    }
                }
            %>
        ];

        if (locations.length === 0) {
            console.log("No valid locations found, using default marker.");
            return;
        }

        let bounds = new google.maps.LatLngBounds();
        let activeInfoWindow = null; // Track currently open InfoWindow

        locations.forEach((location) => {
            let marker = new google.maps.Marker({
                position: { lat: location.lat, lng: location.lng },
                map: map,
                title: location.name
            });

            const contentString =
                '<img src="'+location.logo+'" style="position: relative; width: 220px; height: 104px;">'+'<br/> <b>Company: </b>'+location.name+ ' <br/> <b>Email: </b>'+location.address+'<br/> <b class="text-success">Open: </b>'+location.openHours;

            let infoWindow = new google.maps.InfoWindow({
                content:contentString
            });

            marker.addListener("click", () => {
                if (openInfoWindow) {
                    openInfoWindow.close(); // Close the previously opened window
                }
                infoWindow.open(map, marker);
                openInfoWindow=infoWindow;
            });

            bounds.extend(marker.getPosition());
        });

        console.log("locations",locations);

        if (locations.length > 0) {
            map.fitBounds(bounds);
        }
    }

</script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCFGhHTFklBNiQGjvV3h03rc_vN995emG0&libraries=places&callback=initMap"></script>0
</body>
</html>
