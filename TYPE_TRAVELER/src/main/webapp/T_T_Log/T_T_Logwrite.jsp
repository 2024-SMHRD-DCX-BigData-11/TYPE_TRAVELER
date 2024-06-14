<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>여행기록 글쓰기</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Main/css/Main_styles.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Log/css/Logwrite_styles.css">
    <style>
        .file-label {
            display: flex;
            align-items: center;
        }

        .file-label input[type="file"] {
            display: none;
        }

        .file-select-button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #2196F3;
            color: white;
            border: none;
            cursor: pointer;
            margin-left: 10px;
        }

        .file-name {
            margin-left: 10px;
            color: #888;
        }
    </style>
</head>
<body>
    <!-- T_T 상단 배너 -->
    <%@ include file="../T_T_Main/T_T_Main_Banner.jsp" %>

    <div class="header">
        <h1>여행기록 글쓰기</h1>
    </div>
    <div class="container">
        <form action="T_T_Logwrite_submit.jsp" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" style="width: calc(100% - 160px); display: inline-block;">
                <div class="file-label">
                    <label class="file-select-button" for="file">파일 선택</label>
                    <input type="file" id="file" name="file" onchange="updateFileName()">
                    <span id="file-name" class="file-name">선택된 파일 없음</span>
                </div>
            </div>
            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="content" name="content"></textarea>
            </div>
            <div class="button-group">
                <button type="button" onclick="window.location.href='T_T_Log.jsp'">목록</button>
                <button type="submit">등록</button>
            </div>
        </form>
    </div>
    <script>
        function updateFileName() {
            const fileInput = document.getElementById('file');
            const fileNameDisplay = document.getElementById('file-name');
            fileNameDisplay.textContent = fileInput.files.length > 0 ? fileInput.files[0].name : '선택된 파일 없음';
        }
    </script>
</body>
</html>
