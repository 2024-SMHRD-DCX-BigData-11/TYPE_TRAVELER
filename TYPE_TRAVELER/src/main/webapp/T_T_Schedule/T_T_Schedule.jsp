<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>T_T_Schedule.jsp</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Main/css/Main_styles.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Schedule/css/Schedule_styles.css">
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales/ko.js'></script>
</head>
<body>

   <!-- T_T 상단 배너 -->
    <%@ include file="../T_T_Main/T_T_Main_Banner.jsp" %>

    <!-- 캘린더를 표시할 div 입니다 -->
    <div id='calendar'></div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                locale: 'ko',
                timeZone: 'Asia/Seoul', // 서울 타임존 설정
                selectable: true,
                editable: true,
               
                select: function(info) {
                    var title = prompt('일정 제목을 입력하세요:');
                    if (title) {
                        calendar.addEvent({
                            title: title,
                            start: info.startStr,
                            end: info.endStr,
                            allDay: info.allDay
                        });
                    }
                    calendar.unselect();
                },
                eventClick: function(info) {
                    if (confirm('여행 일정을 삭제하시겠습니까?')) {
                        info.event.remove();
                    }
                },
                eventDrop: function(info) {
                    alert('여행 일정이 업데이트되었습니다: ' + info.event.start.toISOString().split('T')[0]);
                },
                eventResize: function(info) {
                    alert('여행 일정 종료 날짜가 업데이트되었습니다: ' + info.event.end.toISOString().split('T')[0]);
                }
            });
            calendar.render();
        });
    </script>

</body>
</html>
