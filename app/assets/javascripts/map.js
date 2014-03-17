var map = L.map('map', {
    layers: MQ.mapLayer(),
    center: [33, -20],
    zoom: 2
});

var markerData = window.markerData;
var markers = new L.MarkerClusterGroup();
for(var i = 0; i < markerData.length; i++) {
    var currentMarkerData = markerData[i];
    var latlng = currentMarkerData.latlng;
    var popup = currentMarkerData.popup;
    var icon = L.AwesomeMarkers.icon({prefix: 'fa', icon: currentMarkerData.icon});
    var marker = new L.marker(latlng, {icon: icon}).bindPopup(popup);
    markers.addLayer(marker);
}
map.addLayer(markers);
