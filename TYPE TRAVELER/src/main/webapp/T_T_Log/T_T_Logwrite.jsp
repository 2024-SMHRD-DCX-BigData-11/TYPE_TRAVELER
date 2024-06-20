<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TYPE TRAVELER_여행기록 글쓰기</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Main/css/Main_styles.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Log/css/Logwrite_styles.css">
</head>
<body>
   <!-- T_T 상단 배너 -->
    <%@ include file="../T_T_Main/T_T_Main_Banner.jsp" %>
    
    <!-- 여행기록 글쓰기 폼 -->
    <div class="logwrite-container">
        <h1>여행기록 글쓰기</h1>
        <form action="${pageContext.request.contextPath}/TravelLogWriteCon" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <input type="text" name="title" placeholder="제목을 입력해 주세요." required>
                <input type="file" name="file" id="file">
            </div>
            <div class="form-group">
                <textarea name="content" placeholder="내용을 입력하세요." required></textarea>
            </div>
            <div class="form-buttons">
                <button type="button" class="btn-secondary" onclick="window.location.href='T_T_Log.jsp'">목록</button>
                <button type="submit" class="btn-primary">등록</button>
            </div>
        </form>
    </div>
</body>
</html>
