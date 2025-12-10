<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>

<html>
<head>
    <title>News Category</title>
</head>
<body>

<h1>Top Headlines: <%= request.getAttribute("topic") %></h1>

<ul>
    <%
        JSONArray articles = (JSONArray) request.getAttribute("articles");

        if (articles != null) {
            for (int i = 0; i < articles.length(); i++) {
                JSONObject article = articles.getJSONObject(i);
                String title = article.getString("title");
                String link = article.getString("url");
    %>

    <li>
        <a href="<%= link %>" target="_blank"><%= title %></a>
    </li>

    <% 
            }
        }
    %>
</ul>

<br><br>
<a href="index.jsp">Go Back</a>

</body>
</html>
