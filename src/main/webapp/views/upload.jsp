<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html class="light" lang="en"><head>
<meta charset="utf-8"/><meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Secure File Upload | SecureShare</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
<script>
    tailwind.config={darkMode:"class",theme:{extend:{colors:{"primary":"#2463eb","background-light":"#f6f6f8","background-dark":"#111621"},fontFamily:{"display":["Inter","sans-serif"]},borderRadius:{"DEFAULT":"0.5rem","lg":"1rem","xl":"1.5rem","full":"9999px"}}}};
</script>
<style>.material-symbols-outlined{font-variation-settings:'FILL' 0,'wght' 400,'GRAD' 0,'opsz' 24;}body{font-family:'Inter',sans-serif;}</style>
</head>
<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen font-display">
<%
    String username = (String) session.getAttribute("username");
    String error = (String) request.getAttribute("error");
%>
<header class="sticky top-0 z-50 w-full border-b border-slate-200 dark:border-slate-800 bg-white/80 dark:bg-background-dark/80 backdrop-blur-md">
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
  <div class="flex h-16 items-center justify-between">
    <div class="flex items-center gap-8">
      <div class="flex items-center gap-3">
        <div class="bg-primary p-2 rounded-lg flex items-center justify-center text-white"><span class="material-symbols-outlined text-2xl">shield_lock</span></div>
        <h1 class="text-xl font-bold tracking-tight text-slate-900 dark:text-white">SecureShare</h1>
      </div>
      <nav class="hidden md:flex items-center gap-6">
        <a class="text-sm font-medium text-slate-600 dark:text-slate-400 hover:text-primary transition-colors" href="<%= request.getContextPath() %>/dashboard">Dashboard</a>
        <a class="text-sm font-medium text-primary underline underline-offset-8 decoration-2" href="<%= request.getContextPath() %>/upload">Upload</a>
      </nav>
    </div>
    <div class="flex items-center gap-4">
      <span class="text-sm font-medium text-slate-600"><%= username %></span>
      <a href="<%= request.getContextPath() %>/logout" class="text-sm text-slate-500 hover:text-red-500"><span class="material-symbols-outlined">logout</span></a>
    </div>
  </div>
</div>
</header>
<main class="max-w-4xl mx-auto px-4 py-12">
<div class="mb-8">
  <h2 class="text-3xl font-black text-slate-900 dark:text-white mb-2">Secure File Upload</h2>
  <p class="text-slate-600 dark:text-slate-400">Add files to your vault. All uploads are encrypted end-to-end.</p>
</div>

<% if (error != null && !error.isEmpty()) { %>
  <div class="mb-6 flex items-center gap-2 text-sm text-red-600 bg-red-50 p-3 rounded-lg">
    <span class="material-symbols-outlined text-lg">error</span><span><%= error %></span>
  </div>
<% } %>

<form action="<%= request.getContextPath() %>/upload" method="POST" enctype="multipart/form-data" id="uploadForm">
<div class="grid gap-8">
  <!-- Dropzone -->
  <div class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm overflow-hidden">
    <div class="p-8">
      <label for="fileInput" class="group relative flex flex-col items-center justify-center border-2 border-dashed border-slate-300 dark:border-slate-700 hover:border-primary dark:hover:border-primary rounded-xl py-16 transition-all bg-slate-50 dark:bg-slate-800/50 cursor-pointer">
        <div class="bg-primary/10 text-primary p-4 rounded-full mb-4 group-hover:scale-110 transition-transform">
          <span class="material-symbols-outlined text-4xl">cloud_upload</span>
        </div>
        <h3 class="text-lg font-bold text-slate-900 dark:text-white mb-1">Drag and drop files here</h3>
        <p class="text-sm text-slate-500 dark:text-slate-400 mb-6 text-center max-w-xs">Or click to browse. Supported formats: PDF, PNG, JPG, DOCX, ZIP (Max 50MB).</p>
        <span class="px-6 py-2.5 bg-white dark:bg-slate-700 border border-slate-200 dark:border-slate-600 text-slate-700 dark:text-slate-200 font-semibold rounded-lg shadow-sm">Select Files</span>
        <input type="file" id="fileInput" name="file" class="hidden" required onchange="showFileName(this)"/>
      </label>
      <div id="selectedFile" class="mt-4 hidden px-8 py-4 flex items-center gap-4 bg-slate-50 dark:bg-slate-800/50 rounded-lg">
        <div class="size-12 rounded-lg bg-blue-100 text-blue-600 flex items-center justify-center shrink-0"><span class="material-symbols-outlined text-2xl">description</span></div>
        <div class="flex-1 min-w-0">
          <span id="fileName" class="text-sm font-semibold text-slate-900 dark:text-white truncate block"></span>
          <span id="fileSize" class="text-xs text-slate-500"></span>
        </div>
      </div>
    </div>
  </div>
  <!-- Upload Details -->
  <div class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm p-8">
    <h3 class="text-lg font-bold text-slate-900 dark:text-white mb-6 flex items-center gap-2">
      <span class="material-symbols-outlined text-primary">settings</span> Upload Details
    </h3>
    <div class="space-y-6">
      <div>
        <label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-2" for="description">Description (Optional)</label>
        <textarea class="w-full rounded-lg border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 focus:border-primary focus:ring-primary text-sm" id="description" name="description" placeholder="Provide context about this file..." rows="3"></textarea>
      </div>
    </div>
  </div>
  <!-- Actions -->
  <div class="flex items-center justify-end gap-4">
    <a href="<%= request.getContextPath() %>/dashboard" class="px-8 py-3 text-slate-600 dark:text-slate-400 font-bold hover:text-slate-900 transition-colors">Cancel</a>
    <button type="submit" class="px-10 py-3 bg-primary text-white font-bold rounded-xl shadow-lg shadow-primary/20 hover:bg-blue-700 transition-all flex items-center gap-2">
      <span class="material-symbols-outlined text-xl">upload</span> Upload File
    </button>
  </div>
</div>
</form>
</main>
<script>
function showFileName(input) {
  if (input.files && input.files[0]) {
    var f = input.files[0];
    document.getElementById('selectedFile').classList.remove('hidden');
    document.getElementById('fileName').textContent = f.name;
    var size = f.size < 1024 ? f.size + ' B' : f.size < 1048576 ? (f.size/1024).toFixed(1)+' KB' : (f.size/1048576).toFixed(1)+' MB';
    document.getElementById('fileSize').textContent = size;
  }
}
</script>
</body></html>

