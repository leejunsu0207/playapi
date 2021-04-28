<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<!DOCTYPE html>
<html>
<head>
    <title>로또구매점 검색 및 추천번호 생성!</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <style>
        .map_wrap, .map_wrap * {
            margin: 0;
            padding: 0;
            font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
            font-size: 12px;
        }

        .map_wrap a, .map_wrap a:hover, .map_wrap a:active {
            color: #000;
            text-decoration: none;
        }

        .map_wrap {
            position: relative;
            width: 100%;
            height: 500px;
        }

        #menu_wrap {
            position: absolute;
            top: 0;
            left: 0;
            bottom: 0;
            width: 250px;
            margin: 10px 0 30px 10px;
            padding: 5px;
            overflow-y: auto;
            background: rgba(255, 255, 255, 0.7);
            z-index: 1;
            font-size: 12px;
            border-radius: 10px;
        }

        .bg_white {
            background: #fff;
        }

        #menu_wrap hr {
            display: block;
            height: 1px;
            border: 0;
            border-top: 2px solid #5F5F5F;
            margin: 3px 0;
        }

        #menu_wrap .option {
            text-align: center;
        }

        #menu_wrap .option p {
            margin: 10px 0;
        }

        #menu_wrap .option button {
            margin-left: 5px;
        }

        #placesList li {
            list-style: none;
        }

        #placesList .item {
            position: relative;
            border-bottom: 1px solid #888;
            overflow: hidden;
            cursor: pointer;
            min-height: 65px;
        }

        #placesList .item span {
            display: block;
            margin-top: 4px;
        }

        #placesList .item h5, #placesList .item .info {
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
        }

        #placesList .item .info {
            padding: 10px 0 10px 55px;
        }

        #placesList .info .gray {
            color: #8a8a8a;
        }

        #placesList .info .jibun {
            padding-left: 26px;
            background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;
        }

        #placesList .info .tel {
            color: #009900;
        }

        #placesList .item .markerbg {
            float: left;
            position: absolute;
            width: 36px;
            height: 37px;
            margin: 10px 0 0 10px;
            background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;
        }

        #placesList .item .marker_1 {
            background-position: 0 -10px;
        }

        #placesList .item .marker_2 {
            background-position: 0 -56px;
        }

        #placesList .item .marker_3 {
            background-position: 0 -102px
        }

        #placesList .item .marker_4 {
            background-position: 0 -148px;
        }

        #placesList .item .marker_5 {
            background-position: 0 -194px;
        }

        #placesList .item .marker_6 {
            background-position: 0 -240px;
        }

        #placesList .item .marker_7 {
            background-position: 0 -286px;
        }

        #placesList .item .marker_8 {
            background-position: 0 -332px;
        }

        #placesList .item .marker_9 {
            background-position: 0 -378px;
        }

        #placesList .item .marker_10 {
            background-position: 0 -423px;
        }

        #placesList .item .marker_11 {
            background-position: 0 -470px;
        }

        #placesList .item .marker_12 {
            background-position: 0 -516px;
        }

        #placesList .item .marker_13 {
            background-position: 0 -562px;
        }

        #placesList .item .marker_14 {
            background-position: 0 -608px;
        }

        #placesList .item .marker_15 {
            background-position: 0 -654px;
        }

        #pagination {
            margin: 10px auto;
            text-align: center;
        }

        #pagination a {
            display: inline-block;
            margin-right: 10px;
        }

        #pagination .on {
            font-weight: bold;
            cursor: default;
            color: #777;
        }

        #lottoNumResult {
            display: table;
            width: 100%;
        }

        .row {
            display: table-row;
        }

        .cell {
            display: table-cell;
            padding: 3px;
            border-bottom: 1px solid #DDD;
        }

        .col1 {
            width: 9%;
        }

        .col2 {
            width: 20%;
        }

        .col3 {
            width: 9%;
        }

        .col4 {
            width: 9%;
        }

        .col5 {
            width: 9%;
        }

        .col6 {
            width: 9%;
        }

        .col7 {
            width: 9%;
        }

        .col8 {
            width: 9%;
        }

        .col9 {
            width: 17%;
        }

        .p_r{
            padding-right: 15px;
        }
    </style>
</head>

<body>

<div>
    <span style="font-size: 50px; font-weight: bold; cursor:pointer;" onclick="location.reload()">hi lotto</span>
    <span onClick="lotteryNumber()" style="cursor:pointer;">추첨결과</span>
</div>

<div class="map_wrap">
    <div id="map" style="width: 100%;height: 500px;position:relative;overflow:hidden;"></div>
    <div id="menu_wrap" class="bg_white">
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
    <input type="text" id="search" name="search" placeholder="로또 판매점 위치 검색 ex)능곡역 로또" style="width: 300px;">
    <button type="button" onclick="search()">검색</button>
</div>


<div id="content">
    <h1>번호 추첨</h1>
    <input type="number" id="gameCount" name="gameCount" placeholder="게임 갯수 입력"
           onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
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
    let infowindow;
    let ps;
    // 마커를 담을 배열입니다
    let markers = [];

    function success(position) {
        const latitude = position.coords.latitude;
        const longitude = position.coords.longitude;

        options = {
            center: new kakao.maps.LatLng(latitude, longitude),
            level: 3
        };

        map = new kakao.maps.Map(container, options);
        // 지도에 교통정보를 표시하도록 지도타입을 추가합니다
        map.addOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC);
        infowindow = new kakao.maps.InfoWindow({zIndex: 1});

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
        document.getElementById('search').value= null;

    }


    // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
    function placesSearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {

            // 정상적으로 검색이 완료됐으면
            // 검색 목록과 마커를 표출합니다
            displayPlaces(data);

            // 페이지 번호를 표출합니다
            displayPagination(pagination);

        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

            alert('검색 결과가 존재하지 않습니다.');
            return;

        } else if (status === kakao.maps.services.Status.ERROR) {

            alert('검색 결과 중 오류가 발생했습니다.');
            return;

        }
    }

    // 검색 결과 목록과 마커를 표출하는 함수입니다
    function displayPlaces(places) {

        let listEl = document.getElementById('placesList'),
            menuEl = document.getElementById('menu_wrap'),
            fragment = document.createDocumentFragment(),
            bounds = new kakao.maps.LatLngBounds(),
            listStr = '';

        // 검색 결과 목록에 추가된 항목들을 제거합니다
        removeAllChildNods(listEl);

        // 지도에 표시되고 있는 마커를 제거합니다
        removeMarker();

        for (let i = 0; i < places.length; i++) {

            // 마커를 생성하고 지도에 표시합니다
            let placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                marker = addMarker(placePosition, i),
                itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
            // LatLngBounds 객체에 좌표를 추가합니다
            bounds.extend(placePosition);

            // 마커와 검색결과 항목에 mouseover 했을때
            // 해당 장소에 인포윈도우에 장소명을 표시합니다
            // mouseout 했을 때는 인포윈도우를 닫습니다
            (function (marker, title) {
                kakao.maps.event.addListener(marker, 'mouseover', function () {
                    displayInfowindow(marker, title);
                });

                kakao.maps.event.addListener(marker, 'mouseout', function () {
                    infowindow.close();
                });

                itemEl.onmouseover = function () {
                    displayInfowindow(marker, title);
                };

                itemEl.onmouseout = function () {
                    infowindow.close();
                };
            })(marker, places[i].place_name);

            fragment.appendChild(itemEl);
        }

        // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
        listEl.appendChild(fragment);
        menuEl.scrollTop = 0;

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    }

    // 검색결과 항목을 Element로 반환하는 함수입니다
    function getListItem(index, places) {

        let el = document.createElement('li'),
            itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

        if (places.road_address_name) {
            itemStr += '    <span>' + places.road_address_name + '</span>' +
                '   <span class="jibun gray">' + places.address_name + '</span>';
        } else {
            itemStr += '    <span>' + places.address_name + '</span>';
        }

        itemStr += '  <span class="tel">' + places.phone + '</span>' +
            '</div>';

        el.innerHTML = itemStr;
        el.className = 'item';

        return el;
    }

    // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
    function addMarker(position, idx, title) {
        let imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
            imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
            imgOptions = {
                spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
            },
            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
                position: position, // 마커의 위치
                image: markerImage
            });

        marker.setMap(map); // 지도 위에 마커를 표출합니다
        markers.push(marker);  // 배열에 생성된 마커를 추가합니다

        return marker;
    }

    // 지도 위에 표시되고 있는 마커를 모두 제거합니다
    function removeMarker() {
        for (let i = 0; i < markers.length; i++) {
            markers[i].setMap(null);
        }
        markers = [];
    }

    // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
    function displayPagination(pagination) {
        let paginationEl = document.getElementById('pagination'),
            fragment = document.createDocumentFragment(),
            i;

        // 기존에 추가된 페이지번호를 삭제합니다
        while (paginationEl.hasChildNodes()) {
            paginationEl.removeChild(paginationEl.lastChild);
        }

        for (i = 1; i <= pagination.last; i++) {
            let el = document.createElement('a');
            el.href = "#";
            el.innerHTML = i;

            if (i === pagination.current) {
                el.className = 'on';
            } else {
                el.onclick = (function (i) {
                    return function () {
                        pagination.gotoPage(i);
                    }
                })(i);
            }

            fragment.appendChild(el);
        }
        paginationEl.appendChild(fragment);
    }

    // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
    // 인포윈도우에 장소명을 표시합니다
    function displayInfowindow(marker, title) {
        let content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

        infowindow.setContent(content);
        infowindow.open(map, marker);
    }

    // 검색결과 목록의 자식 Element를 제거하는 함수입니다
    function removeAllChildNods(el) {
        while (el.hasChildNodes()) {
            el.removeChild(el.lastChild);
        }
    }

    function lottoRandomNumber() {
        const gameCount = document.getElementById("gameCount").value;
        const innerText = document.getElementById("lottoNumber");

        if (gameCount === null || gameCount === "") {
            alert("게임 구매 갯수 입력 하자");
            return false;
        }
        if(gameCount > 100){
            alert("100게임 초과는 안된다!");
            document.getElementById("gameCount").value = null;
            return false;
        }

        const params = {
            gameCount: document.getElementById("gameCount").value
        }

        $.ajax({
            type: "POST",
            url: "/lotto/randomNumbers",
            data: params,
            error: function (error) {
                console.log(error.toString());
                console.log("서버 응답 없음");
            },
            success: function (data) {

                console.log(data);
                innerText.innerHTML = "";
                let dataArr = [];
                dataArr = data;

                for(let i=0; i<dataArr.length; i++){
                    for(let j=0; j<dataArr[i].length; j++){
                        console.log("length", dataArr[i][j].length);
                        innerText.innerHTML += "<span class='f"+i+"s"+j+" p_r'>" + dataArr[i][j] + "</span>";
                    }
                    innerText.innerHTML += "<br>";
                }

                document.getElementById("gameCount").value = null;
            }
        });

    }

    function lotteryNumber() {
        console.log("lotteryNumber");
        let content = document.getElementById("content");
        content.innerHTML = "";
        content.innerHTML += "<h1>검색 회차별 로또 번호</h1>";
        content.innerHTML += "<input type='number' id='drwNo' name='drwNo' placeholder='회차별 당첨번호' onKeyup='this.value=this.value.replace(/[^0-9]/g,'');'>";
        content.innerHTML += "<button onclick='getLottoNumResult()'>검색</button>";
        content.innerHTML += "<div id='lottoNumResult' style='font-size: 30px;'></div>";

    }

    function getLottoNumResult() {
        const drwNo = document.getElementById("drwNo").value;
        const innerText = document.getElementById("lottoNumResult");

        if (drwNo === null || drwNo === "") {
            alert("조회할 회차 입력!!");
            return false;
        }
        const params = {
            drwNo: drwNo
        }

        $.ajax({
            type: "GET",
            url: "/api/lottoNumber",
            data: params,
            error: function (error) {
                console.log("서버 응답 없음");
            },
            success: function (data) {

                console.log(data);
                if (data.returnValue === "fail") {
                    alert("조회된 회차가 없습니다.");
                } else {
                    innerText.innerHTML = "";
                    innerText.innerHTML += "<div class='row'>";
                    innerText.innerHTML += "<span class='cell col1'>회차</span>";
                    innerText.innerHTML += "<span class='cell col2'>추첨일</span>";
                    innerText.innerHTML += "<span class='cell col3'>1번째</span>";
                    innerText.innerHTML += "<span class='cell col4'>2번째</span>";
                    innerText.innerHTML += "<span class='cell col5'>3번째</span>";
                    innerText.innerHTML += "<span class='cell col6'>4번째</span>";
                    innerText.innerHTML += "<span class='cell col7'>5번째</span>";
                    innerText.innerHTML += "<span class='cell col8'>6번째</span>";
                    innerText.innerHTML += "<span class='cell col9'>보너스</span>";
                    innerText.innerHTML += "</div>";
                    innerText.innerHTML += "<div class='row'>";
                    innerText.innerHTML += "<span class='cell col1'>" + data.drwNo + "</span>";
                    innerText.innerHTML += "<span class='cell col2'>" + data.drwNoDate + "</span>";
                    innerText.innerHTML += "<span class='cell col3'>" + data.drwtNo1 + "</span>";
                    innerText.innerHTML += "<span class='cell col4'>" + data.drwtNo2 + "</span>";
                    innerText.innerHTML += "<span class='cell col5'>" + data.drwtNo3 + "</span>";
                    innerText.innerHTML += "<span class='cell col6'>" + data.drwtNo4 + "</span>";
                    innerText.innerHTML += "<span class='cell col7'>" + data.drwtNo5 + "</span>";
                    innerText.innerHTML += "<span class='cell col8'>" + data.drwtNo6 + "</span>";
                    innerText.innerHTML += "<span class='cell col9'>" + data.bnusNo + "</span>";
                    innerText.innerHTML += "</div>";
                }
                document.getElementById("drwNo").value = null;

            }
        });
    }

    // <h1>번호 추첨</h1>
    // <input type="number" id="gameCount" name="gameCount" placeholder="게임 갯수 입력"
    //        onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
    //     <button onclick="lottoRandomNumber()">random</button>
    //     <div id="lottoNumber" style="font-size: 30px;"></div>

</script>


</body>
</html>