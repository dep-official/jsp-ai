<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags/shared/ui/Button" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags/shared/ui/Tag" %>
<%@ taglib prefix="title" tagdir="/WEB-INF/tags/shared/ui/Title" %>
<%@ attribute name="title" required="true" %>
<%@ attribute name="subtitle" required="false" %>
<%@ attribute name="tagLabel" required="false" %>
<%@ attribute name="hashtagLabel" required="false" %>
<%@ attribute name="hashtagIcon" required="false" %>
<%@ attribute name="className" required="false" %>

<div class="flex flex-col items-center justify-center ${className}">
    <c:if test="${!empty tagLabel}">
        <tag:Tag label="${tagLabel}" variant="event" />
    </c:if>
    
    <title:Title title="${title}" subtitle="${subtitle}" />
    
    <c:if test="${!empty hashtagLabel}">
        <ui:HashtagButton label="${hashtagLabel}" icon="${hashtagIcon}" active="false" />
    </c:if>
</div>

