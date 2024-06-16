<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                <span onclick="filterResults('#전체')">#전체</span>
                <span onclick="filterResults('#서울')">#서울</span>
                <span onclick="filterResults('#부산')">#부산</span>
                <span onclick="filterResults('#대구')">#대구</span>
                <span onclick="filterResults('#인천')">#인천</span>
                <span onclick="filterResults('#광주')">#광주</span>
                <span onclick="filterResults('#대전')">#대전</span>
                <span onclick="filterResults('#울산')">#울산</span>
                <span onclick="filterResults('#세종')">#세종</span>
                <span onclick="filterResults('#경기')">#경기</span>
                <span onclick="filterResults('#강원')">#강원</span>
                <span onclick="filterResults('#충북')">#충북</span>
                <span onclick="filterResults('#충남')">#충남</span>
                <span onclick="filterResults('#경북')">#경북</span>
                <span onclick="filterResults('#경남')">#경남</span>
                <span onclick="filterResults('#전북')">#전북</span>
                <span onclick="filterResults('#전남')">#전남</span>
                <span onclick="filterResults('#제주')">#제주</span>
            </div>
            <div class="category">
                <span onclick="filterResults('#자연경관')">#자연경관</span>
                <span onclick="filterResults('#문화및역사')">#문화및역사</span>
                <span onclick="filterResults('#도시관광')">#도시관광</span>
                <span onclick="filterResults('#레저및액티비티')">#레저및액티비티</span>
                <span onclick="filterResults('#맛집탐방')">#맛집탐방</span>
                <span onclick="filterResults('#힐링및휴식')">#힐링및휴식</span>
                <span onclick="filterResults('#가족여행')">#가족여행</span>
                <span onclick="filterResults('#로맨틱여행')">#로맨틱여행</span>
                <span onclick="filterResults('#호캉스여행')">#호캉스여행</span>
            </div>
            <div class="mbti">
                <span onclick="filterResults('#ISTJ')">#ISTJ</span>
                <span onclick="filterResults('#ISFJ')">#ISFJ</span>
                <span onclick="filterResults('#INFJ')">#INFJ</span>
                <span onclick="filterResults('#INTJ')">#INTJ</span>
                <span onclick="filterResults('#ISTP')">#ISTP</span>
                <span onclick="filterResults('#ISFP')">#ISFP</span>
                <span onclick="filterResults('#INFP')">#INFP</span>
                <span onclick="filterResults('#INTP')">#INTP</span>
                <span onclick="filterResults('#ESTP')">#ESTP</span>
                <span onclick="filterResults('#ESFP')">#ESFP</span>
                <span onclick="filterResults('#ENFP')">#ENFP</span>
                <span onclick="filterResults('#ENTP')">#ENTP</span>
                <span onclick="filterResults('#ESTJ')">#ESTJ</span>
                <span onclick="filterResults('#ESFJ')">#ESFJ</span>
                <span onclick="filterResults('#ENFJ')">#ENFJ</span>
                <span onclick="filterResults('#ENTJ')">#ENTJ</span>
            </div>
        </div>

        <!-- 여행 정보 리스트 -->
        <div class="travel-list">
            <div class="total-count">총 39,312건</div>
            <div class="sort-options">
                <span>최신순</span> | <span>인기순</span>
            </div>
            <div class="travel-items">
                <div class="travel-item">
                    <img src="경주_동궁과_월지.jpg" alt="경주 동궁과 월지">
                    <div class="travel-details">
                        <h2>경주 동궁과 월지</h2>
                        <p>경북 경주시</p>
                        <p>아름다운 남산의 신라 왕궁 터...</p>
                    </div>
                </div>
                <div class="travel-item">
                    <img src="순천만_국가정원.jpg" alt="순천만 국가정원">
                    <div class="travel-details">
                        <h2>순천만 국가정원</h2>
                        <p>전남 순천시</p>
                        <p>대한민국 1호 국가정원...</p>
                    </div>
                </div>
                <div class="travel-item">
                    <img src="카페_석문선배.jpg" alt="카페 석문선배">
                    <div class="travel-details">
                        <h2>카페 석문선배</h2>
                        <p>인천 옹진군</p>
                        <p>송봉도의 유일한 카페...</p>
                    </div>
                </div>
                <div class="travel-item">
                    <img src="가평_TOP랜드_번지점프.jpg" alt="가평 TOP랜드 번지점프">
                    <div class="travel-details">
                        <h2>가평 TOP랜드 번지점프</h2>
                        <p>경기 가평군</p>
                        <p>짜릿한 모험을 즐길 수 있는...</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</body>
</html>
