<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html class="light" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>SecureShare - Secure File Sharing Platform</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
<script>
    tailwind.config={darkMode:"class",theme:{extend:{colors:{"primary":"#2463eb","accent-success":"#10B981","background-light":"#f6f6f8","background-dark":"#111621"},fontFamily:{"display":["Inter","sans-serif"]},borderRadius:{"DEFAULT":"0.5rem","lg":"1rem","xl":"1.5rem","full":"9999px"}}}};
</script>
<style>body{font-family:'Inter',sans-serif;}.material-symbols-outlined{font-variation-settings:'FILL' 0,'wght' 400,'GRAD' 0,'opsz' 24;}</style>
</head>
<body class="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-slate-100 antialiased">
<!-- Top Navigation -->
<header class="sticky top-0 z-50 w-full bg-white/80 dark:bg-background-dark/80 backdrop-blur-md border-b border-slate-200 dark:border-slate-800">
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
<div class="flex justify-between items-center h-16">
  <div class="flex items-center gap-2">
    <div class="bg-primary text-white p-1.5 rounded-lg flex items-center justify-center"><span class="material-symbols-outlined text-2xl">shield_lock</span></div>
    <span class="text-xl font-bold tracking-tight text-slate-900 dark:text-white">SecureShare</span>
  </div>
  <nav class="hidden md:flex items-center gap-8">
    <a class="text-sm font-medium text-slate-600 hover:text-primary transition-colors" href="#features">Features</a>
    <a class="text-sm font-medium text-slate-600 hover:text-primary transition-colors" href="#how-it-works">How it Works</a>
  </nav>
  <div class="flex items-center gap-3">
    <a href="${pageContext.request.contextPath}/login" class="px-4 py-2 text-sm font-bold text-slate-700 hover:bg-slate-100 rounded-lg transition-all">Login</a>
    <a href="${pageContext.request.contextPath}/register" class="px-5 py-2 text-sm font-bold bg-primary text-white hover:bg-primary/90 rounded-lg transition-all shadow-lg shadow-primary/20">Get Started</a>
  </div>
</div>
</div>
</header>

<main>
<!-- Hero Section -->
<section class="relative overflow-hidden pt-16 pb-20 lg:pt-24 lg:pb-32">
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
<div class="grid lg:grid-cols-2 gap-12 items-center">
  <div class="relative z-10 flex flex-col gap-8">
    <div class="inline-flex items-center gap-2 bg-primary/10 border border-primary/20 text-primary px-3 py-1 rounded-full text-xs font-bold tracking-wide uppercase w-fit">
      <span class="material-symbols-outlined text-sm leading-none">verified_user</span> Trusted &amp; Secure
    </div>
    <h1 class="text-5xl md:text-6xl font-black text-slate-900 dark:text-white leading-[1.1] tracking-tight">
      Secure File Sharing <span class="text-primary">Made Simple</span>
    </h1>
    <p class="text-lg md:text-xl text-slate-600 dark:text-slate-400 leading-relaxed max-w-xl">
      Protect your sensitive data with enterprise-grade encryption and granular access controls. Upload, share, and manage files with confidence.
    </p>
    <div class="flex flex-col sm:flex-row gap-4">
      <a href="${pageContext.request.contextPath}/register" class="px-8 py-4 bg-primary text-white text-lg font-bold rounded-xl hover:bg-primary/90 transition-all shadow-xl shadow-primary/25 flex items-center justify-center gap-2">
        Get Started Free <span class="material-symbols-outlined">arrow_forward</span>
      </a>
      <a href="${pageContext.request.contextPath}/login" class="px-8 py-4 bg-white dark:bg-slate-800 text-slate-900 dark:text-white border border-slate-200 dark:border-slate-700 text-lg font-bold rounded-xl hover:bg-slate-50 transition-all flex items-center justify-center gap-2">
        <span class="material-symbols-outlined">login</span> Sign In
      </a>
    </div>
  </div>
  <div class="relative">
    <div class="absolute inset-0 bg-primary/10 blur-[100px] rounded-full"></div>
    <div class="relative bg-white dark:bg-slate-800 rounded-2xl shadow-2xl border border-slate-100 dark:border-slate-700 p-4 aspect-[4/3] flex items-center justify-center overflow-hidden">
      <div class="w-full h-full bg-slate-50 dark:bg-slate-900 rounded-lg border border-dashed border-slate-300 dark:border-slate-600 flex flex-col items-center justify-center gap-4">
        <div class="size-20 bg-primary/20 text-primary rounded-full flex items-center justify-center">
          <span class="material-symbols-outlined text-4xl">cloud_upload</span>
        </div>
        <p class="text-slate-400 dark:text-slate-500 font-medium">Drag &amp; drop files to encrypt</p>
        <div class="w-3/4 h-2 bg-slate-200 dark:bg-slate-700 rounded-full overflow-hidden"><div class="w-2/3 h-full bg-primary"></div></div>
      </div>
    </div>
  </div>
</div>
</div>
</section>

<!-- Features Section -->
<section id="features" class="py-20 bg-slate-50 dark:bg-slate-900/50">
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
  <div class="text-center max-w-3xl mx-auto mb-16">
    <h2 class="text-3xl md:text-4xl font-black text-slate-900 dark:text-white mb-4 tracking-tight">Enterprise-Grade Security</h2>
    <p class="text-slate-600 dark:text-slate-400 text-lg">Built on three pillars of security to ensure your data remains confidential and under your control.</p>
  </div>
  <div class="grid md:grid-cols-3 gap-8">
    <div class="bg-white dark:bg-slate-800 p-8 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm hover:shadow-xl transition-all group">
      <div class="size-14 bg-primary/10 text-primary rounded-xl flex items-center justify-center mb-6 group-hover:bg-primary group-hover:text-white transition-colors">
        <span class="material-symbols-outlined text-3xl">encrypted</span>
      </div>
      <h3 class="text-xl font-bold text-slate-900 dark:text-white mb-3">Per-User Storage</h3>
      <p class="text-slate-600 dark:text-slate-400 leading-relaxed">Each user gets their own isolated storage folder. Files are organized and protected at the system level.</p>
    </div>
    <div class="bg-white dark:bg-slate-800 p-8 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm hover:shadow-xl transition-all group">
      <div class="size-14 bg-accent-success/10 text-accent-success rounded-xl flex items-center justify-center mb-6 group-hover:bg-accent-success group-hover:text-white transition-colors">
        <span class="material-symbols-outlined text-3xl">key</span>
      </div>
      <h3 class="text-xl font-bold text-slate-900 dark:text-white mb-3">Controlled Sharing</h3>
      <p class="text-slate-600 dark:text-slate-400 leading-relaxed">Set custom passwords, expiration dates, and download limits for every link. Revoke access instantly.</p>
    </div>
    <div class="bg-white dark:bg-slate-800 p-8 rounded-2xl border border-slate-200 dark:border-slate-700 shadow-sm hover:shadow-xl transition-all group">
      <div class="size-14 bg-primary/10 text-primary rounded-xl flex items-center justify-center mb-6 group-hover:bg-primary group-hover:text-white transition-colors">
        <span class="material-symbols-outlined text-3xl">visibility</span>
      </div>
      <h3 class="text-xl font-bold text-slate-900 dark:text-white mb-3">Access Tracking</h3>
      <p class="text-slate-600 dark:text-slate-400 leading-relaxed">Real-time audit logs of who viewed, downloaded, or accessed your files. Full IP tracking included.</p>
    </div>
  </div>
</div>
</section>

<!-- How it Works -->
<section id="how-it-works" class="py-20 lg:py-32 bg-white dark:bg-background-dark">
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
<div class="flex flex-col lg:flex-row gap-16 items-center">
  <div class="lg:w-1/2">
    <h2 class="text-3xl md:text-4xl font-black text-slate-900 dark:text-white mb-12 tracking-tight">How it Works</h2>
    <div class="space-y-12">
      <div class="flex gap-6 relative">
        <div class="flex flex-col items-center">
          <div class="size-10 bg-primary text-white rounded-full flex items-center justify-center font-bold z-10">1</div>
          <div class="w-px h-full bg-slate-200 dark:bg-slate-700 absolute top-10"></div>
        </div>
        <div>
          <h4 class="text-xl font-bold text-slate-900 dark:text-white mb-2">Upload Files</h4>
          <p class="text-slate-600 dark:text-slate-400 leading-relaxed">Upload your documents to your personal secure vault. Each user has their own dedicated storage folder.</p>
        </div>
      </div>
      <div class="flex gap-6 relative">
        <div class="flex flex-col items-center">
          <div class="size-10 bg-primary text-white rounded-full flex items-center justify-center font-bold z-10">2</div>
          <div class="w-px h-full bg-slate-200 dark:bg-slate-700 absolute top-10"></div>
        </div>
        <div>
          <h4 class="text-xl font-bold text-slate-900 dark:text-white mb-2">Configure Security</h4>
          <p class="text-slate-600 dark:text-slate-400 leading-relaxed">Define who can access the file. Set expiration times, download limits, and password protection.</p>
        </div>
      </div>
      <div class="flex gap-6">
        <div class="flex flex-col items-center">
          <div class="size-10 bg-primary text-white rounded-full flex items-center justify-center font-bold z-10">3</div>
        </div>
        <div>
          <h4 class="text-xl font-bold text-slate-900 dark:text-white mb-2">Share Instantly</h4>
          <p class="text-slate-600 dark:text-slate-400 leading-relaxed">Generate a secure link. Monitor access in real-time and revoke permissions with a single click.</p>
        </div>
      </div>
    </div>
  </div>
  <div class="lg:w-1/2 relative w-full">
    <div class="aspect-square bg-slate-50 dark:bg-slate-900 rounded-3xl p-8 flex items-center justify-center relative border border-slate-100 dark:border-slate-800">
      <div class="absolute inset-0 bg-primary/5 rounded-3xl animate-pulse"></div>
      <div class="flex flex-col items-center gap-12 relative z-10">
        <div class="size-24 bg-white dark:bg-slate-800 shadow-xl rounded-2xl flex items-center justify-center">
          <span class="material-symbols-outlined text-4xl text-primary">description</span>
        </div>
        <div class="flex items-center gap-4">
          <div class="w-12 h-1 bg-primary rounded-full"></div>
          <span class="material-symbols-outlined text-primary text-2xl">lock</span>
          <div class="w-12 h-1 bg-primary rounded-full"></div>
        </div>
        <div class="size-24 bg-white dark:bg-slate-800 shadow-xl rounded-2xl flex items-center justify-center">
          <span class="material-symbols-outlined text-4xl text-accent-success">person</span>
        </div>
      </div>
    </div>
  </div>
</div>
</div>
</section>

<!-- CTA Section -->
<section class="py-20">
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
  <div class="bg-primary rounded-[2rem] p-10 lg:p-16 text-center text-white relative overflow-hidden shadow-2xl shadow-primary/30">
    <div class="absolute top-0 right-0 -mr-16 -mt-16 size-64 bg-white/10 rounded-full blur-3xl"></div>
    <div class="absolute bottom-0 left-0 -ml-16 -mb-16 size-64 bg-white/10 rounded-full blur-3xl"></div>
    <h2 class="text-3xl lg:text-5xl font-black mb-6 relative z-10">Ready to secure your files?</h2>
    <p class="text-lg lg:text-xl mb-10 max-w-2xl mx-auto opacity-90 relative z-10">
      Start uploading and sharing files securely today. No credit card required.
    </p>
    <div class="flex flex-col sm:flex-row justify-center gap-4 relative z-10">
      <a href="${pageContext.request.contextPath}/register" class="px-8 py-4 bg-white text-primary text-lg font-bold rounded-xl hover:bg-slate-50 transition-all shadow-lg">Get Started Now</a>
      <a href="${pageContext.request.contextPath}/login" class="px-8 py-4 bg-primary/20 border border-white/30 text-white text-lg font-bold rounded-xl hover:bg-primary/30 transition-all">Sign In</a>
    </div>
  </div>
</div>
</section>
</main>

<!-- Footer -->
<footer class="bg-slate-950 text-slate-400 py-16 border-t border-slate-900">
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
  <div class="flex flex-col md:flex-row justify-between items-center gap-8">
    <div class="flex items-center gap-2 text-white">
      <span class="material-symbols-outlined text-2xl text-primary">shield_lock</span>
      <span class="text-xl font-bold tracking-tight">SecureShare</span>
    </div>
    <div class="flex items-center gap-6 text-sm">
      <a class="hover:text-primary transition-colors" href="#">Privacy Policy</a>
      <a class="hover:text-primary transition-colors" href="#">Terms</a>
      <span class="flex items-center gap-1"><span class="material-symbols-outlined text-xs text-accent-success">fiber_manual_record</span> System Operational</span>
    </div>
  </div>
  <div class="mt-8 pt-8 border-t border-slate-900 text-center text-xs">
    <p>&copy; 2024 SecureShare Inc. All rights reserved.</p>
  </div>
</div>
</footer>
</body></html>

