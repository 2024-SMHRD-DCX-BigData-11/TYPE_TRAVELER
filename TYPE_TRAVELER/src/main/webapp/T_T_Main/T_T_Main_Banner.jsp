<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>T_T_Main_Banner.jsp</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Main/css/styles.css">
    <script type="text/javascript">
        // Function to open the modal
        function openLoginModal() {
            document.getElementById("loginModal").style.display = "flex";
        }

        // Function to close the modal
        function closeLoginModal() {
            document.getElementById("loginModal").style.display = "none";
        }

        // Close the modal if user clicks outside of it
        window.onclick = function(event) {
            var modal = document.getElementById("loginModal");
            if (event.target == modal) {
                closeLoginModal();
            }
        }

        // Function to display error message
        function displayErrorMessage(message) {
            var errorMessage = document.getElementById("errorMessage");
            errorMessage.innerText = message;
            errorMessage.style.display = "block";
        }

        // Mock form submission for demonstration purposes
        function submitForm(event) {
            event.preventDefault(); // Prevent form submission

            var email = document.getElementById("useremail").value;
            var password = document.getElementById("password").value;

            // Check if email or password is empty (you can replace this with actual validation)
            if (email !== "opo226@naver.com" || password !== "123") {
        		displayErrorMessage("이메일 또는 비밀번호를 잘못 입력했습니다. 입력하신 내용을 다시 확인해주세요.");
    		} else {
        	// Perform actual form submission here
        event.target.submit();
            }
        }
    </script>
</head>
<body>
    <div class="header">
        <img src="${pageContext.request.contextPath}/T_T_Main/images/로고.png" alt="Logo">
        <ul class="nav-menu">
            <li><a href="${pageContext.request.contextPath}/T_T_Main/T_T_Main.jsp">HOME</a></li>
            <li><a href="${pageContext.request.contextPath}/T_T_Main/Info.jsp">여행정보</a></li>
            <li><a href="${pageContext.request.contextPath}/T_T_Schedule/T_T_Schedule.jsp">일정관리</a></li>
            <li>
                <a>커뮤니티</a>
                <ul class="submenu">
                    <li><a href="#">T_T 모집</a></li>
                    <li><a href="#">여행기록</a></li>
                </ul>
            </li>
            <li><a href="javascript:void(0);" onclick="openLoginModal()">로그인</a></li>
            <li><a href="${pageContext.request.contextPath}/T_T_Main/Join.jsp">회원가입</a></li>
        </ul>
    </div>

    <!-- 로그인 팝업 -->
    <div id="loginModal" style="display: none;">
        <div id="loginContent">
            <div class="login-header">
                <img src="${pageContext.request.contextPath}/T_T_Main/images/로고.png" alt="Logo">
                <span class="close" onclick="closeLoginModal()">&times;</span>
            </div>
            <form action="T_T_Main.jsp" method="post" onsubmit="submitForm(event)">
                <input type="text" id="useremail" name="useremail" placeholder="이메일" required>
                <input type="password" id="password" name="password" placeholder="비밀번호" required>
                <div id="errorMessage" class="error-message" style="display: none;"></div>
                <button type="submit" class="login-button">로그인</button>
            </form>
        </div>
    </div>
    
    <!-- 회원가입 팝업 -->
    <div id="joinModal" style="display: none;">
        <div id="loginContent">
            <div class="login-header">
                <img src="${pageContext.request.contextPath}/T_T_Main/images/로고.png" alt="Logo">
                <span class="close" onclick="closeLoginModal()">&times;</span>
            </div>
            <form action="T_T_Main.jsp" method="post" onsubmit="submitForm(event)">
                <input type="text" id="useremail" name="useremail" placeholder="이메일" required>
                <input type="password" id="password" name="password" placeholder="비밀번호" required>
                <div id="errorMessage" class="error-message" style="display: none;"></div>
                <button type="submit" class="login-button">로그인</button>
            </form>
        </div>
    </div>
    
</body>
</html>
