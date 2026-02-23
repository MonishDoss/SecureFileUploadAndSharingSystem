<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.storage.securefileuploadandsharingsystem.models.FileMetadata" %>
<%@ page import="com.storage.securefileuploadandsharingsystem.models.ShareLink" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en"><head>
<meta charset="utf-8"/><meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Share File - SecureShare</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
<script>
    tailwind.config={darkMode:"class",theme:{extend:{colors:{"primary":"#2463eb","background-light":"#f6f6f8","background-dark":"#111621"},fontFamily:{"display":["Inter","sans-serif"]},borderRadius:{"DEFAULT":"0.5rem","lg":"1rem","xl":"1.5rem","full":"9999px"}}}};
</script>
<style>body{font-family:'Inter',sans-serif;}.material-symbols-outlined{font-variation-settings:'FILL' 0,'wght' 400,'GRAD' 0,'opsz' 24;}</style>
</head>
<body class="font-display bg-background-light dark:bg-background-dark min-h-screen flex items-center justify-center p-4">
<%
    FileMetadata file = (FileMetadata) request.getAttribute("file");
    List<ShareLink> shareLinks = (List<ShareLink>) request.getAttribute("shareLinks");
    String paramSuccess = request.getParameter("success");
    String paramError = request.getParameter("error");
    SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy");
    String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
%>
<div class="w-full max-w-[640px] bg-white dark:bg-slate-900 rounded-xl shadow-2xl overflow-hidden border border-slate-200 dark:border-slate-800">
  <!-- Header -->
  <div class="flex items-center justify-between px-6 py-4 border-b border-slate-100 dark:border-slate-800">
    <div class="flex items-center gap-3">
      <div class="flex items-center justify-center w-10 h-10 rounded-lg bg-primary/10 text-primary"><span class="material-symbols-outlined">description</span></div>
      <div>
        <h2 class="text-lg font-bold text-slate-900 dark:text-slate-100 leading-tight">Share <%= file.getOriginalFilename() %></h2>
        <p class="text-sm text-slate-500 dark:text-slate-400">Securely manage access and distribution</p>
      </div>
    </div>
    <a href="<%= request.getContextPath() %>/dashboard" class="p-2 text-slate-400 hover:text-slate-600 transition-colors"><span class="material-symbols-outlined">close</span></a>
  </div>

  <% if (paramSuccess != null && !paramSuccess.isEmpty()) { %>
    <div class="mx-6 mt-4 flex items-center gap-2 text-sm text-emerald-600 bg-emerald-50 p-3 rounded-lg">
      <span class="material-symbols-outlined text-lg">check_circle</span><span><%= paramSuccess %></span>
    </div>
  <% } %>
  <% if (paramError != null && !paramError.isEmpty()) { %>
    <div class="mx-6 mt-4 flex items-center gap-2 text-sm text-red-600 bg-red-50 p-3 rounded-lg">
      <span class="material-symbols-outlined text-lg">error</span><span><%= paramError %></span>
    </div>
  <% } %>

  <!-- Create new share form -->
  <form action="<%= request.getContextPath() %>/share" method="POST">
    <input type="hidden" name="fileId" value="<%= file.getFileId() %>"/>
    <div class="max-h-[60vh] overflow-y-auto px-6 py-6 space-y-6">
      <section>
        <h3 class="text-sm font-bold uppercase tracking-wider text-slate-400 mb-4">Security Settings</h3>
        <div class="space-y-4">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div class="space-y-1.5">
              <label class="text-xs font-semibold text-slate-700 dark:text-slate-300 ml-1">Password (Optional)</label>
              <div class="relative">
                <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-[18px]">key</span>
                <input name="sharePassword" class="w-full pl-10 pr-4 py-2.5 bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-700 rounded-lg text-sm focus:ring-2 focus:ring-primary/20 focus:border-primary" placeholder="Set a password" type="password"/>
              </div>
            </div>
            <div class="space-y-1.5">
              <label class="text-xs font-semibold text-slate-700 dark:text-slate-300 ml-1">Expiration Date</label>
              <div class="relative">
                <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-[18px]">calendar_today</span>
                <input name="expiresAt" class="w-full pl-10 pr-4 py-2.5 bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-700 rounded-lg text-sm focus:ring-2 focus:ring-primary/20 focus:border-primary" type="date"/>
              </div>
            </div>
          </div>
          <div class="flex items-center justify-between p-4 rounded-lg border border-slate-100 dark:border-slate-800">
            <div class="flex items-center gap-4">
              <div class="flex items-center justify-center w-10 h-10 rounded-lg bg-slate-50 dark:bg-slate-800 text-slate-600"><span class="material-symbols-outlined">download</span></div>
              <div><p class="text-sm font-semibold text-slate-900">Download Limit</p><p class="text-xs text-slate-500">Max downloads before link expires</p></div>
            </div>
            <div class="flex items-center gap-2">
              <input name="maxDownloads" class="w-20 px-3 py-1.5 bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-700 rounded-lg text-sm text-center focus:ring-2 focus:ring-primary/20 focus:border-primary" type="number" placeholder="&#8734;"/>
              <span class="text-xs font-medium text-slate-500">uses</span>
            </div>
          </div>
        </div>
      </section>

      <!-- Active shares -->
      <% if (shareLinks != null && !shareLinks.isEmpty()) { %>
      <section>
        <div class="flex items-center justify-between mb-4">
          <h3 class="text-sm font-bold uppercase tracking-wider text-slate-400">Active Shares</h3>
          <span class="px-2 py-0.5 rounded-full bg-primary/10 text-primary text-[10px] font-bold"><%= shareLinks.size() %> LINKS</span>
        </div>
        <div class="space-y-3">
          <% for (ShareLink sl : shareLinks) {
              String shareUrl = baseUrl + "/share/access/" + sl.getShareToken();
          %>
          <div class="group flex items-center justify-between p-3 rounded-lg border border-slate-100 dark:border-slate-800">
            <div class="flex items-center gap-3 overflow-hidden">
              <div class="shrink-0 w-8 h-8 rounded-full bg-slate-100 flex items-center justify-center text-slate-500"><span class="material-symbols-outlined text-[18px]">public</span></div>
              <div class="overflow-hidden">
                <p class="text-sm font-medium text-slate-900 truncate"><%= shareUrl %></p>
                <p class="text-xs text-slate-500">Downloads: <%= sl.getDownloadCount() %><% if (sl.getMaxDownloads() != null) { %> / <%= sl.getMaxDownloads() %><% } %>
                  <% if (sl.getExpiresAt() != null) { %> &bull; Expires: <%= sdf.format(sl.getExpiresAt()) %><% } %>
                  &bull; <% if (sl.isActive()) { %><span class="text-emerald-600">Active</span><% } else { %><span class="text-red-500">Revoked</span><% } %>
                </p>
              </div>
            </div>
            <div class="flex items-center gap-2">
              <button type="button" onclick="copyLink('<%= shareUrl %>')" class="p-2 rounded-lg text-slate-400 hover:text-primary hover:bg-primary/5"><span class="material-symbols-outlined text-[20px]">content_copy</span></button>
              <% if (sl.isActive()) { %>
              <a href="<%= request.getContextPath() %>/share/revoke?shareId=<%= sl.getShareId() %>&fileId=<%= file.getFileId() %>" class="px-3 py-1.5 text-xs font-bold text-red-500 hover:bg-red-50 rounded-lg" onclick="return confirm('Revoke this link?');">Revoke</a>
              <% } %>
            </div>
          </div>
          <% } %>
        </div>
      </section>
      <% } %>
    </div>
    <!-- Footer -->
    <div class="p-6 bg-slate-50 dark:bg-slate-800/30 flex items-center justify-between gap-4">
      <a href="<%= request.getContextPath() %>/dashboard" class="text-sm font-bold text-slate-500 hover:text-slate-700">Back to Dashboard</a>
      <button type="submit" class="px-6 py-3 bg-primary text-white text-sm font-bold rounded-lg hover:opacity-90 transition-all flex items-center gap-2 shadow-lg shadow-primary/20">
        Generate New Link <span class="material-symbols-outlined text-[18px]">add</span>
      </button>
    </div>
  </form>
</div>
<script>
function copyLink(url) {
  navigator.clipboard.writeText(url).then(function() { alert('Link copied!'); });
}
</script>
</body></html>

