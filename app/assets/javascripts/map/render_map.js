var map = L.map('map').setView([33, -20], 2);
L.tileLayer('http://{s}.tile.cloudmade.com/70ce02868fd24c55b1a6c905d1205651/997/256/{z}/{x}/{y}.png', {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
    maxZoom: 18
}).addTo(map);
L.Icon.Default.imagePath = "/assets";

var markers = new L.MarkerClusterGroup();

for(var i = 0; i < markerData420.length; i++) {
    var marker = markerData420[i];
    markers.addLayer(new L.marker(marker.latlng).bindPopup(marker.popup));
}

map.addLayer(markers);
