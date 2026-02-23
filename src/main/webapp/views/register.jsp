<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html class="light" lang="en"><head>
  <meta charset="utf-8"/>
  <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
  <title>Account Registration | SecureShare</title>
  <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
  <script>
    tailwind.config = { darkMode:"class", theme:{ extend:{
      colors:{"primary":"#2463eb","background-light":"#f6f6f8","background-dark":"#111621"},
      fontFamily:{"display":["Inter","sans-serif"]},
      borderRadius:{"DEFAULT":"0.5rem","lg":"1rem","xl":"1.5rem","full":"9999px"},
    }}}
  </script>
  <style>body{font-family:'Inter',sans-serif;}.material-symbols-outlined{font-variation-settings:'FILL' 0,'wght' 400,'GRAD' 0,'opsz' 24;}</style>
</head>
<body class="bg-background-light dark:bg-background-dark min-h-screen flex flex-col font-display text-slate-900 dark:text-slate-100">
<header class="w-full bg-white dark:bg-background-dark border-b border-slate-200 dark:border-slate-800 px-6 py-4">
  <div class="max-w-7xl mx-auto flex items-center justify-between">
    <div class="flex items-center gap-2">
      <div class="w-8 h-8 bg-primary rounded-lg flex items-center justify-center text-white"><span class="material-symbols-outlined text-xl">shield_lock</span></div>
      <h1 class="text-xl font-bold tracking-tight">SecureShare <span class="text-primary">Enterprise</span></h1>
    </div>
    <div class="hidden md:flex items-center gap-8">
      <a class="text-sm font-semibold hover:text-primary transition-colors" href="<%= request.getContextPath() %>/login">Sign In</a>
    </div>
  </div>
</header>
<main class="flex-1 flex items-center justify-center p-6 md:p-12">
  <div class="w-full max-w-2xl bg-white dark:bg-slate-900 rounded-xl shadow-xl border border-slate-200 dark:border-slate-800 overflow-hidden">
    <div class="p-8 border-b border-slate-100 dark:border-slate-800 bg-slate-50/50 dark:bg-slate-800/50">
      <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h2 class="text-2xl font-bold">Create Your Account</h2>
          <p class="text-slate-500 dark:text-slate-400 text-sm mt-1">Join our enterprise-grade secure file sharing platform.</p>
        </div>
      </div>
    </div>
    <form class="p-8 space-y-6" action="<%= request.getContextPath() %>/register" method="POST">
      <% String error = (String) request.getAttribute("error"); %>
      <% if (error != null && !error.isEmpty()) { %>
        <div class="flex items-center gap-2 text-sm text-red-500 bg-red-50 dark:bg-red-900/20 p-3 rounded-lg">
          <span class="material-symbols-outlined text-lg">error</span><span><%= error %></span>
        </div>
      <% } %>
      <%
        String paramUsername = request.getParameter("username");
        String paramEmail = request.getParameter("email");
        if (paramUsername == null) paramUsername = "";
        if (paramEmail == null) paramEmail = "";
      %>
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div class="space-y-2">
          <label class="text-sm font-semibold" for="username">Username</label>
          <input class="w-full px-4 py-3 rounded-lg border border-slate-200 dark:border-slate-700 bg-transparent focus:ring-2 focus:ring-primary focus:border-primary outline-none transition-all placeholder:text-slate-400" id="username" name="username" placeholder="johndoe" type="text" required value="<%= paramUsername %>"/>
        </div>
        <div class="space-y-2">
          <label class="text-sm font-semibold" for="email">Email Address</label>
          <input class="w-full px-4 py-3 rounded-lg border border-slate-200 dark:border-slate-700 bg-transparent focus:ring-2 focus:ring-primary focus:border-primary outline-none transition-all placeholder:text-slate-400" id="email" name="email" placeholder="name@company.com" type="email" required value="<%= paramEmail %>"/>
        </div>
      </div>
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div class="space-y-2">
          <label class="text-sm font-semibold" for="password">Password</label>
          <input class="w-full px-4 py-3 rounded-lg border border-slate-200 dark:border-slate-700 bg-transparent focus:ring-2 focus:ring-primary focus:border-primary outline-none transition-all placeholder:text-slate-400" id="password" name="password" placeholder="Min 8 characters" type="password" required/>
        </div>
        <div class="space-y-2">
          <label class="text-sm font-semibold" for="confirmPassword">Confirm Password</label>
          <input class="w-full px-4 py-3 rounded-lg border border-slate-200 dark:border-slate-700 bg-transparent focus:ring-2 focus:ring-primary focus:border-primary outline-none transition-all placeholder:text-slate-400" id="confirmPassword" name="confirmPassword" placeholder="Re-enter password" type="password" required/>
        </div>
      </div>
      <div class="space-y-2 p-4 bg-slate-50 dark:bg-slate-800/50 rounded-lg">
        <span class="text-xs font-medium text-slate-500">Password Requirements:</span>
        <ul class="grid grid-cols-2 gap-x-4 gap-y-1 mt-2">
          <li class="flex items-center gap-2 text-[11px] text-slate-500"><span class="material-symbols-outlined text-[14px]">check_circle</span> At least 8 characters</li>
          <li class="flex items-center gap-2 text-[11px] text-slate-500"><span class="material-symbols-outlined text-[14px]">check_circle</span> Upper &amp; Lowercase</li>
          <li class="flex items-center gap-2 text-[11px] text-slate-500"><span class="material-symbols-outlined text-[14px]">check_circle</span> Numbers &amp; Symbols</li>
          <li class="flex items-center gap-2 text-[11px] text-slate-500"><span class="material-symbols-outlined text-[14px]">check_circle</span> Passwords must match</li>
        </ul>
      </div>
      <div class="pt-4">
        <button class="w-full bg-primary hover:bg-primary/90 text-white font-bold py-4 rounded-xl shadow-lg shadow-primary/20 transition-all active:scale-[0.98] flex items-center justify-center gap-2" type="submit">
          Create Account <span class="material-symbols-outlined text-lg">arrow_forward</span>
        </button>
        <p class="text-center mt-6 text-sm text-slate-500 dark:text-slate-400">
          Already have an account? <a class="text-primary font-semibold hover:underline" href="<%= request.getContextPath() %>/login">Log in here</a>
        </p>
      </div>
    </form>
  </div>
</main>
<footer class="w-full py-8 px-6 text-center text-slate-400 text-xs border-t border-slate-200 dark:border-slate-800 bg-white dark:bg-background-dark">
  <p>&copy; 2024 SecureShare Enterprise Inc. All rights reserved.</p>
</footer>
</body></html>

