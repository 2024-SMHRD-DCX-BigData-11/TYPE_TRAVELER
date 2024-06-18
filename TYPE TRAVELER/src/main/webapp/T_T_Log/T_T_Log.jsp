<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>여행기록</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Main/css/Main_styles.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Log/css/Log_styles.css">
</head>
<body>

    <!-- T_T 상단 배너 -->
    <%@ include file="../T_T_Main/T_T_Main_Banner.jsp" %>
    
    <div class="container">
        <div class="sidebar">
            <a href="#">커뮤니티</a>
            <a href="${pageContext.request.contextPath}/T_T_Rec/T_T_Rec.jsp">ㄴ T_T 모집</a>
            <a href="${pageContext.request.contextPath}/T_T_Log/T_T_Log.jsp">ㄴ 여행기록</a>
        </div>
        <div class="content">
            <div class="search-bar">
                <select>
                    <option>제목</option>
                </select>
                <input type="text" placeholder="검색어를 입력하세요.">
                <button>검색</button>
            </div>
            <div class="posts">
                <div class="post">
                    <img src="path/to/image1.jpg" alt="Post Image">
                    <div class="post-content">
                        <h3>#가족여행</h3>
                        <p>ISFJ | 장희중</p>
                        <p>24.06.05.</p>
                        <p>가족들과 함께 처음 여행...</p>
                    </div>
                </div>
                <div class="post">
                    <img src="path/to/image2.jpg" alt="Post Image">
                    <div class="post-content">
                        <h3>#혼로 첫 여행기</h3>
                        <p>ENFP | 김용민</p>
                        <p>24.06.03.</p>
                        <p>혼자 여행을 다녀왔...</p>
                    </div>
                </div>
                <div class="post">
                    <img src="path/to/image3.jpg" alt="Post Image">
                    <div class="post-content">
                        <h3>#행복했던 기억</h3>
                        <p>ESTJ | 최석주</p>
                        <p>24.06.02.</p>
                        <p>친구들이랑 처음 여행...</p>
                    </div>
                </div>
            </div>
            <div class="pagination">
                <a href="#">&laquo;</a>
                <a href="#">1</a>
                <a href="#">2</a>
                <a href="#">3</a>
                <a href="#">&raquo;</a>
                <button class="write-button" onclick="window.location.href='T_T_Logwrite.jsp'">✏️기록하기</button>
            </div>
        </div>
    </div>
</body>
</html>
