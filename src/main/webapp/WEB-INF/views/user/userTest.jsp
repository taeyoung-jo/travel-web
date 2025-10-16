<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.travelers.travelweb.domain.user.domain.User" %>

<% User user = (User) request.getAttribute("user"); %>
<% if(user != null) { %>
<ul>
    <li>ID: <%= user.getId() %></li>
    <li>Email: <%= user.getEmail() %></li>
    <li>Name: <%= user.getName() %></li>
    <li>Password: <%= user.getPassword() %></li>
    <li>Phone: <%= user.getPhone() %></li>
</ul>
<% } else { %>
<p>사용자 정보가 없습니다.</p>
<% } %>