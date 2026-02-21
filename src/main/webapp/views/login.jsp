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
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
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
        <button class="p-2 text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg transition-colors">
            <span class="material-symbols-outlined">help</span>
        </button>
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
                <!-- Login Form -->
                <form action="#" class="space-y-5" method="POST">
                    <!-- Username Field -->
                    <div class="space-y-1.5">
                        <label class="text-sm font-semibold text-slate-700 dark:text-slate-300 ml-1" for="username">Username or Email</label>
                        <div class="relative group">
                            <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400 group-focus-within:text-primary transition-colors">
                                <span class="material-symbols-outlined !text-xl">person</span>
                            </div>
                            <input class="block w-full pl-11 pr-4 py-3 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-lg text-slate-900 dark:text-slate-100 placeholder:text-slate-400 focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all outline-none" id="username" name="username" placeholder="Enter your username" type="text"/>
                            <div class="absolute inset-y-0 right-0 pr-3 flex items-center">
                                <span class="material-symbols-outlined text-emerald-500 !text-xl opacity-0">check_circle</span>
                            </div>
                        </div>
                    </div>
                    <!-- Password Field -->
                    <div class="space-y-1.5">
                        <label class="text-sm font-semibold text-slate-700 dark:text-slate-300 ml-1" for="password">Password</label>
                        <div class="relative group">
                            <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400 group-focus-within:text-primary transition-colors">
                                <span class="material-symbols-outlined !text-xl">lock</span>
                            </div>
                            <input class="block w-full pl-11 pr-11 py-3 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-lg text-slate-900 dark:text-slate-100 placeholder:text-slate-400 focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all outline-none" id="password" name="password" placeholder="••••••••" type="password"/>
                            <button class="absolute inset-y-0 right-0 pr-3.5 flex items-center text-slate-400 hover:text-slate-600 dark:hover:text-slate-300 transition-colors" type="button">
                                <span class="material-symbols-outlined !text-xl">visibility</span>
                            </button>
                        </div>
                        <div class="flex items-center gap-1.5 mt-1 ml-1 text-[11px] font-medium uppercase tracking-wider text-slate-400">
                            <div class="h-1 flex-1 bg-slate-200 dark:bg-slate-700 rounded-full"></div>
                            <div class="h-1 flex-1 bg-slate-200 dark:bg-slate-700 rounded-full"></div>
                            <div class="h-1 flex-1 bg-slate-200 dark:bg-slate-700 rounded-full"></div>
                            <div class="h-1 flex-1 bg-slate-200 dark:bg-slate-700 rounded-full"></div>
                            <span class="ml-1">Strength: N/A</span>
                        </div>
                    </div>
                    <!-- Form Options -->
                    <div class="flex items-center justify-between text-sm py-1">
                        <label class="flex items-center gap-2 cursor-pointer group">
                            <div class="relative flex items-center justify-center">
                                <input class="peer appearance-none w-5 h-5 rounded border-2 border-slate-200 dark:border-slate-700 checked:bg-primary checked:border-primary transition-all cursor-pointer" type="checkbox"/>
                                <span class="material-symbols-outlined absolute text-white !text-sm opacity-0 peer-checked:opacity-100 pointer-events-none">check</span>
                            </div>
                            <span class="text-slate-600 dark:text-slate-400 group-hover:text-slate-900 dark:group-hover:text-slate-200 transition-colors">Remember me</span>
                        </label>
                        <a class="font-semibold text-primary hover:text-primary/80 transition-colors" href="#">Forgot password?</a>
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
                        <span class="bg-white dark:bg-slate-900 px-4 text-slate-400">Trusted Access Only</span>
                    </div>
                </div>
                <!-- Trust Footer -->
<%--                <div class="flex flex-col items-center gap-4 text-center">--%>
<%--                    <div class="flex items-center gap-2 text-emerald-600 dark:text-emerald-400 bg-emerald-50 dark:bg-emerald-500/10 px-4 py-2 rounded-full border border-emerald-100 dark:border-emerald-500/20 text-xs font-medium">--%>
<%--                        <span class="material-symbols-outlined !text-base">lock_open</span>--%>
<%--                        AES-256 End-to-End Encryption Enabled--%>
<%--                    </div>--%>
<%--                    <p class="text-slate-400 dark:text-slate-500 text-xs max-w-[280px]">--%>
<%--                        Protected by industry-leading security protocols. Your connection is private and secure.--%>
<%--                    </p>--%>
<%--                </div>--%>
            </div>
        </div>
        <!-- Bottom Links -->
        <div class="mt-8 flex flex-wrap justify-center gap-x-6 gap-y-2 text-sm font-medium text-slate-500 dark:text-slate-400">
            <a class="hover:text-primary transition-colors" href="#">Privacy Policy</a>
            <a class="hover:text-primary transition-colors" href="#">Terms of Service</a>
            <a class="hover:text-primary transition-colors" href="#">Security Compliance</a>
            <a class="hover:text-primary transition-colors" href="#">Contact Support</a>
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
        <div class="w-px h-4 bg-slate-300 dark:bg-slate-600"></div>
        <div class="flex items-center gap-1 text-[10px] font-bold text-slate-500 dark:text-slate-400 uppercase tracking-[0.2em]">
            <span class="material-symbols-outlined !text-sm">g_translate</span>
            EN
        </div>
    </div>
</footer>
</body></html>