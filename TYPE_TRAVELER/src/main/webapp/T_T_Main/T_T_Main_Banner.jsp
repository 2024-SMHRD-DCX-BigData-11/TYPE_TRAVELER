<%@ page import="com.T_T.model.Member"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>T_T_Main_Banner.jsp</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Main/css/Main_styles.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
    <div class="header">
        <img src="${pageContext.request.contextPath}/T_T_Main/images/로고.png" alt="Logo">
        <ul class="nav-menu">
            <li><a href="${pageContext.request.contextPath}/T_T_Main/T_T_Main.jsp">HOME</a></li>
            <li><a href="${pageContext.request.contextPath}/T_T_Info/T_T_Info.jsp">여행정보</a></li>
            <li><a href="${pageContext.request.contextPath}/T_T_Schedule/T_T_Schedule.jsp">일정관리</a></li>
            <li>
                <a>커뮤니티</a>
                <ul class="submenu">
                    <li><a href="${pageContext.request.contextPath}/T_T_Rec/T_T_Rec.jsp">T_T 모집</a></li>
                    <li><a href="${pageContext.request.contextPath}/T_T_Log/T_T_Log.jsp">여행기록</a></li>
                </ul>
            </li>
	        <c:choose>
	            <c:when test="${empty sessionScope.memberInfo}">
	                <li><a href="javascript:void(0);" onclick="openLoginModal()" id="loginButton">로그인</a></li>
	                <li><a href="javascript:void(0);" onclick="openJoinModal()" id="registerButton">회원가입</a></li>
	            </c:when>
	            <c:otherwise>
	                <li><a href="javascript:void(0);" onclick="openMyPageModal()" id="MypageButton">마이페이지</a></li>
	                <li><a href="${pageContext.request.contextPath}/LogoutCon">로그아웃</a></li>
	            </c:otherwise>
	        </c:choose>
        </ul>
    </div>

<!-- 로그인 모달 -->
<div id="loginModal" style="display: none;">
    <div id="loginContent">
        <div class="login-header">
            <img src="${pageContext.request.contextPath}/T_T_Main/images/로고.png" alt="Logo">
            <span class="close" onclick="closeLoginModal()">&times;</span>
        </div>
        <form id="loginForm" action="${pageContext.request.contextPath}/LoginCon" method="post">
            <input type="text" id="useremail" name="user_email" placeholder="이메일" required>
            <input type="password" id="password" name="user_pw" placeholder="비밀번호" required>
            <div id="errorMessage" class="error-message" style="display: none;">이메일 또는 비밀번호를 잘못 입력했습니다. 입력하신 내용을 다시 확인해주세요.</div>
            <button type="submit" class="login-button">로그인</button>
        </form>
    </div>
</div>

	<script>
	function openLoginModal() {
	    const modal = document.getElementById("loginModal");
	    modal.style.display = "flex";
	    setTimeout(() => {
	        modal.style.transform = "translateY(0)";
	        modal.style.opacity = "1";
	    }, 50);
	}
    
	function closeLoginModal() {
	    const modal = document.getElementById("loginModal");
	    const loginContent = document.getElementById("loginContent");

	    loginContent.style.animation = "modal-slide-down 0.7s ease-out forwards";

	    setTimeout(() => {
	        modal.style.display = "none";
	        resetLoginForm();
	        loginContent.style.animation = ""; // 다음 열릴 때를 위해 애니메이션 초기화
	    }, 700);
	}

	function resetLoginForm() {
	    document.getElementById("loginForm").reset();
	    document.getElementById("errorMessage").style.display = "none";
	}

	function validateLoginForm() {
	    const email = document.getElementById("useremail").value;
	    const password = document.getElementById("password").value;
	    if (email === "" || password === "") {
	        document.getElementById("errorMessage").innerText = "이메일 또는 비밀번호를 입력해주세요.";
	        document.getElementById("errorMessage").style.display = "block";
	        return false;
	    }
	    return true;
	}

	window.onload = function() {
	    const params = new URLSearchParams(window.location.search);
	    if (params.has('loginError')) {
	        document.getElementById("errorMessage").style.display = "block";
	        openLoginModal();
	    }
	};
	
	</script>
	
    <!-- 회원가입 팝업 -->
    <div id="joinModal" style="display: none;">
        <div id="joinContent">
            <div class="join-header">
                <img src="${pageContext.request.contextPath}/T_T_Main/images/로고.png" alt="Logo">
                <span class="close" onclick="closeJoinModal()">&times;</span>
            </div>
            <form id="joinForm" action="${pageContext.request.contextPath}/JoinCon" method="post">
                <label for="joinEmail">이메일</label>
                <div class="input-group">
                    <input type="text" id="inputEmail" name="user_email" placeholder="사용하실 이메일을 입력해 주세요." required>
                    <button type="button" class="check-button" onclick="checkEmail()">중복 확인</button>
                </div>
                <span id="resultCheck" class="message"></span>
                
                <label for="joinPassword">비밀번호</label>
                <input type="password" id="joinPassword" name="user_pw" placeholder="사용하실 비밀번호를 입력해 주세요." required>
               
                <label for="joinName">이름</label>
                <input type="text" id="joinName" name="user_name" placeholder="이름을 입력해 주세요." required>
              
                <label for="joinMBTI">MBTI</label>
                <input type="text" id="joinMBTI" name="user_mbti" placeholder="MBTI를 입력해 주세요." required>
                
                <div class="mbti-link">
                    <span>나의 MBTI를 모른다면? </span>
                    <a href="https://www.16personalities.com/ko/%EB%AC%B4%EB%A3%8C-%EC%84%B1%EA%B2%A9-%EC%9C%A0%ED%98%95-%EA%B2%80%EC%82%AC" target="_blank">검사하기</a>
                </div>
                <button type="submit" class="join-button">가입하기</button>
            </form>
        </div>
    </div>
    
    <!-- 환영 모달 -->
    <div id="welcomeModal" style="display: none;">
        <div id="welcomeContent">
            <div class="welcome-header">
                <img src="${pageContext.request.contextPath}/T_T_Main/images/로고.png" alt="Logo">
            </div>
            <h2>환영합니다!</h2>
            <p id="welcomeMessage">${sessionScope.memberInfo.user_name}님, 회원가입을 축하합니다.<br>가입하신 이메일은 ${sessionScope.memberInfo.user_email} 입니다.</p>
            <p id="additionalMessage">소중한 고객님의 정보를 안전하게 관리하겠습니다.<br>감사합니다.</p>
            <button type="button" onclick="goToMain()">출발하기</button>
        </div>
    </div>
    

<script>
    function openJoinModal() {
        const modal = document.getElementById("joinModal");
        const joinContent = document.getElementById("joinContent");

        modal.style.display = "flex";
        setTimeout(() => {
            joinContent.style.animation = "modal-slide-up 0.7s ease-out forwards";
        }, 50); // 약간의 딜레이 추가
    }

    function closeJoinModal() {
        const modal = document.getElementById("joinModal");
        const joinContent = document.getElementById("joinContent");

        joinContent.style.animation = "modal-slide-down 0.7s ease-out forwards";

        setTimeout(() => {
            modal.style.display = "none";
            joinContent.style.animation = ""; // 다음 열릴 때를 위해 애니메이션 초기화
            document.getElementById('emailError').style.display = 'none'; // 에러 메시지 숨기기
            document.getElementById('emailError').textContent = ''; // 에러 메시지 초기화
            document.getElementById('emailsuccess').style.display = 'none'; // 성공 메시지 숨기기
            document.getElementById('emailsuccess').textContent = ''; // 성공 메시지 초기화
            document.getElementById('joinForm').reset(); // 폼 초기화
        }, 700); // 애니메이션 시간과 동일한 시간 지연
    }

    // 이메일 유효성 검사 함수
    function isValidEmail(email) {
        var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        return emailRegex.test(email);
    }

    function checkEmail() {
        var inputEmail = $('#inputEmail').val();

        if (!isValidEmail(inputEmail)) {
            $('#resultCheck').text('유효하지 않은 이메일 형식입니다.').css('color', 'red');
            return;
        }

        $.ajax({
            url: '${pageContext.request.contextPath}/EmailCheckCon',
            data: { 'inputEmail': inputEmail },
            type: 'get',
            success: function (response) {
                if (response) {
                    $('#resultCheck').text('이미 사용 중인 이메일입니다.').css('color', 'red');
                } else {
                    $('#resultCheck').text('사용 가능한 이메일입니다.').css('color', 'green');
                }
            },
            error: function () {
                alert('이메일 중복 확인 과정에서 오류가 발생했습니다.');
            }
        });
    }

    // 회원가입 폼 유효성 검사
    function validateJoinForm() {
        var userEmail = $('#inputEmail').val();
        var userPw = $('#joinPassword').val();
        var userName = $('#joinName').val();
        var userMbti = $('#joinMBTI').val();

        if (!isValidEmail(userEmail)) {
            alert('유효하지 않은 이메일 형식입니다.');
            return false;
        }

        // 추가적인 폼 유효성 검사 로직 추가 가능

        return true;
    }

    // 회원가입 버튼 클릭 시 처리
    $('#joinForm').submit(function(event) {
        event.preventDefault(); // 기본 동작 방지
        if (validateJoinForm()) {
            this.submit(); // 유효성 검사 통과 시 폼 제출
        }
    });

    // 모달이 열릴 때마다 초기화
    $('#joinModal').on('show.bs.modal', function() {
        $('#emailError').hide().text('');
        $('#emailsuccess').hide().text('');
        $('#joinForm')[0].reset();
    });

    // 환영 팝업으로 이동
    function goToMain() {
        window.location.href = '${pageContext.request.contextPath}/T_T_Main/T_T_Main.jsp';
    }
</script>

		<!-- 마이페이지 모달 -->
		<div id="myPageModal" style="display: none;">
		    <div id="myPageContent">
		        <div class="profile-header">
		            <img src="${pageContext.request.contextPath}/T_T_Main/images/로고.png" alt="Logo">
		            <span class="close" onclick="closeMyPageModal()">&times;</span>
		        </div>
		        <h2>프로필</h2>
		        <p id="userEmail"></p>
		        <p id="userEmail">${sessionScope.memberInfo.user_email}</p>
		        <form id="profileForm" action="${pageContext.request.contextPath}/UpdateCon" method="post" onsubmit="return validatePassword()">
		            <label for="currentPassword">현재 비밀번호</label>
		            <input type="password" id="currentPassword" name="currentPassword" placeholder="현재 비밀번호" required>
		            <div id="passwordErrorMessage" class="password-error-message" style="display: none; color: red; font-weight: bold; margin-bottom: 10px;">비밀번호를 정확하게 입력해 주세요.</div>
		            
		            <label for="newPassword">변경할 비밀번호</label>
		            <input type="password" id="newPassword" name="newPassword" placeholder="변경할 비밀번호">
		            
		            <label for="user_name">이름</label>
		            <input type="text" id="user_name" name="user_name" value="${sessionScope.memberInfo.user_name}" required> <!-- 세션에서 사용자 이름 가져오기 -->
		            
		            <label for="user_mbti">MBTI</label>
		            <input type="text" id="user_mbti" name="user_mbti" value="${sessionScope.memberInfo.user_mbti}" required> <!-- 세션에서 사용자 MBTI 가져오기 -->
		            
		            <button type="submit" class="update-button">프로필 수정</button>
		        </form>
		    </div>
		</div>



    <script>
    	// 마이페이지 모달 열기 함수
        function openMyPageModal() {
		    const username = sessionStorage.getItem('username');
		    document.querySelector('#myPageModal #userEmail').innerText = username;
		    const modal = document.getElementById('myPageModal');
		    modal.style.display = 'flex';
		    setTimeout(() => {
		        modal.querySelector('#myPageContent').classList.add('slide-up');
		    }, 50); // 약간의 지연 후 애니메이션 시작
		}

		// 마이페이지 모달 닫기 및 폼 초기화
		function closeMyPageModal() {
		    const modal = document.getElementById('myPageModal');
		    const content = modal.querySelector('#myPageContent');
		    content.classList.remove('slide-up');
		    content.classList.add('slide-down');
		    setTimeout(() => {
		        modal.style.display = 'none';
		        content.classList.remove('slide-down');
		        document.getElementById('profileForm').reset(); // 폼 초기화
		        document.getElementById('passwordErrorMessage').style.display = 'none'; // 에러 메시지 숨기기
		    }, 700); // 애니메이션 지속 시간과 일치
		}

		
		// 비밀번호 유효성 검사
	    function validatePassword() {
	        const currentPassword = document.getElementById('currentPassword').value;
	        // 실제 구현에서는 서버에서 비밀번호를 확인해야 함
	        // 예시: storedPassword는 서버에서 가져온 값
	        // const storedPassword = '123';
	        // if (currentPassword !== storedPassword) {
	        //     document.getElementById('passwordErrorMessage').style.display = 'block';
	        //     return false; // 폼 제출을 막음
	        // }
	        return true; // 폼 제출을 허용
	    }

	 // 프로필 수정 처리
	    async function updateProfile(event) {
	        event.preventDefault(); // 폼 제출 방지

	        const currentPassword = document.getElementById('currentPassword').value;
	        const newPassword = document.getElementById('newPassword').value;
	        const user_name = document.getElementById('user_name').value;
	        let user_mbti = document.getElementById('user_mbti').value.trim().toUpperCase(); // 입력값을 대문자로 변환하고 공백 제거

	        // MBTI 유효성 검사: 4글자여야 하고, 대문자 알파벳만 허용
	        const mbtiPattern = /^[A-Z]{4}$/; // 대문자 알파벳 4글자

	        if (!mbtiPattern.test(user_mbti)) {
	            alert('올바른 MBTI 유형을 입력하세요.'); // 사용자에게 알림
	            return; // 함수 종료
	        }

	        // 서버 사이드 URL 설정
	        const updateUrl = '/T_T_Main/UpdateCon'; // 실제 서버 사이드에서 처리될 URL

	        const response = await fetch(updateUrl, {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/x-www-form-urlencoded'
	            },
	            body: new URLSearchParams({
	                currentPassword: currentPassword,
	                newPassword: newPassword,
	                user_name: user_name,
	                user_mbti: user_mbti
	            })
	        });

	        const result = await response.json();

	        if (result.success) {
	            // 수정 성공 시 메인 페이지로 리디렉션
	            window.location.href = '/T_T_Main/T_T_Main.jsp';
	        } else {
	            // 실패 시 에러 메시지 표시
	            document.getElementById('passwordErrorMessage').style.display = 'block';
	        }
	    }


	</script>
	
</body>
</html>
