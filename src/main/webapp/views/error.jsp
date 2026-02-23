<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html class="light" lang="en"><head>
<meta charset="utf-8"/><meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Error - SecureShare</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
<script>
    tailwind.config={darkMode:"class",theme:{extend:{colors:{"primary":"#2463eb","background-light":"#f6f6f8","background-dark":"#111621"},fontFamily:{"display":["Inter","sans-serif"]},borderRadius:{"DEFAULT":"0.5rem","lg":"1rem","xl":"1.5rem","full":"9999px"}}}};
</script>
<style>body{font-family:'Inter',sans-serif;}.material-symbols-outlined{font-variation-settings:'FILL' 0,'wght' 400,'GRAD' 0,'opsz' 24;}</style>
</head>
<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen flex flex-col font-display">
<%
    // Collect error info from request attributes (set by servlets or container)
    String errorMsg = (String) request.getAttribute("error");
    if (errorMsg == null) {
        // Check standard Jakarta/Servlet error attributes (set by container on 404/500)
        Object statusCode = request.getAttribute("jakarta.servlet.error.status_code");
        Object message = request.getAttribute("jakarta.servlet.error.message");
        if (statusCode != null) {
            int code = (Integer) statusCode;
            if (code == 404) {
                errorMsg = "The page you are looking for does not exist.";
            } else if (code == 500) {
                errorMsg = "An internal server error occurred. Please check the server logs.";
            } else {
                errorMsg = "Error " + code + (message != null ? ": " + message : "");
            }
        }
    }
    if (errorMsg == null) {
        errorMsg = "An unexpected error occurred. Please try again later.";
    }
%>
<header class="w-full px-6 py-4 flex items-center justify-between bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-slate-800">
  <div class="flex items-center gap-2">
    <div class="bg-primary p-1.5 rounded-lg text-white"><span class="material-symbols-outlined text-2xl block">shield_lock</span></div>
    <h1 class="text-xl font-bold tracking-tight">SecureShare</h1>
  </div>
</header>
<main class="flex-1 flex items-center justify-center p-6">
  <div class="max-w-md w-full text-center">
    <div class="bg-white dark:bg-slate-900 rounded-xl shadow-xl border border-slate-200 dark:border-slate-800 p-12">
      <div class="inline-flex items-center justify-center w-20 h-20 bg-red-100 dark:bg-red-900/20 rounded-2xl mb-6">
        <span class="material-symbols-outlined text-5xl text-red-500">error</span>
      </div>
      <h2 class="text-2xl font-bold text-slate-900 dark:text-white mb-3">Something went wrong</h2>
      <p class="text-slate-500 dark:text-slate-400 mb-8"><%= errorMsg %></p>
      <div class="flex flex-col gap-3">
        <a href="<%= request.getContextPath() %>/dashboard" class="w-full bg-primary hover:bg-primary/90 text-white font-bold py-3 px-6 rounded-lg transition-all flex items-center justify-center gap-2">
          <span class="material-symbols-outlined">home</span> Go to Dashboard
        </a>
        <a href="<%= request.getContextPath() %>/login" class="w-full border border-slate-200 dark:border-slate-700 text-slate-700 dark:text-slate-200 font-bold py-3 px-6 rounded-lg hover:bg-slate-50 transition-all flex items-center justify-center gap-2">
          <span class="material-symbols-outlined">login</span> Login Page
        </a>
      </div>
    </div>
  </div>
</main>
</body></html>

