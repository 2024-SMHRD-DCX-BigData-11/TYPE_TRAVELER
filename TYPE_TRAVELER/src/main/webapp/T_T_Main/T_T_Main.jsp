<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TYPE TRAVELER</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Main/css/Main_styles.css">
    <style>
        #map {
            width: 100%;
            height: 500px; /* 높이를 적절하게 설정하세요 */
        }
    </style>
</head>
<body>
    <!-- T_T 상단 배너 -->
    <%@ include file="T_T_Main_Banner.jsp" %>
    
    <!-- 배너 아래 검색창 -->
    <div class="main-content">
        <div class="search-container">
            <input type="text" id="searchQuery" placeholder="검색어를 입력하세요" onkeypress="handleKeyPress(event)" />
            <div class="search-icon-container">
                <img src="${pageContext.request.contextPath}/T_T_Main/images/Freepik_0fb0ff.png" class="search-icon" onclick="search()" />
            </div>
        </div>
    </div>
    
    <!-- 검색창 script -->
    <script type="text/javascript">
        function search() {
            var query = document.getElementById('searchQuery').value;
            if (query) {
                var url = 'https://search.naver.com/search.naver?query=' + encodeURIComponent(query);
                window.open(url, '_blank');
            }
        }

        function handleKeyPress(event) {
            if (event.key === 'Enter') {
                search();
            }
        }
    </script>

    <!-- 지도와 필터, 결과 영역 -->
    <div class="content-container">
        <!-- 지도 -->
        <div id="map"></div>
        <script type="text/javascript">
            function loadKakaoMap() {
                var mapContainer = document.getElementById('map'); 
                var mapOption = { 
                    center: new kakao.maps.LatLng(36.5, 127.5), // 한반도 중앙으로 설정
                    level: 13 // 초기 확대 레벨
                }; 
                var map = new kakao.maps.Map(mapContainer, mapOption);

                // 클릭된 마커를 저장할 변수
                var currentMarker = null;

                // 주소-좌표 변환 객체를 생성합니다.
                var geocoder = new kakao.maps.services.Geocoder();

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

                    // 좌표로 행정 구역 정보를 요청합니다.
                    geocoder.coord2RegionCode(latlng.getLng(), latlng.getLat(), function(result, status) {
                        if (status === kakao.maps.services.Status.OK) {
                            for (var i = 0; i < result.length; i++) {
                                // 행정 구역 정보를 찾습니다.
                                if (result[i].region_type === 'H') {
                                    // 선택 박스를 업데이트합니다.
                                    var regionSelect = document.getElementById('region');
                                    var regionName = result[i].region_1depth_name + " " + result[i].region_2depth_name;

                                    for (var j = 0; j < regionSelect.options.length; j++) {
                                        if (regionSelect.options[j].text === result[i].region_1depth_name || regionSelect.options[j].text === result[i].region_2depth_name) {
                                            regionSelect.selectedIndex = j;
                                            break;
                                        }
                                    }
                                    break;
                                }
                            }
                        }
                    });
                });
            }

            (function(d, s) {
                var js = d.createElement(s), sc = d.getElementsByTagName(s)[0];
                js.src = "//dapi.kakao.com/v2/maps/sdk.js?appkey=ac06d1eb96a82f15c5e3eb479f6eadaf&autoload=false&libraries=services";
                js.async = true;
                js.onload = function() {
                    kakao.maps.load(loadKakaoMap);
                };
                sc.parentNode.insertBefore(js, sc);
            })(document, 'script');
        </script>

        <!-- STEP 필터 박스 -->
        <div id="central-box" class="central-box">
            <!-- step1 -->
            <div class="step">
                <label for="region">STEP 1</label> <br>
                <select id="region" name="region">
                    <option value="" disabled selected>지역을 선택해 주세요.</option>
                    <option value="서울특별시">서울특별시</option>
                    <option value="부산광역시">부산광역시</option>
                    <option value="대구광역시">대구광역시</option>
                    <option value="인천광역시">인천광역시</option>
                    <option value="광주광역시">광주광역시</option>
                    <option value="대전광역시">대전광역시</option>
                    <option value="울산광역시">울산광역시</option>
                    <option value="세종특별자치시">세종특별자치시</option>
                    <option value="경기도">경기도</option>
                    <option value="강원도">강원도</option>
                    <option value="충청북도">충청북도</option>
                    <option value="충청남도">충청남도</option>
                    <option value="전라북도">전라북도</option>
                    <option value="전라남도">전라남도</option>
                    <option value="경상북도">경상북도</option>
                    <option value="경상남도">경상남도</option>
                    <option value="제주특별자치도">제주특별자치도</option>
                </select>
            </div>

            <!-- step2 -->
            <div class="step">
                <label for="mbti">STEP 2</label> <br>
                <select id="mbti" name="mbti">
                    <option value="" disabled selected>MBTI를 선택해 주세요.</option>
                    <option value="ISTJ">ISTJ</option>
                    <option value="ISFJ">ISFJ</option>
                    <option value="INFJ">INFJ</option>
                    <option value="INTJ">INTJ</option>
                    <option value="ISTP">ISTP</option>
                    <option value="ISFP">ISFP</option>
                    <option value="INFP">INFP</option>
                    <option value="INTP">INTP</option>
                    <option value="ESTP">ESTP</option>
                    <option value="ESFP">ESFP</option>
                    <option value="ENFP">ENFP</option>
                    <option value="ENTP">ENTP</option>
                    <option value="ESTJ">ESTJ</option>
                    <option value="ESFJ">ESFJ</option>
                    <option value="ENFJ">ENFJ</option>
                    <option value="ENTJ">ENTJ</option>
                </select>
            </div>
            
            <!-- step3 -->
            <div class="step">
                <label for="category">STEP 3</label> <br>
                <select id="category" name="category">
                    <option value="" disabled selected>카테고리를 선택해 주세요.</option>
                    <option value="자연경관">자연경관</option>
                    <option value="문화및역사">문화및역사</option>
                    <option value="도시관광">도시관광</option>
                    <option value="레저및액티비티">레저및액티비티</option>
                    <option value="맛집탐방">맛집탐방</option>
                    <option value="힐링및휴식">힐링및휴식</option>
                    <option value="가족여행">가족여행</option>
                    <option value="로맨틱여행">로맨틱여행</option>
                    <option value="호캉스여행">호캉스여행</option>
                </select>
            </div>
        </div>  

        <!-- 결과 박스 -->
        <div class="right-box">
            <div class="content">
                <div id="hashtag">#전체</div>
                <div class="package">
                    <img src="" alt="장소 이미지" class="image">
                        <div class="element">
                            <div class="title"></div>
                            <div class="address"></div>
                            <div class="explanation"></div>
                            <div class="keywords"></div>
                        </div>
                    </div> 
                <div class="line"></div>
                
                <div class="package">
                    <img src="" alt="장소 이미지" class="image">
                        <div class="element">
                            <div class="title"></div>
                            <div class="address"></div>
                            <div class="explanation"></div>
                            <div class="keywords"></div>
                        </div>
                    </div> 
                <div class="line"></div>
                
                <div class="package">
                    <img src="" alt="장소 이미지" class="image">
                        <div class="element">
                            <div class="title"></div>
                            <div class="address"></div>
                            <div class="explanation"></div>
                            <div class="keywords"></div>
                        </div>
                    </div> 
                <div class="line"></div>
            
                <div class="package">
                    <img src="" alt="장소 이미지" class="image">
                        <div class="element">
                            <div class="title"></div>
                            <div class="address"></div>
                            <div class="explanation"></div>
                            <div class="keywords"></div>
                        </div>
                    </div> 
                <div class="line"></div>
            
            <div class="indicator">
            <div class="circle"></div>
            <div class="circle"></div>
            <div class="circle"></div>
            </div>
            
            <footer>
                <button id="button" onclick="window.location.href='${pageContext.request.contextPath}/T_T_Main/T_T_Main.jsp'">
                    <span class="black-text">나와 같은 MBTI지만,</span> 
                    <span class="highlight-text">다른 여행지</span> 
                    <span class="black-text">추천이 궁금하다면?</span>
                </button>
            </footer>
            
            <!-- hover script -->
            <script>
                document.addEventListener('DOMContentLoaded', (event) => {
                    const button = document.getElementById('button');
                    const yellowText = document.querySelector('.highlight-text');

                    button.addEventListener('mouseover', () => {
                        yellowText.classList.add('hover');
                    });

                    button.addEventListener('mouseout', () => {
                        yellowText.classList.remove('hover');
                    });
                });
            </script>
            </div>
        </div>
        
        
    </div>  <!-- 사각형 세 개 묶는 div -->   
    <div id="calendar-container">
        <%@ include file="calendar.html" %>
    </div>

    
    <div id="maker-container">
        <div id="maker"><span>ⓒ TYPE_TRAVELER</span></div>
    </div>

    <!-- 페이지 로드 시 로그인 상태 확인 및 배너 업데이트 script 추가 -->
    <script>
        // 페이지 로드 시 로그인 상태 확인 및 배너 업데이트
        function updateBanner() {
            const isLoggedIn = sessionStorage.getItem('isLoggedIn');
            const username = sessionStorage.getItem('username');

            if (isLoggedIn === 'true') {
                document.getElementById('loginButton').textContent = '마이페이지';
                document.getElementById('loginButton').href = 'javascript:void(0);';
                document.getElementById('loginButton').onclick = openMyPageModal;
                document.getElementById('registerButton').textContent = '로그아웃';
                document.getElementById('registerButton').href = '#';
                document.getElementById('registerButton').onclick = logout; // 로그아웃 함수 연결
            }
        }

        // 로그아웃 함수
        function logout() {
            // 세션에서 로그인 상태 제거
            sessionStorage.removeItem('isLoggedIn');
            sessionStorage.removeItem('username');
            // 메인 페이지로 이동
            window.location.href = '${pageContext.request.contextPath}/T_T_Main/T_T_Main.jsp';
        }

        // 페이지 로드 시 배너 업데이트 함수 호출
        window.onload = updateBanner;
    </script>

</body>
</html>
