<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.storage.securefileuploadandsharingsystem.models.FileMetadata" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html class="light" lang="en"><head>
<meta charset="utf-8"/><meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>File Management Dashboard</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<script>
    tailwind.config={darkMode:"class",theme:{extend:{colors:{"primary":"#2463eb","background-light":"#f6f6f8","background-dark":"#111621"},fontFamily:{"display":["Inter","sans-serif"]},borderRadius:{"DEFAULT":"0.5rem","lg":"1rem","xl":"1.5rem","full":"9999px"}}}};
</script>
<style>.material-symbols-outlined{font-variation-settings:'FILL' 0,'wght' 400,'GRAD' 0,'opsz' 24;}.active-nav{background-color:rgba(36,99,235,0.1);color:#2463eb;border-right:3px solid #2463eb;border-radius:0;}body{font-family:'Inter',sans-serif;}</style>
</head>
<body class="font-display bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 antialiased">
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    String totalStorage = (String) request.getAttribute("totalStorage");
    Integer totalFiles = (Integer) request.getAttribute("totalFiles");
    Integer activeShares = (Integer) request.getAttribute("activeShares");
    List<FileMetadata> files = (List<FileMetadata>) request.getAttribute("files");
    String paramSuccess = request.getParameter("success");
    String paramError = request.getParameter("error");
    if (totalStorage == null) totalStorage = "0 B";
    if (totalFiles == null) totalFiles = 0;
    if (activeShares == null) activeShares = 0;
    SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy HH:mm");
%>
<div class="flex h-screen overflow-hidden">
<!-- Sidebar -->
<aside class="w-64 bg-white dark:bg-slate-900 border-r border-slate-200 dark:border-slate-800 flex flex-col shrink-0">
<div class="p-6 flex items-center gap-3">
  <div class="bg-primary p-2 rounded-lg text-white"><span class="material-symbols-outlined">folder_managed</span></div>
  <h2 class="text-xl font-bold tracking-tight">SecureShare</h2>
</div>
<nav class="flex-1 px-4 py-4 space-y-1">
  <a class="flex items-center gap-3 px-3 py-2.5 active-nav transition-colors" href="<%= request.getContextPath() %>/dashboard">
    <span class="material-symbols-outlined">dashboard</span><span class="text-sm font-medium">Dashboard</span>
  </a>
  <a class="flex items-center gap-3 px-3 py-2.5 rounded hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors" href="<%= request.getContextPath() %>/upload">
    <span class="material-symbols-outlined opacity-70">cloud_upload</span><span class="text-sm font-medium">Upload</span>
  </a>
  <a class="flex items-center gap-3 px-3 py-2.5 rounded hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors" href="<%= request.getContextPath() %>/logout">
    <span class="material-symbols-outlined opacity-70">logout</span><span class="text-sm font-medium">Logout</span>
  </a>
</nav>
<div class="p-6 border-t border-slate-200 dark:border-slate-800">
  <div class="flex justify-between items-center mb-2">
    <span class="text-xs font-semibold uppercase text-slate-500 tracking-wider">Storage Usage</span>
  </div>
  <p class="text-[11px] mt-1 text-slate-500 leading-relaxed"><%= totalStorage %> used</p>
</div>
</aside>
<!-- Main Content Area -->
<div class="flex-1 flex flex-col min-w-0 overflow-hidden relative">
<!-- Top Nav -->
<header class="h-16 bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-slate-800 flex items-center justify-between px-8 shrink-0">
  <div class="max-w-xl w-full"></div>
  <div class="flex items-center gap-3 cursor-pointer">
    <div class="text-right hidden sm:block">
      <p class="text-sm font-semibold leading-none"><%= username %></p>
      <p class="text-xs text-slate-500 mt-1"><%= role %></p>
    </div>
    <div class="w-10 h-10 rounded-lg bg-primary/10 text-primary flex items-center justify-center">
      <span class="material-symbols-outlined">person</span>
    </div>
  </div>
</header>
<!-- Content -->
<main class="flex-1 overflow-y-auto p-8">
<div class="mb-8">
  <h1 class="text-2xl font-bold">Welcome back, <%= username %></h1>
  <p class="text-slate-500 mt-1">Manage your files and share links.</p>
</div>

<% if (paramSuccess != null && !paramSuccess.isEmpty()) { %>
  <div class="mb-6 flex items-center gap-2 text-sm text-emerald-600 bg-emerald-50 p-3 rounded-lg">
    <span class="material-symbols-outlined text-lg">check_circle</span><span><%= paramSuccess %></span>
  </div>
<% } %>
<% if (paramError != null && !paramError.isEmpty()) { %>
  <div class="mb-6 flex items-center gap-2 text-sm text-red-600 bg-red-50 p-3 rounded-lg">
    <span class="material-symbols-outlined text-lg">error</span><span><%= paramError %></span>
  </div>
<% } %>

<!-- Stats -->
<div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6 mb-8">
  <div class="bg-white dark:bg-slate-900 p-6 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm">
    <div class="flex justify-between items-start mb-4">
      <div class="p-2 bg-blue-50 dark:bg-primary/10 text-primary rounded-lg"><span class="material-symbols-outlined">description</span></div>
    </div>
    <p class="text-slate-500 text-sm font-medium">Total Files</p>
    <h3 class="text-2xl font-bold mt-1"><%= totalFiles %></h3>
  </div>
  <div class="bg-white dark:bg-slate-900 p-6 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm">
    <div class="flex justify-between items-start mb-4">
      <div class="p-2 bg-purple-50 dark:bg-purple-500/10 text-purple-600 rounded-lg"><span class="material-symbols-outlined">link</span></div>
    </div>
    <p class="text-slate-500 text-sm font-medium">Active Shares</p>
    <h3 class="text-2xl font-bold mt-1"><%= activeShares %></h3>
  </div>
  <div class="bg-white dark:bg-slate-900 p-6 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm">
    <div class="flex justify-between items-start mb-4">
      <div class="p-2 bg-orange-50 dark:bg-orange-500/10 text-orange-600 rounded-lg"><span class="material-symbols-outlined">database</span></div>
    </div>
    <p class="text-slate-500 text-sm font-medium">Storage Used</p>
    <h3 class="text-2xl font-bold mt-1"><%= totalStorage %></h3>
  </div>
</div>

<!-- Files Table -->
<div class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm overflow-hidden">
  <div class="p-6 border-b border-slate-200 dark:border-slate-800 flex justify-between items-center">
    <h3 class="text-lg font-bold">My Files</h3>
    <a href="<%= request.getContextPath() %>/upload" class="text-sm font-semibold text-primary hover:underline">+ Upload New</a>
  </div>
  <div class="overflow-x-auto">
    <table class="w-full text-left">
      <thead class="bg-slate-50 dark:bg-slate-800/50 text-slate-500 uppercase text-[11px] font-bold tracking-wider">
        <tr><th class="px-6 py-4">Name</th><th class="px-6 py-4">Size</th><th class="px-6 py-4">Uploaded</th><th class="px-6 py-4 text-right">Actions</th></tr>
      </thead>
      <tbody class="divide-y divide-slate-100 dark:divide-slate-800">
        <% if (files != null && !files.isEmpty()) {
            for (FileMetadata f : files) {
                String sizeStr;
                if (f.getFileSize() < 1024) sizeStr = f.getFileSize() + " B";
                else if (f.getFileSize() < 1048576) sizeStr = String.format("%.1f KB", f.getFileSize() / 1024.0);
                else sizeStr = String.format("%.1f MB", f.getFileSize() / 1048576.0);
                String dateStr = f.getUploadDate() != null ? sdf.format(f.getUploadDate()) : "";
        %>
        <tr class="group hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors">
          <td class="px-6 py-4">
            <div class="flex items-center gap-3">
              <div class="p-2 bg-blue-100 text-blue-600 rounded-lg"><span class="material-symbols-outlined text-xl">description</span></div>
              <div>
                <p class="text-sm font-semibold"><%= f.getOriginalFilename() %></p>
                <p class="text-xs text-slate-400"><%= f.getFileType() %></p>
              </div>
            </div>
          </td>
          <td class="px-6 py-4 text-sm text-slate-600 dark:text-slate-400"><%= sizeStr %></td>
          <td class="px-6 py-4 text-sm text-slate-600 dark:text-slate-400"><%= dateStr %></td>
          <td class="px-6 py-4 text-right">
            <div class="flex justify-end gap-1">
              <a href="<%= request.getContextPath() %>/share?fileId=<%= f.getFileId() %>" class="p-2 text-slate-400 hover:text-primary rounded-lg hover:bg-primary/10"><span class="material-symbols-outlined text-lg">share</span></a>
              <a href="<%= request.getContextPath() %>/download?id=<%= f.getFileId() %>" class="p-2 text-slate-400 hover:text-primary rounded-lg hover:bg-primary/10"><span class="material-symbols-outlined text-lg">download</span></a>
              <form action="<%= request.getContextPath() %>/delete" method="POST" style="display:inline;" onsubmit="return confirm('Delete this file?');">
                <input type="hidden" name="fileId" value="<%= f.getFileId() %>"/>
                <button type="submit" class="p-2 text-slate-400 hover:text-red-500 rounded-lg hover:bg-red-500/10"><span class="material-symbols-outlined text-lg">delete</span></button>
              </form>
            </div>
          </td>
        </tr>
        <% } } else { %>
        <tr><td colspan="4" class="px-6 py-12 text-center text-slate-400">
          <span class="material-symbols-outlined text-4xl mb-2 block">cloud_upload</span>
          No files yet. <a href="<%= request.getContextPath() %>/upload" class="text-primary font-semibold hover:underline">Upload your first file</a>
        </td></tr>
        <% } %>
      </tbody>
    </table>
  </div>
</div>
</main>
<!-- FAB -->
<a href="<%= request.getContextPath() %>/upload" class="fixed bottom-8 right-8 w-14 h-14 bg-primary text-white rounded-full shadow-lg hover:bg-primary/90 hover:shadow-xl transition-all flex items-center justify-center group">
  <span class="material-symbols-outlined text-3xl group-hover:rotate-90 transition-transform duration-300">add</span>
</a>
</div>
</div>
</body></html>

