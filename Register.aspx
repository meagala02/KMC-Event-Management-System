<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="KMC_ClientApp.Register" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <title>Register — KMC Events Portal</title>
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
            --success:    #1A6B3A;
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
        }
        .utility-bar a:hover { color: var(--gold-light); }

        /* ── SPLIT LAYOUT ── */
        .register-wrapper {
            flex: 1;
            display: flex;
            min-height: calc(100vh - 88px);
        }

        /* ── LEFT PANEL ── */
        .register-left {
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
        .register-left::before {
            content: '';
            position: absolute; inset: 0;
            background: url("data:image/svg+xml,%3Csvg width='80' height='80' viewBox='0 0 80 80' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.03'%3E%3Cpath d='M50 50v-6h-3v6h-6v3h6v6h3v-6h6v-3h-6zm0-44V0h-3v6h-6v3h6v6h3V9h6V6h-6zM6 50v-6H3v6H0v3h3v6h3v-6h6v-3H6zM6 6V0H3v6H0v3h3v6h3V9h6V6H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E") repeat;
            pointer-events: none;
        }
        .register-left::after {
            content: '';
            position: absolute;
            bottom: -80px; right: -80px;
            width: 340px; height: 340px;
            border-radius: 50%;
            background: rgba(196,154,40,0.08);
            border: 60px solid rgba(196,154,40,0.06);
        }

        .left-logo {
            display: flex; align-items: center; gap: 16px;
            position: relative; z-index: 1;
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
            position: relative; z-index: 1;
            flex: 1;
            display: flex; flex-direction: column; justify-content: center;
            padding: 40px 0;
        }
        .left-content .gold-bar {
            width: 40px; height: 4px;
            background: var(--gold); border-radius: 2px;
            margin-bottom: 22px;
        }
        .left-content h2 {
            font-family: 'Playfair Display', serif;
            font-size: 30px; font-weight: 700;
            color: var(--white); line-height: 1.3;
            margin-bottom: 16px;
        }
        .left-content p {
            font-size: 14.5px;
            color: rgba(255,255,255,0.6);
            line-height: 1.7; max-width: 300px;
        }

        /* Role cards */
        .role-cards {
            position: relative; z-index: 1;
            display: flex; flex-direction: column; gap: 12px;
        }
        .role-card {
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: var(--radius);
            padding: 14px 16px;
            display: flex; align-items: flex-start; gap: 12px;
        }
        .role-card .rc-icon {
            width: 36px; height: 36px;
            background: rgba(196,154,40,0.15);
            border: 1px solid rgba(196,154,40,0.3);
            border-radius: 8px;
            display: flex; align-items: center; justify-content: center;
            font-size: 17px; flex-shrink: 0;
        }
        .role-card .rc-title {
            font-size: 13.5px; font-weight: 700;
            color: var(--white); margin-bottom: 3px;
        }
        .role-card .rc-desc {
            font-size: 12px; color: rgba(255,255,255,0.5); line-height: 1.5;
        }

        /* ── RIGHT PANEL ── */
        .register-right {
            flex: 1;
            display: flex; align-items: center; justify-content: center;
            padding: 40px 32px;
            background: var(--cream);
        }

        .register-card { width: 100%; max-width: 440px; }

        .register-card-title { margin-bottom: 28px; }
        .register-card-title .tag {
            font-size: 11px; font-weight: 700;
            letter-spacing: 0.14em; text-transform: uppercase;
            color: var(--success);
            background: #EBF5EF;
            border: 1px solid rgba(26,107,58,0.2);
            padding: 4px 12px; border-radius: 20px;
            display: inline-block; margin-bottom: 14px;
        }
        .register-card-title h1 {
            font-family: 'Playfair Display', serif;
            font-size: 26px; font-weight: 700;
            color: var(--navy); margin-bottom: 8px;
        }
        .register-card-title p {
            font-size: 14px; color: var(--text-muted);
        }

        /* ── FORM FIELDS ── */
        .form-field {
            display: flex; flex-direction: column; gap: 6px;
            margin-bottom: 16px;
        }
        .form-field label {
            font-size: 12px; font-weight: 700;
            letter-spacing: 0.08em; text-transform: uppercase;
            color: var(--text-mid);
        }
        .form-field label .required { color: #c0392b; margin-left: 3px; }
        .form-field .input-wrap { position: relative; }
        .form-field .input-icon {
            position: absolute; left: 13px; top: 50%;
            transform: translateY(-50%);
            font-size: 16px; pointer-events: none; opacity: 0.45;
        }
        .form-field input[type="text"],
        .form-field input[type="password"],
        .form-field input[type="email"] {
            width: 100%;
            border: 1.5px solid var(--border);
            border-radius: var(--radius);
            padding: 12px 14px 12px 42px;
            font-family: 'Source Sans 3', sans-serif;
            font-size: 15px; color: var(--text-dark);
            background: var(--white); outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .form-field input:focus {
            border-color: var(--navy-light);
            box-shadow: 0 0 0 3px rgba(30,74,135,0.12);
        }

        /* Role selector */
        .role-selector {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            margin-bottom: 22px;
        }
        .role-option {
            border: 2px solid var(--border);
            border-radius: var(--radius);
            padding: 14px 12px;
            cursor: pointer;
            text-align: center;
            transition: all 0.2s;
            background: var(--white);
            position: relative;
        }
        .role-option:hover {
            border-color: var(--navy-light);
            background: #EBF1FA;
        }
        .role-option.selected {
            border-color: var(--navy-light);
            background: #EBF1FA;
        }
        .role-option.selected::after {
            content: '✓';
            position: absolute;
            top: 8px; right: 10px;
            font-size: 12px; font-weight: 700;
            color: var(--navy-light);
        }
        .role-option .ro-icon { font-size: 26px; margin-bottom: 8px; }
        .role-option .ro-title {
            font-size: 13px; font-weight: 700;
            color: var(--navy); margin-bottom: 3px;
        }
        .role-option .ro-desc {
            font-size: 11.5px; color: var(--text-muted); line-height: 1.4;
        }
        /* Hidden actual dropdown — driven by JS */
        .role-field-hidden { display: none; }

        /* ── SUBMIT ── */
        .btn-register {
            width: 100%;
            background: linear-gradient(135deg, var(--success) 0%, #1e8048 100%);
            color: var(--white);
            border: none; border-radius: var(--radius);
            padding: 14px;
            font-family: 'Source Sans 3', sans-serif;
            font-size: 15.5px; font-weight: 700;
            cursor: pointer; letter-spacing: 0.05em;
            box-shadow: 0 4px 16px rgba(26,107,58,0.28);
            transition: all 0.2s; margin-bottom: 20px;
        }
        .btn-register:hover {
            box-shadow: 0 6px 22px rgba(26,107,58,0.4);
            transform: translateY(-1px);
        }
        .btn-register:active { transform: translateY(0); }

        /* ── LOGIN LINK ── */
        .login-link {
            text-align: center; font-size: 14px;
            color: var(--text-muted);
            padding-top: 18px;
            border-top: 1px solid var(--border);
        }
        .login-link a {
            color: var(--navy-light); text-decoration: none;
            font-weight: 600; transition: color 0.2s;
        }
        .login-link a:hover { color: var(--gold); }

        /* ── FOOTER ── */
        .site-footer {
            background: var(--navy);
            color: rgba(255,255,255,0.45);
            text-align: center; padding: 18px 40px;
            font-size: 12px; letter-spacing: 0.04em;
            border-top: 3px solid var(--gold); flex-shrink: 0;
        }
        .site-footer span { color: var(--gold-light); font-weight: 600; }

        /* ── RESPONSIVE ── */
        @media (max-width: 740px) {
            .register-left { display: none; }
            .register-right { padding: 30px 20px; }
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

    <!-- SPLIT LAYOUT -->
    <div class="register-wrapper">

        <!-- LEFT BRANDING PANEL -->
        <div class="register-left">
            <div class="left-logo">
                <div class="logo-emblem">KMC</div>
                <div class="left-logo-text">
                    <div class="org-name">Kandy Municipal Council</div>
                    <div class="org-sub">Western Province · Sri Lanka</div>
                </div>
            </div>

            <div class="left-content">
                <div class="gold-bar"></div>
                <h2>Join the KMC City Events Community</h2>
                <p>Create your account to access and participate in public city events organised by the Kandy Municipal Council.</p>
            </div>

            <div class="role-cards">
                <div class="role-card">
                    <div class="rc-icon">🎭</div>
                    <div>
                        <div class="rc-title">Event Organizer</div>
                        <div class="rc-desc">Post, manage and promote public events on behalf of your organisation.</div>
                    </div>
                </div>
                <div class="role-card">
                    <div class="rc-icon">👤</div>
                    <div>
                        <div class="rc-title">Participant</div>
                        <div class="rc-desc">Browse and book seats at upcoming city events with ease.</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- RIGHT REGISTER PANEL -->
        <div class="register-right">
            <div class="register-card">

                <div class="register-card-title">
                    <div class="tag">✅ New Account</div>
                    <h1>Create Your Account</h1>
                    <p>Fill in your details below to register for the KMC Events Portal.</p>
                </div>

                <!-- Full Name -->
                <div class="form-field">
                    <label>Full Name <span class="required">*</span></label>
                    <div class="input-wrap">
                        <span class="input-icon">👤</span>
                        <asp:TextBox ID="txtName" runat="server" placeholder="Enter your full name"></asp:TextBox>
                    </div>
                </div>

                <!-- Email -->
                <div class="form-field">
                    <label>Email Address <span class="required">*</span></label>
                    <div class="input-wrap">
                        <span class="input-icon">✉️</span>
                        <asp:TextBox ID="txtEmail" runat="server" placeholder="This will be your login ID"></asp:TextBox>
                    </div>
                </div>

                <!-- Password -->
                <div class="form-field">
                    <label>Password <span class="required">*</span></label>
                    <div class="input-wrap">
                        <span class="input-icon">🔒</span>
                        <asp:TextBox ID="txtPass" runat="server" TextMode="Password" placeholder="Create a strong password"></asp:TextBox>
                    </div>
                </div>

                <!-- Role Selector (visual cards + hidden dropdown) -->
                <div class="form-field">
                    <label>Register As <span class="required">*</span></label>
                </div>
                <div class="role-selector">
                    <div class="role-option" id="roleOrganizer" onclick="selectRole('Organizer')">
                        <div class="ro-icon">🎭</div>
                        <div class="ro-title">Event Organizer</div>
                        <div class="ro-desc">Post &amp; manage events</div>
                    </div>
                    <div class="role-option selected" id="roleParticipant" onclick="selectRole('Participant')">
                        <div class="ro-icon">👤</div>
                        <div class="ro-title">Participant</div>
                        <div class="ro-desc">Browse &amp; book events</div>
                    </div>
                </div>

                <!-- Hidden actual dropdown for code-behind -->
                <div class="role-field-hidden">
                    <asp:DropDownList ID="ddlRole" runat="server">
                        <asp:ListItem Value="Organizer">Event Organizer</asp:ListItem>
                        <asp:ListItem Value="Participant" Selected="True">Participant</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <!-- Register Button -->
                <asp:Button ID="btnRegister" runat="server" Text="✔  Create My Account" OnClick="btnRegister_Click" CssClass="btn-register" />

                <!-- Login Link -->
                <div class="login-link">
                    Already have an account? &nbsp;<a href="Login.aspx">Sign in here</a>
                </div>

            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <footer class="site-footer">
        &copy; 2025 <span>Kandy Municipal Council</span> &nbsp;·&nbsp; Official Government Web Portal &nbsp;·&nbsp; All Rights Reserved
    </footer>

</form>

<script>
    function selectRole(role) {
        // Update visual cards
        document.getElementById('roleOrganizer').classList.toggle('selected', role === 'Organizer');
        document.getElementById('roleParticipant').classList.toggle('selected', role === 'Participant');

        // Sync hidden ASP.NET DropDownList
        var ddl = document.getElementById('<%= ddlRole.ClientID %>');
        for (var i = 0; i < ddl.options.length; i++) {
            ddl.options[i].selected = (ddl.options[i].value === role);
        }
    }
</script>
</body>
</html>