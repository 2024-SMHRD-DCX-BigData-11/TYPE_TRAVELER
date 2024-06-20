<%@page import="com.T_T.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("memberInfo") == null) {
        response.sendRedirect(request.getContextPath() + "/T_T_Main/T_T_Main.jsp");
        return;
    }
    MemberDTO memberInfo = (MemberDTO) session1.getAttribute("memberInfo");
    String userEmail = memberInfo.getUser_email();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>T_T_Schedule.jsp</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Schedule/css/Schedule_styles.css">
<script src="https://momentjs.com/downloads/moment.js"></script>
<script src="https://momentjs.com/downloads/moment-timezone.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment-timezone/0.5.34/moment-timezone-with-data.min.js"></script>
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales/ko.js'></script>
<!-- Bootstrap CSS 추가 -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

   <!-- T_T 상단 배너 -->
    <%@ include file="../T_T_Main/T_T_Main_Banner.jsp" %>

    <!-- 캘린더를 표시할 div 입니다 -->
    <div id="cc">
        <div id="calendar"></div>
    </div>

    <!-- 일정 추가 모달 -->
    <div class="modal fade" id="eventModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="eventModalLabel">🧳 일정 추가 🧳</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form id="eventForm">
              <div class="form-group">
                <label for="eventTitle">일정 제목</label>
                <input type="text" class="form-control" id="eventTitle" required>
              </div>
              <div class="form-group">
                <label for="startDate">시작 날짜</label>
                <input type="date" class="form-control" id="startDate" required>
              </div>
              <div class="form-group">
                <label for="endDate">종료 날짜</label>
                <input type="date" class="form-control" id="endDate" required>
              </div>
              <button type="submit" class="btn btn-primary">추가</button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <!-- 알림 모달 -->
    <div class="modal fade" id="infoModal" tabindex="-1" aria-labelledby="infoModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="infoModalLabel">🏖️ 일정 정보 🏖️</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body" id="modalBody">
            <!-- 여기에 JavaScript로 메시지를 추가 -->
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
          </div>
        </div>
      </div>
    </div>

    <!-- 삭제 확인 모달 -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="deleteModalLabel">✈️ 일정 삭제 ✈️</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body" id="deleteModalBody">
            여행 일정을 정말 삭제하시겠습니까?
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
            <button type="button" class="btn btn-danger" id="confirmDelete">삭제</button>
          </div>
        </div>
      </div>
    </div>

    <!-- 로그인 모달 -->
    <div id="loginModal" style="display: none;">
        <div id="loginContent">
            <div class="login-header">
                <img src="${pageContext.request.contextPath}/T_T_Main/images/로고.png" alt="Logo">
                <span class="close" onclick="closeLoginModal()">&times;</span>
            </div>
            <form id="loginFormModal" action="${pageContext.request.contextPath}/LoginServlet" method="post">
                <input type="hidden" id="redirectURLLogin" name="redirectURL" value="">
                <input type="text" id="loginUserEmail" name="user_email" placeholder="이메일" required>
                <input type="password" id="loginPassword" name="user_pw" placeholder="비밀번호" required>
                <div id="errorMessage" class="error-message" style="display: none;">이메일 또는 비밀번호를 잘못 입력했습니다. 입력하신 내용을 다시 확인해주세요.</div>
                <button type="submit" class="login-button">로그인</button>
            </form>
        </div>
    </div>

    <!-- 회원가입 팝업 -->
    <div id="joinModal" style="display: none;">
        <div id="joinContent">
            <div class="join-header">
                <img src="${pageContext.request.contextPath}/T_T_Main/images/로고.png" alt="Logo">
                <span class="close" onclick="closeJoinModal()">&times;</span>
            </div>
            <form id="joinFormModal" action="${pageContext.request.contextPath}/RegisterServlet" method="post">
                <label for="joinUserEmail">이메일</label>
                <div class="input-group">
                    <input type="text" id="joinUserEmail" name="user_email" placeholder="사용하실 이메일을 입력해 주세요." required>
                    <button type="button" class="check-button" onclick="checkEmail()">중복 확인</button>
                </div>
                <span id="resultCheck" class="message"></span>
                
                <label for="joinUserPassword">비밀번호</label>
                <input type="password" id="joinUserPassword" name="user_pw" placeholder="사용하실 비밀번호를 입력해 주세요." required>
               
                <label for="joinUserName">이름</label>
                <input type="text" id="joinUserName" name="user_name" placeholder="이름을 입력해 주세요." required>
              
                <label for="joinUserMBTI">MBTI</label>
                <input type="text" id="joinUserMBTI" name="user_mbti" placeholder="MBTI를 입력해 주세요." required>
                
                <div class="mbti-link">
                    <span>나의 MBTI를 모른다면? </span>
                    <a href="https://www.16personalities.com/ko/%EB%AC%B4%EB%A3%8C-%EC%84%B1%EA%B2%A9-%EC%9C%A0%ED%98%95-%EA%B2%80%EC%82%AC" target="_blank">검사하기</a>
                </div>
                <button type="submit" class="join-button">가입하기</button>
            </form>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
    var calendar; // 캘린더 변수를 전역으로 설정
    var selectedEvent; // 선택된 이벤트를 저장할 변수
    var userEmail = "<%= userEmail %>"; // 세션에서 가져온 사용자 이메일

    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'ko',
            timeZone: 'Asia/Seoul', // 서울 타임존 설정
            selectable: true,
            editable: true,

            events: function(fetchInfo, successCallback, failureCallback) {
                $.ajax({
                    url: 'LoadEventsServlet',
                    method: 'POST',
                    data: { email: userEmail },
                    success: function(data) {
                        var events = [];
                        data.forEach(function(event) {
                        	if (!calendar.getEventById(event.id)) {
	                            calendar.addEvent({
	                            	id: event.id,
	                                title: event.title,
									start: moment.tz(event.start, 'Asia/Seoul').format(),
	                                end: moment.tz(new Date(event.end).setDate(new Date(event.end).getDate() + 1), 'Asia/Seoul').format(),
	                                allDay: true // 날짜 단위로 일정 추가
	                            });
                        	}
                            console.log(event);
                            console.log(moment.tz(event.start, 'Asia/Seoul').format());
                            console.log(moment.tz(event.end, 'Asia/Seoul').format());
                        });
                        successCallback(events);
                    },
                    error: function() {
                        failureCallback();
                    }
                });
            },

            select: function(info) {
            	console.log(info)
                var startStr = formatDateOnly(new Date(info.start));
                var endDate = new Date(info.end);
                endDate.setDate(endDate.getDate() - 1); // 종료 날짜에서 하루를 뺍니다.
                var endStr = formatDateOnly(endDate);

                $('#eventModal').modal('show');
                document.getElementById('startDate').value = startStr;
                document.getElementById('endDate').value = endStr;
                $('#eventForm').off('submit').on('submit', function(e) {
                    e.preventDefault();
                    var title = document.getElementById('eventTitle').value;
                    var startDate = document.getElementById('startDate').value;
                    var endDate = document.getElementById('endDate').value;

                    if (title && startDate && endDate) {
                        $.ajax({
                            url: 'AddEventServlet',
                            method: 'POST',
                            data: {
                                email: userEmail,
                                title: title,
                                startDate: startDate,
                                endDate: endDate
                            },
                            success: function(event) {
                                calendar.addEvent({
                                	id: event.id,
                                    title: title,
                                    start: startDate,
                                    end: new Date(endDate).setDate(new Date(endDate).getDate() + 1), // 종료 날짜를 원래대로 설정
                                    allDay: true // 날짜 단위로 일정 추가
                                });
                                $('#eventModal').modal('hide');
                                showInfoModal('일정이 추가되었습니다.<br>' + formatDate(startDate) + ' ~ ' + formatDate(endDate));
                            },
                            error: function(xhr, status, error) {
                                alert("일정 추가 중 오류가 발생했습니다: " + xhr.responseText);
                            }
                        });
                    }
                });
                calendar.unselect();
            },

            eventClick: function(info) {
                selectedEvent = info.event;
                $('#deleteModal').modal('show');
            },

            eventDrop: function(info) {
            	test_end = new Date(info.event.end);
            	test_end.setDate(new Date(info.event.end).getDate() - 1);
                $.ajax({
                    url: 'UpdateEventCon',
                    method: 'POST',
                    data: {
                        id: info.event.id,
                        start: info.event.start.toISOString(),
                        end: test_end.toISOString()
                    },
                    success: function() {
                        showInfoModal('여행 일정이 업데이트되었습니다.<br>' + formatDate(info.event.start) + ' ~ ' + formatDate(new Date(info.event.end).setDate(new Date(info.event.end).getDate() - 1)));
                    },
                    error: function(xhr, status, error) {
                        alert("일정 업데이트 중 오류가 발생했습니다: " + xhr.responseText);
                    }
                });
            },

            eventResize: function(info) {
            	test_end = new Date(info.event.end);
            	test_end.setDate(new Date(info.event.end).getDate() - 1);
                $.ajax({
                    url: 'UpdateEventCon',
                    method: 'POST',
                    data: {
                        id: info.event.id,
                        start: info.event.start.toISOString(),
                        end: test_end.toISOString()
                    },
                    success: function() {
                        showInfoModal('여행 일정 종료 날짜가 업데이트되었습니다.<br>' + formatDate(info.event.start) + ' ~ ' + formatDate(new Date(info.event.end).setDate(new Date(info.event.end).getDate() - 1)));
                    },
                    error: function(xhr, status, error) {
                        alert("일정 업데이트 중 오류가 발생했습니다: " + xhr.responseText);
                    }
                });
            }
        });
        calendar.render();
    });

    document.getElementById('confirmDelete').addEventListener('click', function() {
        if (selectedEvent) {
            $.ajax({
                url: 'DeleteEventServlet',
                method: 'POST',
                data: {
                    id: selectedEvent.id
                },
                success: function() {
                    selectedEvent.remove();
                    $('#deleteModal').modal('hide');
                    showInfoModal('여행 일정이 삭제되었습니다.');
                },
                error: function(xhr, status, error) {
                    alert("일정 삭제 중 오류가 발생했습니다: " + xhr.responseText);
                }
            });
        }
    });

    function showInfoModal(message) {
        document.getElementById('modalBody').innerHTML = message;
        $('#infoModal').modal('show');
    }

    function formatDateOnly(date) {
        var year = date.getFullYear();
        var month = ('0' + (date.getMonth() + 1)).slice(-2);
        var day = ('0' + date.getDate()).slice(-2);
        return year + '-' + month + '-' + day;
    }

    function formatDate(dateStr) {
        var date = new Date(dateStr);
        var year = date.getFullYear();
        var month = ('0' + (date.getMonth() + 1)).slice(-2);
        var day = ('0' + date.getDate()).slice(-2);
        return year + '-' + month + '-' + day;
    }


        function openLoginModal(redirectURL = null) {
            if (redirectURL) {
                document.getElementById('redirectURLLogin').value = redirectURL;
            } else {
                document.getElementById('redirectURLLogin').value = window.location.href;
            }
            
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
            document.getElementById("loginFormModal").reset();
            document.getElementById("errorMessage").style.display = "none";
        }

        function checkLoginAndRedirect() {
            if (isLoggedIn === "true") {
                window.location.href = contextPath + "/T_T_Schedule/T_T_Schedule.jsp";
            } else {
                openLoginModal(contextPath + "/T_T_Schedule/T_T_Schedule.jsp");
            }
        }

        window.onload = function() {
            const params = new URLSearchParams(window.location.search);
            if (params.has('loginError')) {
                document.getElementById("errorMessage").style.display = "block";
                openLoginModal();
            }
        };
    </script>
</body>
</html>
