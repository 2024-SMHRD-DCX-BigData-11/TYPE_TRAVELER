<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TYPE TRAVELER</title>
<link rel="stylesheet" type="text/css"
   href="${pageContext.request.contextPath}/T_T_Main/css/Main_styles.css">
<style>
#map {
   width: 100%;
   height: 500px; /* 높이를 적절하게 설정하세요 */
}

.button-container {
display: flex;
justify-content: center; /* 버튼들을 가운데 정렬 */
gap: 10px; /* 버튼들 사이에 간격 추가 */
}

.wrap {
display: flex;
align-items: center;
justify-content: center;
margin-top: 25px;
}

.button {
  width: 140px;
  height: 45px;
  font-family: 'Roboto', sans-serif;
  font-size: 11px;
  text-transform: uppercase;
  letter-spacing: 2.5px;
  font-weight: 500;
  border: none;
  border-radius: 45px;
  box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease 0s;
  cursor: pointer;
  outline: none;
}

/* RANDOM 버튼 스타일 */
.random-button {
  background-color: #0fb0ff;
  color: #fff;
}

.random-button:hover {
  background-color: #0a8bcc;
  box-shadow: 0px 15px 20px rgba(15, 176, 255, 0.4);
  transform: translateY(-7px);
}

/* RESET 버튼 스타일 */
.reset-button {
  background-color: #fff;
  color: #000;
}

.reset-button:hover {
  background-color: #f0f0f0;
  box-shadow: 0px 15px 20px rgba(0, 0, 0, 0.1);
  transform: translateY(-7px);
}

/* 슬라이드 효과 추가 */
.slide-out {
  transform: translateY(-5px); /* 슬라이드 이동 거리 5px로 설정 */
  transition: transform 0.3s ease-out;
}

.slide-in {
  transform: translateY(5px); /* 슬라이드 이동 거리 5px로 설정 */
  transition: transform 0.3s ease-in;
}

.show {
  transform: translateY(0);
  transition: transform 0.3s ease-in;
}

/* 애니메이션 */
.cover {
  width: 100vw;
  height: 50px; /* 높이 추가 */
  margin: 10vh 0 20vh 0; /* 상단과 하단 여백 조정 */
  display: flex;
  align-items: center; /* 수직 중앙 정렬 */
  transform: rotate(-2deg); /* 요소 회전 각도 */
  background-color: #0fb0ff; /* 배경색 */
  justify-content: center; /* 내용물 중앙 정렬 */
  box-shadow: 0px 1.5px 1.5px rgba(15, 176, 255, 0.4);
}

.parallel {
  display: flex;
  padding: 1rem 0; /* 패딩을 줄여서 공간 줄이기 */
  font-size: 3rem; /* 텍스트 크기 줄이기 */
  color: white; /* 텍스트 색상 */
  margin: 0; /* 기본 마진 제거 */
}

/* 추가 스타일 */
.cover p {
  display: flex;
  padding: 1rem 0; /* 패딩을 줄여서 공간 줄이기 */
  font-size: 2rem; /* 텍스트 크기 줄이기 */
  margin: 0; /* 기본 마진 제거 */
}

</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
   <!-- T_T 상단 배너 -->
   <%@ include file="T_T_Main_Banner.jsp"%>

   <!-- 배너 아래 검색창 -->
   <div class="main-content">
      <div class="search-container">
         <input type="text" id="searchQuery" placeholder="검색어를 입력하세요"
            onkeypress="handleKeyPress(event)" />
         <div class="search-icon-container">
            <img
               src="${pageContext.request.contextPath}/T_T_Main/images/Freepik_0fb0ff.png"
               class="search-icon" onclick="search()" />
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
      var currentMarker = null;
        var map = null;
            function loadKakaoMap() {
                var mapContainer = document.getElementById('map'); 
                var mapOption = { 
                    center: new kakao.maps.LatLng(36.5, 127.5), // 한반도 중앙으로 설정
                    level: 13 // 초기 확대 레벨
                }; 
                map = new kakao.maps.Map(mapContainer, mapOption);

                // 클릭된 마커를 저장할 변수
                //var currentMarker = null;

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
                                        // 현재 옵션 텍스트와 행정구역 정보를 비교하여 선택
                                        if (regionSelect.options[j].text === result[i].region_1depth_name || 
                                            regionSelect.options[j].text === result[i].region_2depth_name ||
                                            (result[i].region_1depth_name === "강원특별자치도" && regionSelect.options[j].text === "강원특별자치도") ||
                                            (result[i].region_1depth_name === "전북특별자치도" && regionSelect.options[j].text === "전북특별자치도")) {
                                            regionSelect.selectedIndex = j;
                                            tags[0] = '#' + result[i].region_1depth_name;
                                            change();
                                            fetchData();
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
               <option value="강원특별자치도">강원특별자치도</option>
               <option value="충청북도">충청북도</option>
               <option value="충청남도">충청남도</option>
               <option value="전북특별자치도">전북특별자치도</option>
               <option value="전라남도">전라남도</option>
               <option value="경상북도">경상북도</option>
               <option value="경상남도">경상남도</option>
               <option value="제주특별자치도">제주특별자치도</option>
            </select>
         </div>

         <!-- step2 -->
         <div class="step">
            <label for="category">STEP 2</label> <br> 
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

         <!-- step3 -->
         <div class="step">
            <label for="mbti">STEP 3</label> <br> 
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

     <div class="button-container">
       <div class="wrap">
         <button id="reload" class="button random-button">RANDOM</button>
       </div>
       <div class="wrap">
         <button id="reset" class="button reset-button">RESET</button>
       </div>
     </div>

         </div>
      </div>
   </div>

      <div id="calendar-container">
         <%@ include file="calendar.html"%>
      </div>
      
      <div class="cover">
            <p class="parallel"></p>
      </div>
      

   <!-- hover script -->
   <script>
   
   const arr = ['서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종', '경기도', '강원도', '충북', '충남', '전북', '전남', '경북', '경남', '제주도'];
   const coordinates = [
       [37.5665, 126.9780], // 서울특별시
       [35.1796, 129.0756], // 부산광역시
       [35.8714, 128.6014], // 대구광역시
       [37.4563, 126.7052], // 인천광역시
       [35.1595, 126.8526], // 광주광역시
       [36.3504, 127.3845], // 대전광역시
       [35.5384, 129.3114], // 울산광역시
       [36.4800, 127.2890], // 세종특별자치시
       [37.4138, 127.5183], // 경기도
       [37.8228, 128.1555], // 강원특별자치도
       [36.6357, 127.4913], // 충청북도
       [36.5184, 126.8000], // 충청남도
       [35.8204, 127.1088], // 전북특별자치도
       [34.8679, 126.9910], // 전라남도
       [36.5760, 128.5056], // 경상북도
       [35.2383, 128.6928], // 경상남도
       [33.4996, 126.5312]  // 제주특별자치도
   ];
   const hashtag = document.getElementById('hashtag');                
   const region = document.getElementById('region');

   let tags = ['', '', ''];
   region.addEventListener('change', () => { // 지역 선택
       tags[0] = '#' + arr[region.selectedIndex - 1];
       change();
       fetchData();

       if (currentMarker) {
           currentMarker.setMap(null);
       }

       // 새로운 마커를 생성하여 지도에 표시합니다.
       currentMarker = new kakao.maps.Marker({
           position: new kakao.maps.LatLng(coordinates[region.selectedIndex - 1][0], coordinates[region.selectedIndex - 1][1]),
           map: map
       });
   });

   const category = document.getElementById('category');
   category.addEventListener('change', () => { // 카테고리 선택
       var selectedValue = category.options[category.selectedIndex].value;
       tags[1] = '#' + selectedValue;
       change();
       fetchData();
   });

   const mbti = document.getElementById('mbti');
   mbti.addEventListener('change', () => { // MBTI 선택
       var selectedValue = mbti.options[mbti.selectedIndex].value;
       tags[2] = '#' + selectedValue;
       change();
       fetchData();
   });

   function change() {
       if (tags[0] === '' && tags[1] === '' && tags[2] === '') {
           hashtag.innerText = '#전체';
       } else {
           hashtag.innerText = tags.filter(tag => tag !== '').join(' ');
       }
   }

   function fetchData() {
       // 기존 요소들을 슬라이드 아웃 시킵니다.
       document.querySelectorAll('.package').forEach(package => {
           package.classList.remove('show');
           package.classList.add('slide-out');
       });

       // 데이터를 가져오고 새로운 데이터로 업데이트
       $.ajax({
           type: "GET",
           data: {
               region: region.options[region.selectedIndex].value,
               category: category.selectedIndex,
               mbti: mbti.options[mbti.selectedIndex].value,
               max: 4
           },
           url: "/TYPE_TRAVELER/RegionCon",
           success: function(res) {
               console.log(res);
               imgs = document.querySelectorAll('.package .image');
               titles = document.querySelectorAll('.package .title');
               addresses = document.querySelectorAll('.package .address');
               explanations = document.querySelectorAll('.package .explanation');
               keywords = document.querySelectorAll('.package .keywords');
               
               let i = 0;
               res.forEach(value => {
                   imgs[i].src = value.region_img;
                   titles[i].innerText = value.region_title;
                   addresses[i].innerText = value.region_info;
                   explanations[i].innerText = value.region_address;
                   keywords[i++].innerText = value.keyword;
               });

               // 슬라이드 아웃이 완료된 후 슬라이드 인을 시작합니다.
               setTimeout(() => {
                   document.querySelectorAll('.package').forEach(package => {
                       package.classList.remove('slide-out');
                       package.classList.add('slide-in');
                       setTimeout(() => {
                           package.classList.remove('slide-in');
                           package.classList.add('show');
                       }, 300); // 슬라이드 인 효과 시간과 일치하도록 지연 시간 설정
                   });
               }, 300);  // 슬라이드 아웃 시간과 일치하도록 지연 시간 설정
           },
           error: function() {
               alert('통신실패');
           }
       });
   }

   document.getElementById('reset').addEventListener('click', () => {
       // 필터를 초기 상태로 설정
       document.getElementById('region').selectedIndex = 0;
       document.getElementById('category').selectedIndex = 0;
       document.getElementById('mbti').selectedIndex = 0;

       // 태그를 초기화
       tags = ['', '', ''];
       change();

       // 초기 데이터를 가져옵니다
       fetchData();
   });

   document.getElementById('reload').addEventListener('click', () => {
       fetchData();
   });

   fetchData(); // 페이지 로드 시 초기 데이터 가져오기

   </script>
   
   <script src="${pageContext.request.contextPath}/T_T_Main/Main_script.js"></script>
   
</body>
</html>
