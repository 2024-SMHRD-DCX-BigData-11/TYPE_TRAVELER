<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Arrays" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TYPE TRAVELER_여행정보</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Main/css/Main_styles.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Info/css/Info_styles.css">
</head>
<body>
    <!-- T_T 상단 배너 -->
    <%@ include file="../T_T_Main/T_T_Main_Banner.jsp" %>

    <!-- 여행 정보 콘텐츠 -->
    <div class="travel-info">
        <h1>#여행정보</h1>
        
        <!-- 해시태그 영역 -->
        <div class="hashtags">
            <div class="address">
                <%
                    // 데이터베이스에서 해시태그 목록을 가져오는 예시
                    List<String> addresses = Arrays.asList("#전체", "#서울", "#부산", "#대구", "#인천", "#광주", "#대전", "#울산", "#세종", "#경기", "#강원", "#충북", "#충남", "#경북", "#경남", "#전북", "#전남", "#제주");
                    for(String address : addresses) {
                        String activeClass = address.equals("#전체") ? "active" : "";
                %>
                <span class="<%= activeClass %>" onclick="filterResults(this, '<%= address %>')"><%= address %></span>
                <%
                    }
                %>
            </div>
            <div class="category">
                <%
                    // 데이터베이스에서 카테고리 목록을 가져오는 예시
                    List<String> categories = Arrays.asList("#자연경관", "#문화및역사", "#도시관광", "#레저및액티비티", "#맛집탐방", "#힐링및휴식", "#가족여행", "#로맨틱여행", "#호캉스여행");
                    for(String category : categories) {
                %>
                <span onclick="filterResults(this, '<%= category %>')"><%= category %></span>
                <%
                    }
                %>
            </div>
            <div class="mbti">
                <%
                    // 데이터베이스에서 MBTI 목록을 가져오는 예시
                    List<String> mbtis = Arrays.asList("#ISTJ", "#ISFJ", "#INFJ", "#INTJ", "#ISTP", "#ISFP", "#INFP", "#INTP", "#ESTP", "#ESFP", "#ENFP", "#ENTP", "#ESTJ", "#ESFJ", "#ENFJ", "#ENTJ");
                    for(String mbti : mbtis) {
                %>
                <span onclick="filterResults(this, '<%= mbti %>')"><%= mbti %></span>
                <%
                    }
                %>
            </div>
        </div>

        <!-- 여행 정보 리스트 -->
        <div class="travel-list">
            <span class="black-text">총</span>
            <span class="blue-text">39,312</span>
            <span class="black-text">건</span>
            <div class="sort-options">
                <a href="#" class="sort-option active" data-sort="latest"n>최신순</a> |
                <a href="#" class="sort-option" data-sort="popular">인기순</a>
            </div>
            <div class="travel-items">
                <div class="travel-item">
                    <img src="경주_동궁과_월지.jpg" alt="경주 동궁과 월지">
                    <div class="travel-details">
                        <h2>경주 동궁과 월지</h2>
                        <p>경북 경주시</p>
                        <p>아름다운 남산의 신라 왕궁 터...</p>
                        <p>#경북 #경부부붑ㄱ</p>
                    </div>
                </div>
                <div class="travel-item">
                    <img src="순천만_국가정원.jpg" alt="순천만 국가정원">
                    <div class="travel-details">
                        <h2>순천만 국가정원</h2>
                        <p>전남 순천시</p>
                        <p>대한민국 1호 국가정원...</p>
                        <p>#경북 #경부부붑ㄱ</p>
                    </div>
                </div>
                <div class="travel-item">
                    <img src="카페_석문선배.jpg" alt="카페 석문선배">
                    <div class="travel-details">
                        <h2>카페 석문선배</h2>
                        <p>인천 옹진군</p>
                        <p>송봉도의 유일한 카페...</p>
                        <p>#경북 #경부부붑ㄱ</p>
                    </div>
                </div>
                <div class="travel-item">
                    <img src="가평_TOP랜드_번지점프.jpg" alt="가평 TOP랜드 번지점프">
                    <div class="travel-details">
                        <h2>가평 TOP랜드 번지점프</h2>
                        <p>경기 가평군</p>
                        <p>짜릿한 모험을 즐길 수 있는...</p>
                        <p>#경북 #경부부붑ㄱ</p>
                    </div>
                </div>
            </div>
            <div class="pagination">
			    <a href="#" class="prev">&lt;</a>
			    <span class="page-info">1 / 4</span> <!-- 현재 페이지와 총 페이지 수 -->
			    <a href="#" class="next">&gt;</a>
			</div>
        </div>
    </div>
    
<script>
    // JavaScript 함수
    function filterResults(element, tag) {
        // 클릭한 해시태그가 "#전체"인 경우 모든 해시태그의 active 클래스 제거
        if (tag === '#전체') {
            document.querySelectorAll('.hashtags span').forEach(function(span) {
                span.classList.remove('active');
            });
        } else {
            // "#전체"가 아닌 다른 해시태그를 클릭한 경우 "#전체" 해시태그의 active 클래스 제거
            document.querySelector('.address span').classList.remove('active');
        }

        // 클릭한 해시태그의 active 클래스 상태를 토글 (추가/제거)
        element.classList.toggle('active');
        
        // 선택된 태그에 따라 여행 정보를 필터링하는 로직 추가
        console.log('Selected tag:', tag);

        // 여기서 필터링 로직을 추가하면 됩니다.
        // 예를 들어, 선택된 모든 active 해시태그를 반복하여 필터링할 수 있습니다.
    }

    // 페이지 로드 시 기본 해시태그 설정
    document.addEventListener('DOMContentLoaded', function() {
        // 기본 설정: "#전체" 해시태그 선택
        filterResults(document.querySelector('.address span'), '#전체');
    });
    
    
    
    
    document.addEventListener('DOMContentLoaded', () => {
        const itemsContainer = document.querySelector('.travel-items');
        const prevButton = document.querySelector('.pagination .prev');
        const nextButton = document.querySelector('.pagination .next');
        const pageInfo = document.querySelector('.pagination .page-info');
        const sortOptions = document.querySelectorAll('.sort-option');
        
        const itemsPerPage = 4;
        let totalItems = 0;
        let totalPages = 0;
        let currentPage = 1;
        let currentSort = 'latest'; // Default sort is latest

        // 서버에서 총 아이템 수 가져오기 (AJAX 예시)
        function fetchItems(sort) {
            fetch(`/path/to/your/api/endpoint?sort=${sort}`) // 여기에 실제 API 엔드포인트를 입력하세요
                .then(response => response.json())
                .then(data => {
                    totalItems = data.totalItems; // 서버에서 총 아이템 수를 반환
                    totalPages = Math.ceil(totalItems / itemsPerPage);
                    pageInfo.textContent = `${currentPage} / ${totalPages}`;
                    updatePagination();
                    renderItems(data.items); // 서버에서 받은 아이템들 렌더링
                })
                .catch(error => console.error('Error fetching items:', error));
        }

        function renderItems(items) {
            itemsContainer.innerHTML = '';
            items.forEach(item => {
                const itemElement = document.createElement('div');
                itemElement.className = 'travel-item';
                itemElement.innerHTML = `
                    <img src="${item.image}" alt="${item.title}">
                    <div class="travel-details">
                        <h2>${item.title}</h2>
                        <p>${item.location}</p>
                        <p>${item.description}</p>
                    </div>
                `;
                itemsContainer.appendChild(itemElement);
            });
        }

        prevButton.addEventListener('click', (e) => {
            e.preventDefault();
            if (currentPage > 1) {
                currentPage--;
                updatePagination();
            }
        });

        nextButton.addEventListener('click', (e) => {
            e.preventDefault();
            if (currentPage < totalPages) {
                currentPage++;
                updatePagination();
            }
        });

        sortOptions.forEach(option => {
            option.addEventListener('click', (e) => {
                e.preventDefault();
                sortOptions.forEach(opt => opt.classList.remove('active'));
                option.classList.add('active');
                currentSort = option.dataset.sort;
                currentPage = 1; // Reset to first page on sort change
                fetchItems(currentSort);
            });
        });

        function updatePagination() {
            const offset = (currentPage - 1) * 100;
            itemsContainer.style.transform = `translateX(-${offset}%)`;
            pageInfo.textContent = `${currentPage} / ${totalPages}`;
        }

        // Initialize with the default sort
        fetchItems(currentSort);
    });

</script>

    
</body>
</html>
