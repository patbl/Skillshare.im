var markerData = window.markerData;
var map = L.map('map').setView([33, -20], 2);
L.tileLayer('http://{s}.tile.cloudmade.com/70ce02868fd24c55b1a6c905d1205651/997/256/{z}/{x}/{y}.png', {
    attribution: '© 2013 <a href="http://cloudmade.com/">CloudMade</a> – Map data <a href="http://www.openstreetmap.org/copyright">ODbL</a> 2013 <a href="http://www.openstreetmap.org/">OpenStreetMap.org</a> contributors – <a href="http://cloudmade.com/website-terms-conditions">Terms of Use</a>',
    maxZoom: 18
}).addTo(map);

var markers = new L.MarkerClusterGroup();

for(var i = 0; i < markerData.length; i++) {
    var currentMarkerData = markerData[i];
    var latlng = currentMarkerData.latlng;
    var popup = currentMarkerData.popup;
    var icon = L.AwesomeMarkers.icon({prefix: 'fa', icon: currentMarkerData.icon})
    var marker = new L.marker(latlng, {icon: icon}).bindPopup(popup);
    markers.addLayer(marker);
}
map.addLayer(markers);
