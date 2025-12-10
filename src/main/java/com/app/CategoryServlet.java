package com.app;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONArray;
import org.json.JSONObject;

public class CategoryServlet extends HttpServlet {

    private static final String API_KEY = "62b480461ea186b2249f04345692a128";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String topic = request.getParameter("topic");

        if (topic == null || topic.isEmpty()) {
            topic = "business"; // default
        }

        String apiUrl = String.format(
                "https://gnews.io/api/v4/top-headlines?apikey=%s&topic=%s&lang=en&country=in",
                API_KEY, topic
        );

        try {
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream())
            );

            StringBuilder jsonData = new StringBuilder();
            String line;

            while ((line = br.readLine()) != null) {
                jsonData.append(line);
            }
            br.close();

            JSONObject json = new JSONObject(jsonData.toString());
            JSONArray articles = json.getJSONArray("articles");

            request.setAttribute("articles", articles);
            request.setAttribute("topic", topic);

            request.getRequestDispatcher("category.jsp").forward(request, response);

        } catch (Exception e) {
            response.getWriter().println("Error fetching category news: " + e.getMessage());
        }
    }
}

