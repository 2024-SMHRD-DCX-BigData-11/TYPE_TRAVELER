window.onload = function() {
    var mapContainer = document.getElementById('map'); // 'map' ID 확인
    var mapOption = {
        center: new kakao.maps.LatLng(36.5, 127.5), // 한반도 중심으로 이동
        level: 13 // 초기 확대 레벨
    };

    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 클릭된 마커를 저장할 변수
    var currentMarker = null;

    // 클릭 이벤트를 등록합니다.
    kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
        // 클릭한 위치의 좌표를 가져옵니다.
        var latlng = mouseEvent.latLng;

        // 클릭된 마커가 있으면 지도에서 제거합니다.
        if (currentMarker) {
            currentMarker.setMap(null);
        }

        // 새로운 마커를 생성하여 지도에 표시합니다.
        currentMarker = new kakao.maps.Marker({
            position: latlng,
            map: map
        });

        // 클릭한 마커의 위치로 지도를 이동합니다.
        map.panTo(latlng);
    });
};
