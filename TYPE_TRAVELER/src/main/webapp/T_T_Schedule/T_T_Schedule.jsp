<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>T_T_Schedule.jsp</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Schedule/css/Schedule_styles.css">
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
        <%@ include file="../T_T_Main/calendar.html" %>
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

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        var calendar; // 캘린더 변수를 전역으로 설정

        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                locale: 'ko',
                timeZone: 'Asia/Seoul', // 서울 타임존 설정
                selectable: true,
                editable: true,

                select: function(info) {
                    $('#eventModal').modal('show');
                    $('#eventForm').off('submit').on('submit', function(e) {
                        e.preventDefault();
                        var title = document.getElementById('eventTitle').value;
                        if (title) {
                            calendar.addEvent({
                                title: title,
                                start: info.startStr,
                                end: info.endStr,
                                allDay: info.allDay
                            });
                            $('#eventModal').modal('hide');
                            showInfoModal('일정이 추가되었습니다.');
                        }
                    });
                    calendar.unselect();
                },

                eventClick: function(info) {
                    $('#deleteModal').modal('show');
                    $('#confirmDelete').off('click').on('click', function() {
                        info.event.remove();
                        $('#deleteModal').modal('hide');
                        showInfoModal('여행 일정이 삭제되었습니다.');
                    });
                },

                eventDrop: function(info) {
                    var endDate = new Date(info.event.end);
                    endDate.setDate(endDate.getDate() - 1);
                    showInfoModal('여행 일정이 업데이트되었습니다<br>' + info.event.start.toISOString().split('T')[0] + ' ~ ' + endDate.toISOString().split('T')[0]);
                },

                eventResize: function(info) {
                    var endDate = new Date(info.event.end);
                    endDate.setDate(endDate.getDate() - 1);
                    showInfoModal('여행 일정 종료 날짜가 업데이트되었습니다<br>' + info.event.start.toISOString().split('T')[0] + ' ~ ' + endDate.toISOString().split('T')[0]);
                }
            });
            calendar.render();
        });

        function showInfoModal(message) {
            document.getElementById('modalBody').innerHTML = message;
            $('#infoModal').modal('show');
        }
    </script>
</body>
</html>
