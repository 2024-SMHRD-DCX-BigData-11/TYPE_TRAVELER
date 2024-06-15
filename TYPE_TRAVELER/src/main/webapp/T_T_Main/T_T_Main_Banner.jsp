<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>T_T_Main_Banner.jsp</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Main/css/Main_styles.css">
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
            <li><a href="javascript:void(0);" onclick="openLoginModal()" id="loginButton">로그인</a></li>
            <li><a href="javascript:void(0);" onclick="openJoinModal()" id="registerButton">회원가입</a></li>
        </ul>
    </div>

    <!-- 로그인 팝업 -->
    <div id="loginModal" style="display: none;">
        <div id="loginContent">
            <div class="login-header">
                <img src="${pageContext.request.contextPath}/T_T_Main/images/로고.png" alt="Logo">
                <span class="close" onclick="closeLoginModal()">&times;</span>
            </div>
            <form id="loginForm" action="T_T_Main.jsp" method="post" onsubmit="submitForm(event)">
                <input type="text" id="useremail" name="useremail" placeholder="이메일" required>
                <input type="password" id="password" name="password" placeholder="비밀번호" required>
                <div id="errorMessage" class="error-message" style="display: none;"></div>
                <button type="submit" class="login-button">로그인</button>
            </form>
        </div>
    </div>
  
    <!-- 로그인 팝업 script -->
    <script>
        function openLoginModal() {
            document.getElementById("loginModal").style.display = "flex";
        }

        // 로그인 팝업 닫기 및 폼 초기화
        function closeLoginModal() {
            document.getElementById("loginModal").style.display = "none";
            resetLoginForm();
        }

        // 로그인 폼 초기화
        function resetLoginForm() {
            document.getElementById("loginForm").reset();
            document.getElementById("errorMessage").style.display = "none";
        }

        // 오류 메시지 표시
        function displayErrorMessage(message) {
            var errorMessage = document.getElementById("errorMessage");
            errorMessage.innerText = message;
            errorMessage.style.display = "block";
        }

        // 폼 제출 처리 (예시용)
        function submitForm(event) {
            event.preventDefault(); // 폼 제출 방지

            var email = document.getElementById("useremail").value;
            var password = document.getElementById("password").value;

            // 이메일과 비밀번호 확인 (예시용)
            if (email !== "opo226@naver.com" || password !== "123") {
                displayErrorMessage("이메일 또는 비밀번호를 잘못 입력했습니다. 입력하신 내용을 다시 확인해주세요.");
            } else {
                // 로그인 성공 시 세션에 로그인 상태 저장
                sessionStorage.setItem('isLoggedIn', 'true');
                sessionStorage.setItem('username', email); // 사용자 이름 저장
                // 페이지 로드 시 로그인 상태 확인 및 배너 업데이트
                updateBanner(); 
                closeLoginModal();
            }
        }

        // 페이지 로드 시 로그인 상태 확인 및 배너 업데이트
        function updateBanner() {
            const isLoggedIn = sessionStorage.getItem('isLoggedIn');
            const username = sessionStorage.getItem('username');

            if (isLoggedIn === 'true') {
                document.getElementById('loginButton').textContent = '마이페이지';
                document.getElementById('loginButton').href = 'javascript:void(0);';
                document.getElementById('loginButton').onclick = openMyPageModal;
                document.getElementById('registerButton').textContent = '로그아웃';
                document.getElementById('registerButton').href = '#';
                document.getElementById('registerButton').onclick = logout; // 로그아웃 함수 연결
            }
        }

        // 로그아웃 함수
        function logout() {
            // 세션에서 로그인 상태 제거
            sessionStorage.removeItem('isLoggedIn');
            sessionStorage.removeItem('username');
            // 메인 페이지로 이동
            window.location.href = '${pageContext.request.contextPath}/T_T_Main/T_T_Main.jsp';
        }

        // 페이지 로드 시 배너 업데이트 함수 호출
        window.onload = updateBanner;
    </script>

    <!-- 회원가입 팝업 -->
    <div id="joinModal" style="display: none;">
        <div id="joinContent">
            <div class="join-header">
                <img src="${pageContext.request.contextPath}/T_T_Main/images/로고.png" alt="Logo">
                <span class="close" onclick="closeJoinModal()">&times;</span>
            </div>
            <form id="joinForm">
                <label for="joinEmail">이메일</label>
                <div class="input-group">
                    <input type="text" id="joinEmail" name="email" placeholder="사용하실 이메일을 입력해 주세요." required>
                    <button type="button" class="check-button" onclick="checkEmail()">중복 확인</button>
                </div>
                <span class="success-message" id="emailsuccess"></span>
                <span class="error-message" id="emailError"></span>
                
                <label for="joinPassword">비밀번호</label>
                <input type="password" id="joinPassword" name="password" placeholder="사용하실 비밀번호를 입력해 주세요." required>
               
                <label for="joinName">이름</label>
                <input type="text" id="joinName" name="name" placeholder="이름을 입력해 주세요." required>
              
                <label for="joinMBTI">MBTI</label>
                <input type="text" id="joinMBTI" name="mbti" placeholder="MBTI를 입력해 주세요." required>
                
                <div class="mbti-link">
                    <span>나의 MBTI를 모른다면? </span>
                    <a href="https://www.16personalities.com/ko/%EB%AC%B4%EB%A3%8C-%EC%84%B1%EA%B2%A9-%EC%9C%A0%ED%98%95-%EA%B2%80%EC%82%AC" target="_blank">검사하기</a>
                </div>
                <button type="button" class="join-button" onclick="submitJoinForm()">가입하기</button>
            </form>
        </div>
    </div>
  
		<!-- 회원가입 script -->
		<script>
		    function openJoinModal() {
		        document.getElementById('joinModal').style.display = 'flex';
		    }
		    
		    function closeJoinModal() {
		        document.getElementById('joinModal').style.display = 'none';
		        document.getElementById('emailError').style.display = 'none'; // 에러 메시지 숨기기
		        document.getElementById('emailError').textContent = ''; // 에러 메시지 초기화
		        document.getElementById('emailsuccess').style.display = 'none'; // 성공 메시지 숨기기
		        document.getElementById('emailsuccess').textContent = ''; // 성공 메시지 초기화
		        document.getElementById('joinForm').reset(); // 폼 초기화
		    }
		    
		    // 이메일 중복 확인 함수
		    function checkEmail() {
		        var email = document.getElementById('joinEmail').value;
		        var emailError = document.getElementById('emailError');
		        var emailSuccess = document.getElementById('emailsuccess');
		        // 여기서 이메일 중복 확인 로직을 추가하세요.
		        // 예: AJAX 요청을 사용하여 서버에서 이메일 중복 확인
		        
		        // ex. 에러 메시지 표시
		        if (email === "opo226@naver.com") {
		            emailError.style.display = 'block';
		            emailError.textContent = '이미 사용 중인 이메일입니다.';
		            emailSuccess.style.display = 'none';
		            emailSuccess.textContent = '';
		        } else {
		            emailError.style.display = 'none';
		            emailError.textContent = '';
		            emailSuccess.style.display = 'block';
		            emailSuccess.textContent = '사용 가능한 이메일입니다.';
		        }
		    }
		    
		    // 회원가입 성공했을 때 함수
		    function submitJoinForm() {
		        var email = document.getElementById('joinEmail').value;
		        var password = document.getElementById('joinPassword').value;
		        var name = document.getElementById('joinName').value;
		        var mbti = document.getElementById('joinMBTI').value;
		        
		        // 실제 회원가입 로직을 추가
		        // 예시로 회원가입이 성공했다고 가정
		        var isSuccess = true; // 이 부분을 실제 로직으로 변경
		    
		        if (isSuccess) {
		            document.getElementById('joinModal').style.display = 'none';
		            document.getElementById('welcomeMessage').innerHTML = `${name}님, 회원가입을 축하합니다.<br>가입하신 이메일은 ${email} 입니다.`;
		            document.getElementById('welcomeModal').style.display = 'flex';
		        } else {
		            // 회원가입 실패 처리 로직 추가
		        }
		    }
		    
		    // 모달이 열릴 때마다 초기화
		    document.getElementById('joinModal').addEventListener('show', function() {
		        document.getElementById('emailError').style.display = 'none';
		        document.getElementById('emailError').textContent = '';
		        document.getElementById('emailsuccess').style.display = 'none';
		        document.getElementById('emailsuccess').textContent = '';
		        document.getElementById('joinForm').reset();
		    });
        
        // 회원가입 성공했을 때 함수
        function submitJoinForm() {
            var email = document.getElementById('joinEmail').value;
            var password = document.getElementById('joinPassword').value;
            var name = document.getElementById('joinName').value;
            var mbti = document.getElementById('joinMBTI').value;
            
            // 실제 회원가입 로직을 추가
            // 예시로 회원가입이 성공했다고 가정
            var isSuccess = true; // 이 부분을 실제 로직으로 변경
        
            if (isSuccess) {
                document.getElementById('joinModal').style.display = 'none';
                document.getElementById('welcomeMessage').innerHTML = `${name}님, 회원가입을 축하합니다.<br>가입하신 이메일은 ${email} 입니다.`;
                document.getElementById('welcomeModal').style.display = 'flex';
            } else {
                // 회원가입 실패 처리 로직 추가
            }
        }
        
        // 환영 팝업으로 이동
        function goToMain() {
            window.location.href = '${pageContext.request.contextPath}/T_T_Main/T_T_Main.jsp';
        }
        
        // 모달이 열릴 때마다 초기화
        document.getElementById('joinModal').addEventListener('show', function() {
            document.getElementById('emailError').style.display = 'none';
            document.getElementById('emailError').textContent = '';
            document.getElementById('joinForm').reset();
        });
    </script>
  
    <!-- 환영 팝업 -->
    <div id="welcomeModal" style="display: none;">
        <div id="welcomeContent">
            <div class="welcome-header">
                <img src="${pageContext.request.contextPath}/T_T_Main/images/로고.png" alt="Logo">
            </div>
            <h2>환영합니다!</h2>
            <p id="welcomeMessage">user_name님, 회원가입을 축하합니다.<br>가입하신 이메일은 user_email 입니다.</p>
            <p id="additionalMessage">소중한 고객님의 정보를 안전하게 관리하겠습니다.<br>감사합니다.</p>
            <button type="button" onclick="goToMain()">출발하기</button>
        </div>
    </div>

    <!-- 마이페이지 모달 -->
    <div id="myPageModal" style="display: none;">
        <div id="myPageContent">
            <div class="profile-header">
                <img src="${pageContext.request.contextPath}/T_T_Main/images/로고.png" alt="Logo">
                <span class="close" onclick="closeMyPageModal()">&times;</span>
            </div>
            <h2>프로필</h2>
            <p id="userEmail"></p>
            <form id="profileForm" onsubmit="updateProfile(event)">
                <label for="currentPassword">현재 비밀번호</label>
                <input type="password" id="currentPassword" name="currentPassword" placeholder="현재 비밀번호" required>
                <div id="passwordErrorMessage" class="error-message" style="display: none; color: red; font-weight: bold; margin-bottom: 10px;">비밀번호를 정확하게 입력해 주세요.</div>
                
                <label for="newPassword">변경할 비밀번호</label>
                <input type="password" id="newPassword" name="newPassword" placeholder="변경할 비밀번호">
                
                <label for="name">이름</label>
                <input type="text" id="name" name="name" value="홍길동" required>
                
                <label for="mbti">MBTI</label>
                <input type="text" id="mbti" name="mbti" value="INTJ" required>
                
                <button type="submit" class="update-button">프로필 수정</button>
            </form>
        </div>
    </div>

    <script>
    	// 마이페이지 모달 열기 함수
        function openMyPageModal() {
            const username = sessionStorage.getItem('username');
            document.querySelector('#myPageModal #userEmail').innerText = username;
            document.getElementById('myPageModal').style.display = 'flex';
        }
		
    	// 마이페이지 모달 닫기 및 폼 초기화
        function closeMyPageModal() {
            document.getElementById('myPageModal').style.display = 'none';
            document.getElementById('profileForm').reset(); // 폼 초기화
            document.getElementById('passwordErrorMessage').style.display = 'none'; // 에러 메시지 숨기기
        }
		
    	// 프로필 수정 처리
        function updateProfile(event) {
    		event.preventDefault(); // 폼 제출 방지
    		const currentPassword = document.getElementById('currentPassword').value;
    		const storedPassword = '123'; // 실제 구현에서는 서버에서 비밀번호를 확인해야 함

    		if (currentPassword !== storedPassword) {
       		 	document.getElementById('passwordErrorMessage').style.display = 'block';
        		return;
    		}

    // 비밀번호가 맞다면 폼 데이터를 처리 (여기서는 콘솔에 출력)
    	console.log('프로필 수정:', {
        	newPassword: document.getElementById('newPassword').value,
        	name: document.getElementById('name').value,
        	mbti: document.getElementById('mbti').value,
    	});

    // 모달 닫기
    closeMyPageModal();
}
    </script>

</body>
</html>
