<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Arrays"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TYPE TRAVELER_여행정보</title>
<link rel="stylesheet" type="text/css"
   href="${pageContext.request.contextPath}/T_T_Main/css/Main_styles.css">
<link rel="stylesheet" type="text/css"
   href="${pageContext.request.contextPath}/T_T_Info/css/Info_styles.css">
</head>
<body>
   <!-- T_T 상단 배너 -->
   <%@ include file="../T_T_Main/T_T_Main_Banner.jsp"%>

   <!-- 여행 정보 콘텐츠 -->
   <div class="travel-info">
      <h1>#여행정보</h1>

      <!-- 해시태그 영역 -->
      <div class="hashtags">
         <div class="address">
            <%
            List<String> addresses = Arrays.asList("#전체", "#서울", "#부산", "#대구", "#인천", "#광주", "#대전", "#울산", "#세종", "#경기", "#강원",
                  "#충북", "#충남", "#경북", "#경남", "#전북", "#전남", "#제주");
            for (String address : addresses) {
               String activeClass = address.equals("#전체") ? "active" : "";
            %>
            <span class="<%=activeClass%>"
               onclick="filterResults1(this, '<%=address%>')"><%=address%></span>
            <%
            }
            %>
         </div>
         <div class="category">
            <%
            List<String> categories = Arrays.asList("#자연경관", "#문화및역사", "#도시관광", "#레저및액티비티", "#맛집탐방", "#힐링및휴식", "#가족여행", "#로맨틱여행",
                  "#호캉스여행");
            for (String category : categories) {
            %>
            <span onclick="filterResults2(this, '<%=category%>')"><%=category%></span>
            <%
            }
            %>
         </div>
         <div class="mbti">
            <%
            List<String> mbtis = Arrays.asList("#ISTJ", "#ISFJ", "#INFJ", "#INTJ", "#ISTP", "#ISFP", "#INFP", "#INTP", "#ESTP",
                  "#ESFP", "#ENFP", "#ENTP", "#ESTJ", "#ESFJ", "#ENFJ", "#ENTJ");
            for (String mbti : mbtis) {
            %>
            <span onclick="filterResults3(this, '<%=mbti%>')"><%=mbti%></span>
            <%
            }
            %>
         </div>
      </div>

      <!-- 여행 정보 리스트 -->
      <div class="travel-list">
         <span class="black-text">총</span> <span id="total-items" class="blue-text">39,312</span>
         <span class="black-text">건</span>
         <div class="sort-options">
            <a href="#" class="sort-option active" data-sort="latest">최신순</a> |
            <a href="#" class="sort-option" data-sort="popular">인기순</a>
         </div>
         <div class="travel-items">
            <div class="travel-item">
               <img src="" alt="경주 동궁과 월지">
               <div class="travel-details">
                  <h2>경주 동궁과 월지</h2>
                  <p>경북 경주시</p>
                  <p>아름다운 남산의 신라 왕궁 터...</p>
                  <p>#경북 #경부부붑ㄱ</p>
               </div>
            </div>
            <div class="travel-item">
               <img src="" alt="순천만 국가정원">
               <div class="travel-details">
                  <h2>순천만 국가정원</h2>
                  <p>전남 순천시</p>
                  <p>대한민국 1호 국가정원...</p>
                  <p>#경북 #경부부붑ㄱ</p>
               </div>
            </div>
            <div class="travel-item">
               <img src="" alt="카페 석문선배">
               <div class="travel-details">
                  <h2>카페 석문선배</h2>
                  <p>인천 옹진군</p>
                  <p>송봉도의 유일한 카페...</p>
                  <p>#경북 #경부부붑ㄱ</p>
               </div>
            </div>
            <div class="travel-item">
               <img src="" alt="가평 TOP랜드 번지점프">
               <div class="travel-details">
                  <h2>가평 TOP랜드 번지점프</h2>
                  <p>경기 가평군</p>
                  <p>짜릿한 모험을 즐길 수 있는...</p>
                  <p>#경북 #경부부붑ㄱ</p>
               </div>
            </div>
         </div>
      </div>
      <div class="pagination">
         <a href="#" class="prev">&lt;</a> <span class="page-info">1 /
            4</span> <a href="#" class="next">&gt;</a>
      </div>
   </div>
   </div>

   <script>
    function filterResults1(element, tag) {
        if (tag === '#전체') {
            document.querySelectorAll('.hashtags span').forEach(function(span) {
                span.classList.remove('active');
                region = '';
                category = '';
                mbti = '';
            });
        } else { // #전체 active 해제
            document.querySelector('.address span').classList.remove('active');
        }

        element.classList.toggle('active');
        let arr = [];
        document.querySelectorAll('.hashtags .address span.active').forEach(value => {
           arr.push(value.innerText)
        });
        console.log('Selected tags:', arr.join(','));
        region = arr.join(',').replaceAll('#', '');
        currentPage = 1;
        fetchItems(currentSort);
    }
    function filterResults2(element, tag) {
        if (tag === '#전체') {
            document.querySelectorAll('.hashtags span').forEach(function(span) {
                span.classList.remove('active');
                region = '';
                category = '';
                mbti = '';
            });
        } else { // #전체 active 해제
            document.querySelector('.address span').classList.remove('active');
        }

        element.classList.toggle('active');
        let arr = [];
        document.querySelectorAll('.hashtags .category span.active').forEach(value => {
           arr.push(value.innerText)
        });
        console.log('Selected tags:', arr.join(','));
        category = arr.join(',').replaceAll('#', '');
        currentPage = 1;
        fetchItems(currentSort);
    }
    function filterResults3(element, tag) {
        if (tag === '#전체') {
            document.querySelectorAll('.hashtags span').forEach(function(span) {
                span.classList.remove('active');
                region = '';
                category = '';
                mbti = '';
            });
        } else { // #전체 active 해제
            document.querySelector('.address span').classList.remove('active');
        }

        element.classList.toggle('active');
        let arr = [];
        document.querySelectorAll('.hashtags .mbti span.active').forEach(value => {
           arr.push(value.innerText)
        });
        console.log('Selected tags:', arr.join(','));
        mbti = arr.join(',').replaceAll('#', '');
        currentPage = 1;
        fetchItems(currentSort);
    }

    document.addEventListener('DOMContentLoaded', function() {
        filterResults1(document.querySelector('.address span'), '#전체');
    });
    const itemsContainer = document.querySelector('.travel-items');
    const prevButton = document.querySelector('.pagination .prev');
    const nextButton = document.querySelector('.pagination .next');
    const pageInfo = document.querySelector('.pagination .page-info');
    const sortOptions = document.querySelectorAll('.sort-option');
    
    const itemsPerPage = 4;
    let totalItems = 0;
    let totalPages = 0;
    let currentPage = 1;
    let currentSort = 'latest';
    let region = '';
    let category = '';
    let mbti = '';

    function fetchItems(sort) {
        fetch('/TYPE_TRAVELER/RegionInfoCon', {
           method: 'POST',
           headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
           body: 'page='+currentPage+'&region='+region+'&category='+category+'&mbti='+mbti
        })
            .then(response => response.json())
            .then(data => {
               console.log(data);
                totalItems = data.totalItems;
               document.querySelector('#total-items').innerText = totalItems.toLocaleString();
                totalPages = Math.ceil(totalItems / itemsPerPage);
                pageInfo.textContent = currentPage + ' / ' + totalPages;
                updatePagination();
                renderItems(data.items);
            })
            .catch(error => console.error('Error fetching items:', error));
    }

    function renderItems(items) {
        itemsContainer.innerHTML = '';
        items.forEach(item => {
            var itemElement = document.createElement('div');
            itemElement.className = 'travel-item';
            itemElement.innerHTML = 
                '<img src="' + item.region_img + '" alt="' + item.region_title + '">' +
                '<div class="travel-details">' +
                    '<h2>' + item.region_title + '</h2>' +
                    '<p>' + item.region_address + '</p>' +
                    (item.region_info != null ? ('<p>' + item.region_info + '</p>') : '<p>　</p>') +
                    '<p>' + item.keyword + '</p>' +
                '</div>';
            itemsContainer.appendChild(itemElement);
        });
    }

    prevButton.addEventListener('click', (e) => {
        e.preventDefault();
        if (currentPage > 1) {
            currentPage--;
            updatePagination();
            fetchItems(currentSort);
        }
    });

    nextButton.addEventListener('click', (e) => {
        e.preventDefault();
        if (currentPage < totalPages) {
            currentPage++;
            updatePagination();
            fetchItems(currentSort);
        }
    });

    sortOptions.forEach(option => {
        option.addEventListener('click', (e) => {
            e.preventDefault();
            sortOptions.forEach(opt => opt.classList.remove('active'));
            option.classList.add('active');
            currentSort = option.dataset.sort;
            currentPage = 1;
            fetchItems(currentSort);
        });
    });

    function updatePagination() {
        pageInfo.textContent = currentPage + ' / ' + totalPages;
    }

    document.addEventListener('DOMContentLoaded', () => {
        fetchItems(currentSort);
    });
</script>

</body>
</html>
