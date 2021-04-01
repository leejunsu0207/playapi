<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<body>


<h1>hi lotto</h1>
<div id="map" name="map" style="width: 100%;height: 500px;"></div>
<input type="text" id="search" name="search" placeholder="로또 판매점 위치 검색 ex)능곡역 로또" style="width: 300px;">
<button type="button" onclick="search()">검색</button>
<div id="content">
    <h1>번호 추첨</h1>
    <input type="number" id="gameCount" name="gameCount" placeholder="게임 갯수 입력" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
    <button onclick="lottoRandomNumber()">random</button>
    <div id="lottoNumber" style="font-size: 30px;"></div>
</div>
<script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1753e147b549e8d0235a24996f14d540&libraries=services,clusterer,drawing"></script>
<script>

    let container = document.getElementById('map');
    let options;
    let map;
    // 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
    let infowindow = new kakao.maps.InfoWindow({zIndex: 1});
    let ps;

    function success(position) {
        const latitude = position.coords.latitude;
        const longitude = position.coords.longitude;

        options = {
            center: new kakao.maps.LatLng(latitude, longitude),
            level: 3
        };

        map = new kakao.maps.Map(container, options);


    }

    function error() {
        console.log('Unable to retrieve your location');
    }

    if (!navigator.geolocation) {
        console.log('Geolocation is not supported by your browser')
    } else {
        console.log('Locating...');
        navigator.geolocation.getCurrentPosition(success, error);
    }

    function search() {
        const search = document.getElementById('search');
        console.log(search.value);
        if (search.value !== "") {
            // 장소 검색 객체를 생성합니다
            ps = new kakao.maps.services.Places();
            // 키워드로 장소를 검색합니다
            ps.keywordSearch(search.value, placesSearchCB);

        } else {
            alert("검색어 입력후 검색하자!!");
        }

    }


    // 키워드 검색 완료 시 호출되는 콜백함수 입니다
    function placesSearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
            // LatLngBounds 객체에 좌표를 추가합니다
            var bounds = new kakao.maps.LatLngBounds();

            for (var i = 0; i < data.length; i++) {
                displayMarker(data[i]);
                bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
            }

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
            map.setBounds(bounds);
        }
    }

    // 지도에 마커를 표시하는 함수입니다
    function displayMarker(place) {
        // 마커를 생성하고 지도에 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: new kakao.maps.LatLng(place.y, place.x)
        });

        // 마커에 클릭이벤트를 등록합니다
        kakao.maps.event.addListener(marker, 'click', function () {
            // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
            infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
            infowindow.open(map, marker);
        });
    }

    const lottoRandomNumber = () => {
        const params ={
            gameCount : document.getElementById("gameCount").value
        }

        $.ajax({
            type: "POST",
            url: "/lotto/randomNumber",
            data: params,
            error: function (error) {
                console.log("서버 응답 없음");
            },
            success: function (data) {
                console.log(data);
                const innerText = document.getElementById("lottoNumber");
                innerText.innerHTML = data;
            }
        });

    }


</script>


</body>
</html>