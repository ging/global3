
// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function createSessionEvent(title, start, end, event_id,receiver){
	jQuery.ajax({
        data: 'session[title]='+title+
    '&session[receiver]='+receiver+
		'&session[description]='+title+
		'&session[period]=Does%20not%20repeat'+
		'&session[start_at]='+start.toString().substring(0, 24)+
		'&session[end_at]='+end.toString().substring(0, 24)+
		'&session[event_id]='+event_id,
        dataType: 'script',
        type: 'POST',
        url: '/sessions?id='+event_id
	});
}

function moveSession(session, dayDelta, minuteDelta, allDay){
    alert(session.id);
    jQuery.ajax({
        data: 'id=' + session.id + '&title=' + session.title + '&day_delta=' + dayDelta + '&minute_delta=' + minuteDelta + '&all_day=' + allDay,
        dataType: 'script',
        type: 'post',
        url: '/sessions/'+session.id+'/move'

    });
}

function resizeSession(session, dayDelta, minuteDelta){
    jQuery.ajax({
        data: 'id=' + session.id + '&title=' + session.title + '&day_delta=' + dayDelta + '&minute_delta=' + minuteDelta,
        dataType: 'script',
        type: 'post',
        url: '/sessions/'+session.id+'/resize'
    });
}

function showSessionDetails(session){
	$('#event_desc').html(session.description);
	$('#edit_event').html("<a href = 'javascript:void(0);' onclick ='editSession(" + session.id + ")'>Editar</a>");

	if (session.recurring) {
		title = session.title + "(Recurring)";
		$('#delete_event').html("&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + session.id + ", " + false + ")'>Eliminar solo esta ocurrencia</a>");
		$('#delete_event').append("&nbsp;&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + session.id + ", " + true + ")'>Eliminar toda la serie</a>");
		$('#delete_event').append("&nbsp;&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + session.id + ", \"future\")'>Eliminar todos los eventos futuros</a>");
	}
	else {
		title = session.title;
		$('#delete_event').html("<a href = 'javascript:void(0);' onclick ='deleteSession(" + session.id + ", " + false + ")'>Eliminar</a>");
	}
	$('#desc_dialog').dialog({
		title: title,
		modal: true,
		width: 500,
		close: function(session, ui){
			$('#desc_dialog').dialog('destroy')
		}
	});
}

function showSessionDescription(event){
	$('#event_desc').html(event.description);
        $('#edit_event').html("");
	$('#delete_event').html("");

	$('#desc_dialog').dialog({
		title: event.title,
		modal: true,
		width: 500,
		close: function(event, ui){
			$('#desc_dialog').dialog('destroy')
		}
	});
}

function editSession(session_id){
    jQuery.ajax({
        data: 'id=' + session_id,
        dataType: 'script',
        type: 'get',
        url: '/sessions/'+session.id+'/edit'
    });
}

function deleteSession(session_id, delete_all){
    jQuery.ajax({
        data: 'id=' + session_id + '&delete_all='+delete_all,
        dataType: 'script',
        type: 'post',
        url: '/sessions/'+session.id+'/destroy'
    });
}

function showRepeatUntil(value) {
    if (value) {
      $('#repeat_until').show();
    } else {
      $('#repeat_until').hide();

      $('#repeat_until_year').val("");
      $('#repeat_until_month').val("");
      $('#repeat_until_day').val("");
    }
}

function showPeriodAndFrequency(value){
    switch (value) {
        case 'Daily':
            $('#period').html('día(s)');
            $('#frequency').show();
            break;
        case 'Weekly':
            $('#period').html('semana(s)');
            $('#frequency').show();
            break;
        case 'Monthly':
            $('#period').html('mes(es)');
            $('#frequency').show();
            break;
        case 'Yearly':
            $('#period').html('año(s)');
            $('#frequency').show();
            break;

        default:
            $('#frequency').hide();
    }
}

function dateScheduleAvailable(start, end, allDay){
	return $('#calendar').fullCalendar('clientEvents', function(session)
	{
		if ((session.start_at < start && start < session.end_at) ||
		    (session.start_at < end && end < session.end_at) ||
		    (compareDate(session.start_at, start) && (session.allDay || allDay))
		   )
			{
				return true;
			}
			return false;
	}) == '';
}

function dateAvailable(start, end, allDay){
	return $('#calendar').fullCalendar('clientEvents', function(session)
	{
		if (session.start_at < start && start < session.end_at)
			return true;
		else if (session.start_at < end && end < session.end_at)
			return true;
                else if (session.start_at > start && (session.end_at && session.end_at < end))
                        return true;
		else if (compareDateWithMinutes(session.start_at, start))
			return true;
		else if (session.end_at && compareDateWithMinutes(session.end_at, end))
			return true;
		else if (compareDate(session.start_at, start) && (session.allDay || allDay))
			return true;
		else
			return false;
	}) == '' && (start >= new Date(new Date().getTime() + 2*60*60*1000) && start <= new Date(new Date().getTime() + 3*30*24*60*60*1000));
}

function compareDate(date1, date2)
{
	return $.fullCalendar.formatDate(date1, "yyyy-MM-dd") == $.fullCalendar.formatDate(date2, "yyyy-MM-dd");
}

function compareDateWithMinutes(date1, date2)
{
	return $.fullCalendar.formatDate(date1, "yyyy-MM-dd HH:mm") == $.fullCalendar.formatDate(date2, "yyyy-MM-dd HH:mm");
}
