<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>T_T_Main_Banner.jsp</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Main/css/styles.css">
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
            <li><a href="javascript:void(0);" onclick="openLoginModal()">로그인</a></li>
			<li><a href="javascript:void(0);" onclick="openJoinModal()">회원가입</a></li>

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
  
    	<!-- 로그인 팝업 script -->
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
			}
			
			function checkEmail() {
			    var email = document.getElementById('joinEmail').value;
			    // 이메일 중복 체크 로직 추가
			    // 예시로 이미 사용중인 이메일일 경우
			    var isDuplicate = true; // 이 부분을 실제 로직으로 변경
			
			    if (isDuplicate) {
			        document.getElementById('emailError').innerText = '이미 사용 중인 이메일입니다.';
			        document.getElementById('emailError').style.display = 'block';
			    } else {
			        document.getElementById('emailError').innerText = '';
			        document.getElementById('emailError').style.display = 'none';
			    }
			}
			
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
			
			function goToMain() {
			    window.location.href = '${pageContext.request.contextPath}/T_T_Main/T_T_Main.jsp';
			}
			</script>
	
	
	
	
	<!-- 환영 팝업 -->
	<div id="welcomeModal" style="display: none;">
	    <div id="welcomeContent">
	        <div class="welcome-header">
	            <img src="${pageContext.request.contextPath}/T_T_Main/images/로고.png" alt="Logo">
	        </div>
	        <h2>환영합니다!</h2>
	        <p id="welcomeMessage">user_name님, 회원가입을 축하합니다.<br>가입하신 이메일은 user_email 입니다.</p>
	        <p>소중한 고객님의 정보를 안전하게 관리하겠습니다. 감사합니다.</p>
	        <button type="button" onclick="goToMain()">출발하기</button>
	    </div>
	</div>
    
    
    
</body>
</html>
