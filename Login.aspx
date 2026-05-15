<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="KMC_ClientApp.Login" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <title>Login — KMC Events Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Source+Sans+3:wght@300;400;500;600&display=swap" rel="stylesheet" />
    <style>
        :root {
            --navy:       #0D2340;
            --navy-mid:   #163562;
            --navy-light: #1E4A87;
            --gold:       #C49A28;
            --gold-light: #E8B93A;
            --cream:      #F7F4EF;
            --white:      #FFFFFF;
            --text-dark:  #1A1A2E;
            --text-mid:   #3D4A5C;
            --text-muted: #7A8699;
            --border:     #D9DFE8;
            --danger:     #8B1A1A;
            --danger-bg:  #FAF0F0;
            --shadow-sm:  0 2px 8px rgba(13,35,64,0.08);
            --shadow-md:  0 6px 24px rgba(13,35,64,0.13);
            --shadow-lg:  0 20px 60px rgba(13,35,64,0.22);
            --radius:     8px;
            --radius-lg:  14px;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Source Sans 3', sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background: var(--cream);
        }

        /* ── UTILITY BAR ── */
        .utility-bar {
            background: var(--navy);
            color: rgba(255,255,255,0.65);
            font-size: 12.5px;
            letter-spacing: 0.03em;
            padding: 6px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-shrink: 0;
        }
        .utility-bar a {
            color: rgba(255,255,255,0.65);
            text-decoration: none;
            transition: color 0.2s;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .utility-bar a:hover { color: var(--gold-light); }

        /* ── SPLIT LAYOUT ── */
        .login-wrapper {
            flex: 1;
            display: flex;
            min-height: calc(100vh - 88px);
        }

        /* LEFT PANEL */
        .login-left {
            width: 42%;
            background: linear-gradient(160deg, var(--navy) 0%, var(--navy-mid) 55%, var(--navy-light) 100%);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 50px 48px;
            position: relative;
            overflow: hidden;
            flex-shrink: 0;
        }
        .login-left::before {
            content: '';
            position: absolute;
            inset: 0;
            background: url("data:image/svg+xml,%3Csvg width='80' height='80' viewBox='0 0 80 80' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.03'%3E%3Cpath d='M50 50v-6h-3v6h-6v3h6v6h3v-6h6v-3h-6zm0-44V0h-3v6h-6v3h6v6h3V9h6V6h-6zM6 50v-6H3v6H0v3h3v6h3v-6h6v-3H6zM6 6V0H3v6H0v3h3v6h3V9h6V6H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E") repeat;
            pointer-events: none;
        }
        /* decorative circle */
        .login-left::after {
            content: '';
            position: absolute;
            bottom: -80px;
            right: -80px;
            width: 340px;
            height: 340px;
            border-radius: 50%;
            background: rgba(196,154,40,0.08);
            border: 60px solid rgba(196,154,40,0.06);
        }

        .left-logo {
            display: flex;
            align-items: center;
            gap: 16px;
            position: relative;
            z-index: 1;
        }
        .logo-emblem {
            width: 56px; height: 56px;
            background: var(--gold);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-family: 'Playfair Display', serif;
            font-size: 20px; font-weight: 700;
            color: var(--navy);
            box-shadow: 0 0 0 4px rgba(196,154,40,0.25);
            flex-shrink: 0;
        }
        .left-logo-text .org-name {
            font-family: 'Playfair Display', serif;
            font-size: 18px; font-weight: 700;
            color: var(--white); line-height: 1.2;
        }
        .left-logo-text .org-sub {
            font-size: 11px; color: var(--gold-light);
            letter-spacing: 0.12em; text-transform: uppercase;
            font-weight: 500; margin-top: 3px;
        }

        .left-content {
            position: relative;
            z-index: 1;
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 40px 0;
        }
        .left-content .gold-bar {
            width: 40px; height: 4px;
            background: var(--gold);
            border-radius: 2px;
            margin-bottom: 22px;
        }
        .left-content h2 {
            font-family: 'Playfair Display', serif;
            font-size: 32px; font-weight: 700;
            color: var(--white);
            line-height: 1.3;
            margin-bottom: 16px;
        }
        .left-content p {
            font-size: 15px;
            color: rgba(255,255,255,0.6);
            line-height: 1.7;
            max-width: 320px;
        }

        .left-features {
            position: relative;
            z-index: 1;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        .feature-item {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 13.5px;
            color: rgba(255,255,255,0.7);
        }
        .feature-item .fi-icon {
            width: 32px; height: 32px;
            background: rgba(196,154,40,0.15);
            border: 1px solid rgba(196,154,40,0.3);
            border-radius: 6px;
            display: flex; align-items: center; justify-content: center;
            font-size: 15px; flex-shrink: 0;
        }

        /* RIGHT PANEL */
        .login-right {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 32px;
            background: var(--cream);
        }

        .login-card {
            width: 100%;
            max-width: 420px;
        }

        .login-card-title {
            margin-bottom: 30px;
        }
        .login-card-title .tag {
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 0.14em;
            text-transform: uppercase;
            color: var(--navy-light);
            background: #EBF1FA;
            border: 1px solid rgba(30,74,135,0.2);
            padding: 4px 12px;
            border-radius: 20px;
            display: inline-block;
            margin-bottom: 14px;
        }
        .login-card-title h1 {
            font-family: 'Playfair Display', serif;
            font-size: 28px; font-weight: 700;
            color: var(--navy);
            margin-bottom: 8px;
        }
        .login-card-title p {
            font-size: 14px;
            color: var(--text-muted);
        }

        /* ── FORM FIELDS ── */
        .form-field {
            display: flex;
            flex-direction: column;
            gap: 6px;
            margin-bottom: 18px;
        }
        .form-field label {
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            color: var(--text-mid);
        }
        .form-field .input-wrap {
            position: relative;
        }
        .form-field .input-icon {
            position: absolute;
            left: 13px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 16px;
            pointer-events: none;
            opacity: 0.5;
        }
        .form-field input[type="text"],
        .form-field input[type="password"],
        .form-field input[type="email"] {
            width: 100%;
            border: 1.5px solid var(--border);
            border-radius: var(--radius);
            padding: 12px 14px 12px 42px;
            font-family: 'Source Sans 3', sans-serif;
            font-size: 15px;
            color: var(--text-dark);
            background: var(--white);
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .form-field input:focus {
            border-color: var(--navy-light);
            box-shadow: 0 0 0 3px rgba(30,74,135,0.12);
        }

        /* ── ERROR ── */
        .error-box {
            background: var(--danger-bg);
            border: 1px solid rgba(139,26,26,0.2);
            border-left: 4px solid var(--danger);
            border-radius: var(--radius);
            padding: 12px 16px;
            font-size: 13.5px;
            color: var(--danger);
            margin-bottom: 18px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* ── SUBMIT ── */
        .btn-login {
            width: 100%;
            background: linear-gradient(135deg, var(--navy) 0%, var(--navy-light) 100%);
            color: var(--white);
            border: none;
            border-radius: var(--radius);
            padding: 14px;
            font-family: 'Source Sans 3', sans-serif;
            font-size: 15.5px; font-weight: 700;
            cursor: pointer;
            letter-spacing: 0.05em;
            box-shadow: 0 4px 16px rgba(13,35,64,0.28);
            transition: all 0.2s;
            margin-bottom: 20px;
        }
        .btn-login:hover {
            box-shadow: 0 6px 22px rgba(13,35,64,0.38);
            transform: translateY(-1px);
        }
        .btn-login:active { transform: translateY(0); }

        /* ── REGISTER LINK ── */
        .register-link {
            text-align: center;
            font-size: 14px;
            color: var(--text-muted);
            padding-top: 18px;
            border-top: 1px solid var(--border);
        }
        .register-link a {
            color: var(--navy-light);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.2s;
        }
        .register-link a:hover { color: var(--gold); }

        /* ── FOOTER ── */
        .site-footer {
            background: var(--navy);
            color: rgba(255,255,255,0.45);
            text-align: center;
            padding: 18px 40px;
            font-size: 12px;
            letter-spacing: 0.04em;
            border-top: 3px solid var(--gold);
            flex-shrink: 0;
        }
        .site-footer span { color: var(--gold-light); font-weight: 600; }

        /* ── RESPONSIVE ── */
        @media (max-width: 740px) {
            .login-left { display: none; }
            .login-right { padding: 30px 20px; }
            .utility-bar { padding: 6px 16px; }
        }
    </style>
</head>
<body>
<form id="form1" runat="server">

    <!-- UTILITY BAR -->
    <div class="utility-bar">
        <span>🇱🇰 Official Government Portal &nbsp;|&nbsp; Kandy Municipal Council</span>
        <a href="Events.aspx">← Back to Events</a>
    </div>

    <!-- MAIN SPLIT LAYOUT -->
    <div class="login-wrapper">

        <!-- LEFT BRANDING PANEL -->
        <div class="login-left">
            <div class="left-logo">
                <div class="logo-emblem">KMC</div>
                <div class="left-logo-text">
                    <div class="org-name">Kandy Municipal Council</div>
                    <div class="org-sub">Western Province · Sri Lanka</div>
                </div>
            </div>

            <div class="left-content">
                <div class="gold-bar"></div>
                <h2>Welcome to the KMC City Events Portal</h2>
                <p>Sign in to manage event bookings, post new events, and stay connected with your city's cultural activities.</p>
            </div>

            <div class="left-features">
                <div class="feature-item">
                    <div class="fi-icon">🎭</div>
                    Browse &amp; book public city events
                </div>
                <div class="feature-item">
                    <div class="fi-icon">📋</div>
                    Organizers can post &amp; manage events
                </div>
                <div class="feature-item">
                    <div class="fi-icon">🔒</div>
                    Secure government-authenticated access
                </div>
            </div>
        </div>

        <!-- RIGHT LOGIN PANEL -->
        <div class="login-right">
            <div class="login-card">

                <div class="login-card-title">
                    <div class="tag">🔑 Secure Login</div>
                    <h1>Sign In to Your Account</h1>
                    <p>Enter your registered credentials to access the portal.</p>
                </div>

                <!-- Error Label -->
                <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false">
                </asp:Label>
                <% if (lblError.Text != "") { %>
                    <div class="error-box">⚠️ <asp:Literal ID="litError" runat="server" /></div>
                <% } %>

                <!-- Email -->
                <div class="form-field">
                    <label>Email Address</label>
                    <div class="input-wrap">
                        <span class="input-icon">✉️</span>
                        <asp:TextBox ID="txtEmail" runat="server" placeholder="Enter your email address"></asp:TextBox>
                    </div>
                </div>

                <!-- Password -->
                <div class="form-field">
                    <label>Password</label>
                    <div class="input-wrap">
                        <span class="input-icon">🔒</span>
                        <asp:TextBox ID="txtPass" runat="server" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
                    </div>
                </div>

                <!-- Error message from code-behind -->
                <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"
                    Style="display:block; margin-bottom:14px; font-size:13.5px; color:#8B1A1A; background:#FAF0F0; border:1px solid rgba(139,26,26,0.2); border-left:4px solid #8B1A1A; padding:10px 14px; border-radius:8px;">
                </asp:Label>

                <!-- Login Button -->
                <asp:Button ID="btnLogin" runat="server" Text="Sign In →" OnClick="btnLogin_Click" CssClass="btn-login" />

                <!-- Register Link -->
                <div class="register-link">
                    Don't have an account? &nbsp;<a href="Register.aspx">Register here</a>
                </div>

            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <footer class="site-footer">
        &copy; 2025 <span>Kandy Municipal Council</span> &nbsp;·&nbsp; Official Government Web Portal &nbsp;·&nbsp; All Rights Reserved
    </footer>

</form>
</body>
</html>