<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.storage.securefileuploadandsharingsystem.models.FileMetadata" %>
<%@ page import="com.storage.securefileuploadandsharingsystem.models.ShareLink" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html class="light" lang="en"><head>
<meta charset="utf-8"/><meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>SecureShare | Access Shared File</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
<script>
    tailwind.config={darkMode:"class",theme:{extend:{colors:{"primary":"#2463eb","background-light":"#f6f6f8","background-dark":"#111621","success":"#10b981"},fontFamily:{"display":["Inter","sans-serif"]},borderRadius:{"DEFAULT":"0.5rem","lg":"1rem","xl":"1.5rem","full":"9999px"}}}};
</script>
<style>body{font-family:'Inter',sans-serif;}.material-symbols-outlined{font-variation-settings:'FILL' 0,'wght' 400,'GRAD' 0,'opsz' 24;}</style>
</head>
<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen flex flex-col">
<%
    FileMetadata file = (FileMetadata) request.getAttribute("file");
    ShareLink shareLink = (ShareLink) request.getAttribute("shareLink");
    String token = (String) request.getAttribute("token");
    Boolean needsPassword = (Boolean) request.getAttribute("needsPassword");
    String error = (String) request.getAttribute("error");
    if (needsPassword == null) needsPassword = false;
    SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy");

    String sizeStr;
    if (file.getFileSize() < 1048576) sizeStr = String.format("%.1f KB", file.getFileSize() / 1024.0);
    else sizeStr = String.format("%.1f MB", file.getFileSize() / 1048576.0);
%>
<header class="w-full px-6 py-4 flex items-center justify-between bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-slate-800">
  <div class="flex items-center gap-2">
    <div class="bg-primary p-1.5 rounded-lg text-white"><span class="material-symbols-outlined text-2xl block">shield_lock</span></div>
    <h1 class="text-xl font-bold tracking-tight text-slate-900 dark:text-white">SecureShare <span class="text-primary">Enterprise</span></h1>
  </div>
</header>
<main class="flex-1 flex items-center justify-center p-6 md:p-12">
  <div class="max-w-2xl w-full">
    <div class="bg-white dark:bg-slate-900 rounded-xl shadow-2xl overflow-hidden border border-slate-200 dark:border-slate-800">
      <!-- File Info -->
      <div class="p-8 md:p-12 text-center border-b border-slate-100 dark:border-slate-800">
        <div class="inline-flex items-center justify-center w-24 h-24 bg-primary/10 rounded-2xl mb-6">
          <span class="material-symbols-outlined text-6xl text-primary">description</span>
        </div>
        <h2 class="text-2xl font-bold text-slate-900 dark:text-white mb-2 truncate px-4"><%= file.getOriginalFilename() %></h2>
        <p class="text-slate-500 dark:text-slate-400 font-medium">
          <%= sizeStr %> &bull; <%= file.getFileType() %>
        </p>
        <% if (shareLink.getExpiresAt() != null) { %>
        <div class="mt-6 inline-flex items-center gap-2 px-3 py-1 rounded-full bg-amber-50 dark:bg-amber-900/20 text-amber-700 text-xs font-bold uppercase tracking-wider border border-amber-100">
          <span class="material-symbols-outlined text-sm">schedule</span>
          Expires: <%= sdf.format(shareLink.getExpiresAt()) %>
        </div>
        <% } %>
      </div>
      <!-- Action Area -->
      <div class="p-8 md:p-12 bg-slate-50/50 dark:bg-slate-800/30">
        <div class="max-w-md mx-auto">
          <% if (error != null && !error.isEmpty()) { %>
            <div class="mb-4 flex items-center gap-2 text-sm text-red-600 bg-red-50 p-3 rounded-lg">
              <span class="material-symbols-outlined text-lg">error</span><span><%= error %></span>
            </div>
          <% } %>

          <% if (needsPassword) { %>
              <!-- Password required -->
              <form action="<%= request.getContextPath() %>/share/verify/<%= token %>" method="POST" class="flex flex-col gap-6">
                <div>
                  <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-2" for="password">Password Protected</label>
                  <p class="text-sm text-slate-500 mb-4">Enter the password provided by the sender to access the download.</p>
                  <div class="relative group">
                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none text-slate-400"><span class="material-symbols-outlined text-xl">lock</span></div>
                    <input class="block w-full pl-11 pr-4 py-4 bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-700 rounded-lg focus:ring-2 focus:ring-primary focus:border-primary outline-none" id="password" name="password" placeholder="Enter access password" type="password" required/>
                  </div>
                </div>
                <button type="submit" class="w-full bg-primary hover:bg-blue-700 text-white font-bold py-4 px-6 rounded-lg shadow-lg shadow-primary/20 flex items-center justify-center gap-2 group">
                  <span>Unlock File</span><span class="material-symbols-outlined group-hover:translate-x-1 transition-transform">arrow_forward</span>
                </button>
              </form>
          <% } else { %>
              <!-- No password — direct download -->
              <div class="flex flex-col gap-4">
                <a href="<%= request.getContextPath() %>/share/download/<%= token %>" class="w-full bg-emerald-500 hover:bg-emerald-600 text-white font-bold py-4 px-6 rounded-lg shadow-lg shadow-emerald-500/20 flex items-center justify-center gap-2">
                  <span class="material-symbols-outlined">download</span><span>Download File</span>
                </a>
              </div>
          <% } %>
        </div>
      </div>
      <!-- Trust Indicators -->
      <div class="px-8 py-6 bg-slate-100 dark:bg-slate-800/60 border-t border-slate-200 dark:border-slate-700">
        <div class="flex flex-wrap items-center justify-center gap-x-8 gap-y-4">
          <div class="flex items-center gap-2 text-slate-500"><span class="material-symbols-outlined text-emerald-500 text-xl">verified</span><span class="text-xs font-bold uppercase tracking-wider">Secure</span></div>
          <div class="flex items-center gap-2 text-slate-500"><span class="material-symbols-outlined text-primary text-xl">encrypted</span><span class="text-xs font-bold uppercase tracking-wider">AES-256</span></div>
          <div class="flex items-center gap-2 text-slate-500"><span class="material-symbols-outlined text-slate-400 text-xl">policy</span><span class="text-xs font-bold uppercase tracking-wider">Privacy Compliant</span></div>
        </div>
      </div>
    </div>
    <div class="mt-12 text-center">
      <p class="text-sm text-slate-500">Powered by <span class="font-bold text-slate-700">SecureShare Enterprise</span></p>
    </div>
  </div>
</main>
</body></html>
