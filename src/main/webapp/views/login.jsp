<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html class="light" lang="en"><head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Secure System Login</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <!-- Material Symbols -->
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
    <!-- Google Fonts: Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#2463eb",
                        "background-light": "#f6f6f8",
                        "background-dark": "#111621",
                    },
                    fontFamily: {
                        "display": ["Inter", "sans-serif"]
                    },
                    borderRadius: {
                        "DEFAULT": "0.5rem",
                        "lg": "1rem",
                        "xl": "1.5rem",
                        "full": "9999px"
                    },
                },
            },
        }
    </script>
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark min-h-screen flex flex-col font-display transition-colors duration-300">
<!-- Top Navigation Bar -->
<header class="w-full px-6 lg:px-10 py-4 flex items-center justify-between border-b border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900/50 backdrop-blur-md">
    <div class="flex items-center gap-3">
        <div class="bg-primary p-2 rounded-lg text-white">
            <span class="material-symbols-outlined !text-2xl">shield_lock</span>
        </div>
        <h2 class="text-slate-900 dark:text-slate-100 text-lg font-bold tracking-tight">SecureShare</h2>
    </div>
    <div class="flex items-center gap-4">
        <div class="hidden md:flex items-center gap-2 px-3 py-1.5 rounded-full bg-emerald-50 dark:bg-emerald-500/10 border border-emerald-100 dark:border-emerald-500/20 text-emerald-600 dark:text-emerald-400 text-xs font-semibold uppercase tracking-wider">
            <span class="material-symbols-outlined !text-sm">verified_user</span>
            HTTPS Secure
        </div>
    </div>
</header>
<main class="flex-1 flex items-center justify-center p-6">
    <div class="w-full max-w-[440px]">
        <!-- Login Card -->
        <div class="bg-white dark:bg-slate-900 shadow-xl shadow-slate-200/50 dark:shadow-none border border-slate-200 dark:border-slate-800 rounded-xl overflow-hidden">
            <div class="p-8">
                <!-- Header -->
                <div class="text-center mb-8">
                    <div class="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-primary/10 text-primary mb-4">
                        <span class="material-symbols-outlined !text-4xl">cloud_upload</span>
                    </div>
                    <h1 class="text-slate-900 dark:text-slate-100 text-2xl font-bold tracking-tight mb-2">Secure File Upload</h1>
                    <p class="text-slate-500 dark:text-slate-400">Enterprise-grade document sharing</p>
                </div>

                <%
                    String error = (String) request.getAttribute("error");
                    String success = (String) request.getAttribute("success");
                %>
                <% if (error != null && !error.isEmpty()) { %>
                    <div class="mb-4 flex items-center gap-2 text-sm text-red-600 bg-red-50 dark:bg-red-900/20 p-3 rounded-lg">
                        <span class="material-symbols-outlined text-lg">error</span><span><%= error %></span>
                    </div>
                <% } %>
                <% if (success != null && !success.isEmpty()) { %>
                    <div class="mb-4 flex items-center gap-2 text-sm text-emerald-600 bg-emerald-50 dark:bg-emerald-900/20 p-3 rounded-lg">
                        <span class="material-symbols-outlined text-lg">check_circle</span><span><%= success %></span>
                    </div>
                <% } %>

                <!-- Login Form -->
                <form action="<%= request.getContextPath() %>/login" class="space-y-5" method="POST">
                    <!-- Username Field -->
                    <div class="space-y-1.5">
                        <label class="text-sm font-semibold text-slate-700 dark:text-slate-300 ml-1" for="username">Username</label>
                        <div class="relative group">
                            <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400 group-focus-within:text-primary transition-colors">
                                <span class="material-symbols-outlined !text-xl">person</span>
                            </div>
                            <input class="block w-full pl-11 pr-4 py-3 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-lg text-slate-900 dark:text-slate-100 placeholder:text-slate-400 focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all outline-none" id="username" name="username" placeholder="Enter your username" type="text" required/>
                        </div>
                    </div>
                    <!-- Password Field -->
                    <div class="space-y-1.5">
                        <label class="text-sm font-semibold text-slate-700 dark:text-slate-300 ml-1" for="password">Password</label>
                        <div class="relative group">
                            <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400 group-focus-within:text-primary transition-colors">
                                <span class="material-symbols-outlined !text-xl">lock</span>
                            </div>
                            <input class="block w-full pl-11 pr-11 py-3 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-lg text-slate-900 dark:text-slate-100 placeholder:text-slate-400 focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all outline-none" id="password" name="password" placeholder="••••••••" type="password" required/>
                        </div>
                    </div>
                    <!-- Submit Button -->
                    <button class="w-full py-3.5 bg-primary hover:bg-primary/90 text-white font-bold rounded-lg shadow-lg shadow-primary/20 active:scale-[0.98] transition-all flex items-center justify-center gap-2" type="submit">
                        <span>Login to Account</span>
                        <span class="material-symbols-outlined !text-xl">login</span>
                    </button>
                </form>
                <!-- Divider -->
                <div class="relative my-8">
                    <div class="absolute inset-0 flex items-center">
                        <div class="w-full border-t border-slate-100 dark:border-slate-800"></div>
                    </div>
                    <div class="relative flex justify-center text-xs uppercase tracking-widest">
                        <span class="bg-white dark:bg-slate-900 px-4 text-slate-400">New here?</span>
                    </div>
                </div>
                <!-- Register Link -->
                <div class="flex flex-col items-center gap-4 text-center">
                    <a href="<%= request.getContextPath() %>/register" class="text-primary font-semibold hover:underline text-sm">Create a new account &rarr;</a>
                    <div class="flex items-center gap-2 text-emerald-600 dark:text-emerald-400 bg-emerald-50 dark:bg-emerald-500/10 px-4 py-2 rounded-full border border-emerald-100 dark:border-emerald-500/20 text-xs font-medium">
                        <span class="material-symbols-outlined !text-base">lock_open</span>
                        AES-256 End-to-End Encryption Enabled
                    </div>
                </div>
            </div>
        </div>
        <!-- Bottom Links -->
        <div class="mt-8 flex flex-wrap justify-center gap-x-6 gap-y-2 text-sm font-medium text-slate-500 dark:text-slate-400">
            <a class="hover:text-primary transition-colors" href="#">Privacy Policy</a>
            <a class="hover:text-primary transition-colors" href="#">Terms of Service</a>
        </div>
    </div>
</main>
<!-- Footer Security Badge -->
<footer class="p-6 text-center">
    <div class="inline-flex items-center gap-4 py-2 px-6 bg-slate-200/50 dark:bg-slate-800/50 rounded-full border border-slate-200 dark:border-slate-700">
        <div class="flex items-center gap-2">
            <span class="w-2 h-2 rounded-full bg-emerald-500 animate-pulse"></span>
            <span class="text-[10px] font-bold text-slate-500 dark:text-slate-400 uppercase tracking-[0.2em]">System Status: Operational</span>
        </div>
    </div>
</footer>
</body></html>

