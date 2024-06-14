<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>T_T_Schedule.jsp</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Main/css/main_styles.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/T_T_Schedule/css/schedule_styles.css">
<style>e
    body {
        margin: 0;
        padding: 0;
    }
    #calendar {
        width: 100%;  /* 캘린더 너비를 100%로 설정 */
        height: calc(100vh - 50px);  /* 캘린더 높이를 화면 전체 높이에서 배너의 높이(예: 50px)를 뺀 값으로 설정 */
        margin-top: 50px;  /* 배너의 높이만큼 캘린더를 아래로 내림 */
        box-sizing: border-box;  /* 박스 사이징을 설정하여 패딩과 테두리를 포함한 크기를 조정 */
        position: relative; /* 배너와 겹치지 않도록 캘린더의 위치를 상대적으로 설정 */
    }
    #banner {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 50px; /* 예시로 배너의 높이를 50px로 설정 */
        background-color: #ccc; /* 배너의 배경색을 설정 */
        z-index: 1; /* 캘린더보다 위에 나타나도록 설정 */
    }
</style>
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales/ko.js'></script>
</head>
<body>

   <!-- T_T 상단 배너 -->
    <div id="banner">
        <%@ include file="../T_T_Main/T_T_Main_Banner.jsp" %>
    </div>

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