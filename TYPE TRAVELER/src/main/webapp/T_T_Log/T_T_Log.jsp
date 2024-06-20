<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TYPE TRAVELER_여행기록</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Main/css/Main_styles.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Log/css/Log_styles.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    
<style>
.login-message {
    display: flex;
    justify-content: flex-end;
    margin-right: 20px;
}
.login-message p {
    color: #0fb0ff;
    margin-left: auto;
}
</style>

</head>
<body>
   <!-- T_T 상단 배너 -->
    <%@ include file="../T_T_Main/T_T_Main_Banner.jsp" %>
    <div class="log-container">
    <h1>#여행기록</h1>
    <div class="search-bar">
        <select id="searchCategory">
            <option value="title">제목</option>
            <option value="mbti">MBTI</option>
            <option value="author">작성자</option>
        </select>
        <input type="text" id="search" placeholder="검색어를 입력하세요.">
        <button id="search-btn" class="search-button">검색</button>
    </div>

        <div class="container">
            <div class="sidebar">
                <div class="menu-title">커뮤니티</div>
                <ul class="menu-list">
                    <li id="recruitment" class="menu-item">ㄴ T_T 모집</li>
                    <li id="travel-record" class="menu-item active">ㄴ 여행기록</li>
                </ul>
            </div>

            <div class="post-container">
                <!-- 디버깅 로그 추가 -->
                <c:if test="${not empty travelLogs}">
                    <c:forEach var="log" items="${travelLogs}">
                        <div class="post">
                            <img src="${log.tlog_img}" alt="여행 사진">
                            <div class="post-content">
                                <h2>${log.tlog_title}</h2>
                                <p class="limited-content">${log.tlog_content}</p>
                                <p class="author">${log.user_mbti} | ${log.user_name}</p>
                                <p class="date">${log.created_at}</p>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${empty travelLogs}">
                    <p>No travel logs found.</p>
                </c:if>
            </div>
        </div>

      <div class="pagination">
          <a href="${pageContext.request.contextPath}/TravelLogCon?search=${search}&type=${type}&page=${currentPage-1}" class="prev">&lt;</a>
          <span class="page-log">${currentPage} / ${totalPages}</span>
          <a href="${pageContext.request.contextPath}/TravelLogCon?search=${search}&type=${type}&page=${currentPage+1}" class="next">&gt;</a>
      </div>

        
    <!-- 기록하기 버튼 -->
    <%
        if (session != null && session.getAttribute("memberInfo") != null) {
    %>
        <a href="T_T_Log/T_T_Logwrite.jsp">
            <button class="write-button">✏️기록하기</button>
        </a>
    <%
        } else {
    %>
        <div class="login-message">
          <p>로그인 후 기록하기 기능을 사용할 수 있습니다.</p>
      </div>
    <%
        }
    %>
    </div>
    <script>
       document.getElementById('search-btn').addEventListener('click', function() {
          window.location.href = '${pageContext.request.contextPath}/TravelLogCon?search=' + document.getElementById('search').value + '&type=' + document.getElementById('searchCategory').value; // 여행기록 페이지로 이동
       });
    
        document.getElementById('recruitment').addEventListener('click', function() {
               swal("❗T_T 모집은 구현 예정입니다❗");
        });

        document.getElementById('travel-record').addEventListener('click', function() {
           window.location.href = '${pageContext.request.contextPath}/TravelLogCon'; // 여행기록 페이지로 이동
        });
    </script>
</body>
</html>
