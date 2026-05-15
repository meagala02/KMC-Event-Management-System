<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddEvent.aspx.cs" Inherits="KMC_ClientApp.AddEvent" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <title>Post New Event — KMC Events Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Source+Sans+3:wght@300;400;500;600&display=swap" rel="stylesheet" />
    <style>
        :root {
            --navy:       #0D2340;
            --navy-mid:   #163562;
            --navy-light: #1E4A87;
            --gold:       #C49A28;
            --gold-light: #E8B93A;
            --gold-pale:  #FDF6E3;
            --cream:      #F7F4EF;
            --white:      #FFFFFF;
            --text-dark:  #1A1A2E;
            --text-mid:   #3D4A5C;
            --text-muted: #7A8699;
            --border:     #D9DFE8;
            --success:    #1A6B3A;
            --shadow-sm:  0 2px 8px rgba(13,35,64,0.08);
            --shadow-md:  0 6px 24px rgba(13,35,64,0.13);
            --radius:     8px;
            --radius-lg:  14px;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Source Sans 3', sans-serif;
            background-color: var(--cream);
            color: var(--text-dark);
            min-height: 100vh;
        }

        /* ── UTILITY BAR ── */
        .utility-bar {
            background: var(--navy);
            color: rgba(255,255,255,0.75);
            font-size: 12.5px;
            letter-spacing: 0.03em;
            padding: 6px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .utility-bar a {
            color: rgba(255,255,255,0.75);
            text-decoration: none;
            transition: color 0.2s;
        }
        .utility-bar a:hover { color: var(--gold-light); }

        /* ── HEADER ── */
        .site-header {
            background: linear-gradient(135deg, var(--navy) 0%, var(--navy-mid) 60%, var(--navy-light) 100%);
            padding: 0 40px;
            display: flex;
            align-items: stretch;
            position: relative;
            overflow: hidden;
        }
        .site-header::before {
            content: '';
            position: absolute;
            top: 0; right: 0; bottom: 0; width: 45%;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.03'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E") repeat;
            pointer-events: none;
        }
        .site-header::after {
            content: '';
            position: absolute;
            bottom: 0; left: 0; right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--gold) 0%, var(--gold-light) 50%, var(--gold) 100%);
        }
        .header-logo {
            display: flex;
            align-items: center;
            gap: 18px;
            padding: 22px 0;
            text-decoration: none;
        }
        .logo-emblem {
            width: 58px; height: 58px;
            background: var(--gold);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-family: 'Playfair Display', serif;
            font-size: 22px; font-weight: 700;
            color: var(--navy);
            flex-shrink: 0;
            box-shadow: 0 0 0 3px rgba(196,154,40,0.3);
        }
        .logo-text { display: flex; flex-direction: column; }
        .logo-text .org-name {
            font-family: 'Playfair Display', serif;
            font-size: 20px; font-weight: 700;
            color: var(--white); line-height: 1.2;
        }
        .logo-text .org-sub {
            font-size: 11.5px; color: var(--gold-light);
            letter-spacing: 0.12em; text-transform: uppercase;
            font-weight: 500; margin-top: 2px;
        }
        .header-divider {
            width: 1px;
            background: rgba(255,255,255,0.15);
            margin: 20px 30px;
        }
        .header-page-title {
            display: flex; flex-direction: column; justify-content: center;
            padding: 22px 0;
        }
        .header-page-title h1 {
            font-family: 'Playfair Display', serif;
            font-size: 26px; font-weight: 600;
            color: var(--white);
        }
        .header-page-title .breadcrumb {
            font-size: 12px; color: rgba(255,255,255,0.5);
            margin-top: 4px; letter-spacing: 0.05em; text-transform: uppercase;
        }
        .header-page-title .breadcrumb a {
            color: rgba(255,255,255,0.5); text-decoration: none;
        }
        .header-page-title .breadcrumb a:hover { color: var(--gold-light); }
        .header-page-title .breadcrumb span { color: var(--gold-light); }

        /* ── PAGE BODY ── */
        .page-body {
            max-width: 720px;
            margin: 0 auto;
            padding: 40px 24px 70px;
        }

        /* ── FORM CARD ── */
        .form-card {
            background: var(--white);
            border: 1px solid var(--border);
            border-top: 4px solid var(--navy-light);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-md);
            overflow: hidden;
        }
        .form-card-header {
            padding: 26px 34px 20px;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            gap: 14px;
        }
        .form-card-header .header-icon {
            width: 46px; height: 46px;
            background: linear-gradient(135deg, var(--navy) 0%, var(--navy-light) 100%);
            border-radius: var(--radius);
            display: flex; align-items: center; justify-content: center;
            font-size: 22px; flex-shrink: 0;
        }
        .form-card-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 22px; font-weight: 600;
            color: var(--navy);
        }
        .form-card-header p {
            font-size: 13px; color: var(--text-muted); margin-top: 3px;
        }
        .form-card-body { padding: 30px 34px 34px; }

        /* ── FORM GRID ── */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px 24px;
        }
        .form-field { display: flex; flex-direction: column; gap: 6px; }
        .form-field.full-width { grid-column: 1 / -1; }

        .form-field label {
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            color: var(--text-mid);
        }
        .form-field label .required {
            color: #c0392b;
            margin-left: 3px;
        }
        .form-field .field-hint {
            font-size: 11.5px;
            color: var(--text-muted);
            margin-top: -2px;
        }

        .form-field input[type="text"],
        .form-field input[type="date"],
        .form-field textarea,
        .form-field select {
            border: 1.5px solid var(--border);
            border-radius: var(--radius);
            padding: 11px 14px;
            font-family: 'Source Sans 3', sans-serif;
            font-size: 14.5px;
            color: var(--text-dark);
            background: var(--cream);
            outline: none;
            width: 100%;
            transition: border-color 0.2s, box-shadow 0.2s, background 0.2s;
        }
        .form-field textarea {
            resize: vertical;
            min-height: 110px;
            line-height: 1.6;
        }
        .form-field input:focus,
        .form-field textarea:focus,
        .form-field select:focus {
            border-color: var(--navy-light);
            box-shadow: 0 0 0 3px rgba(30,74,135,0.12);
            background: var(--white);
        }

        /* File Upload */
        .upload-zone {
            border: 2px dashed var(--border);
            border-radius: var(--radius);
            padding: 24px;
            text-align: center;
            background: var(--cream);
            cursor: pointer;
            transition: border-color 0.2s, background 0.2s;
            position: relative;
        }
        .upload-zone:hover {
            border-color: var(--navy-light);
            background: var(--white);
        }
        .upload-zone .upload-icon { font-size: 30px; margin-bottom: 8px; }
        .upload-zone .upload-label {
            font-size: 14px; font-weight: 600; color: var(--navy-light);
        }
        .upload-zone .upload-sub {
            font-size: 12px; color: var(--text-muted); margin-top: 4px;
        }
        .upload-zone input[type="file"] {
            position: absolute; inset: 0; opacity: 0; cursor: pointer; width: 100%; height: 100%;
        }

        /* Divider */
        .form-divider {
            grid-column: 1 / -1;
            height: 1px;
            background: var(--border);
            margin: 6px 0;
        }

        /* ── SUBMIT BUTTON ── */
        .form-actions {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 12px;
            padding: 20px 34px 28px;
            border-top: 1px solid var(--border);
            background: var(--cream);
        }
        .btn-cancel-nav {
            background: transparent;
            border: 1.5px solid var(--border);
            color: var(--text-mid);
            border-radius: var(--radius);
            padding: 11px 24px;
            font-family: 'Source Sans 3', sans-serif;
            font-size: 14px; font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-cancel-nav:hover { border-color: var(--text-mid); background: var(--white); }
        .btn-submit {
            background: linear-gradient(135deg, var(--navy) 0%, var(--navy-light) 100%);
            color: var(--white);
            border: none;
            border-radius: var(--radius);
            padding: 12px 36px;
            font-family: 'Source Sans 3', sans-serif;
            font-size: 15px; font-weight: 700;
            cursor: pointer;
            letter-spacing: 0.04em;
            box-shadow: 0 4px 14px rgba(13,35,64,0.25);
            transition: all 0.2s;
            display: flex; align-items: center; gap: 8px;
        }
        .btn-submit:hover {
            box-shadow: 0 6px 20px rgba(13,35,64,0.35);
            transform: translateY(-1px);
        }
        .btn-submit:active { transform: translateY(0); }

        /* ── INFO BADGE ── */
        .info-notice {
            display: flex; align-items: flex-start; gap: 12px;
            background: #EBF1FA;
            border: 1px solid rgba(30,74,135,0.2);
            border-left: 4px solid var(--navy-light);
            border-radius: var(--radius);
            padding: 14px 18px;
            font-size: 13px;
            color: var(--navy-mid);
            margin-bottom: 28px;
        }
        .info-notice .notice-icon { font-size: 18px; flex-shrink: 0; margin-top: 1px; }

        /* ── FOOTER ── */
        .site-footer {
            background: var(--navy);
            color: rgba(255,255,255,0.45);
            text-align: center;
            padding: 20px 40px;
            font-size: 12.5px;
            letter-spacing: 0.04em;
            margin-top: 40px;
            border-top: 3px solid var(--gold);
        }
        .site-footer span { color: var(--gold-light); font-weight: 600; }

        /* ── RESPONSIVE ── */
        @media (max-width: 620px) {
            .utility-bar, .site-header { padding: 8px 16px; }
            .page-body { padding: 20px 12px 50px; }
            .form-card-header, .form-card-body, .form-actions { padding-left: 20px; padding-right: 20px; }
            .form-grid { grid-template-columns: 1fr; }
            .form-field.full-width { grid-column: 1; }
            .header-divider { display: none; }
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

    <!-- HEADER -->
    <header class="site-header">
        <a href="Events.aspx" class="header-logo">
            <div class="logo-emblem">KMC</div>
            <div class="logo-text">
                <span class="org-name">Kandy Municipal Council</span>
                <span class="org-sub">Western Province · Sri Lanka</span>
            </div>
        </a>
        <div class="header-divider"></div>
        <div class="header-page-title">
            <h1>Post New Event</h1>
            <div class="breadcrumb">
                <a href="Events.aspx">Home</a> &rsaquo;
                <a href="Events.aspx">Events</a> &rsaquo;
                <span>Register New Event</span>
            </div>
        </div>
    </header>

    <!-- PAGE BODY -->
    <div class="page-body">

        <!-- INFO NOTICE -->
        <div class="info-notice">
            <div class="notice-icon">ℹ️</div>
            <div>All submitted events are published on the <strong>KMC Public Events Portal</strong>. Please ensure all details are accurate before submitting. Fields marked <strong style="color:#c0392b;">*</strong> are required.</div>
        </div>

        <!-- FORM CARD -->
        <div class="form-card">
            <!-- Card Header -->
            <div class="form-card-header">
                <div class="header-icon">📋</div>
                <div>
                    <h2>Event Registration Form</h2>
                    <p>Fill in the details below to list your event publicly.</p>
                </div>
            </div>

            <!-- Card Body -->
            <div class="form-card-body">
                <div class="form-grid">

                    <!-- Title -->
                    <div class="form-field full-width">
                        <label>Event Title <span class="required">*</span></label>
                        <asp:TextBox ID="txtTitle" runat="server" placeholder="e.g. Kandy Esala Perahera 2025"></asp:TextBox>
                    </div>

                    <!-- Description -->
                    <div class="form-field full-width">
                        <label>Description <span class="required">*</span></label>
                        <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine" placeholder="Provide a clear description of the event — purpose, audience, highlights, etc."></asp:TextBox>
                    </div>

                    <div class="form-divider"></div>

                    <!-- Date -->
                    <div class="form-field">
                        <label>Event Date <span class="required">*</span></label>
                        <asp:TextBox ID="txtDate" runat="server" TextMode="Date"></asp:TextBox>
                    </div>

                    <!-- Type -->
                    <div class="form-field">
                        <label>Event Type <span class="required">*</span></label>
                        <asp:DropDownList ID="ddlType" runat="server">
                            <asp:ListItem Value="">— Select a Category —</asp:ListItem>
                            <asp:ListItem>Cultural</asp:ListItem>
                            <asp:ListItem>Music</asp:ListItem>
                            <asp:ListItem>Dance</asp:ListItem>
                            <asp:ListItem>Workshop</asp:ListItem>
                            <asp:ListItem>Others</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <!-- Location -->
                    <div class="form-field full-width">
                        <label>Venue / Location <span class="required">*</span></label>
                        <asp:TextBox ID="txtLocation" runat="server" placeholder="e.g. Temple of the Tooth Premises, Kandy"></asp:TextBox>
                    </div>

                    <div class="form-divider"></div>

                    <!-- Image Upload -->
                    <div class="form-field full-width">
                        <label>Event Banner Image</label>
                        <div class="upload-zone">
                            <asp:FileUpload ID="fileImg" runat="server" />
                            <div class="upload-icon">🖼️</div>
                            <div class="upload-label">Click to upload an image</div>
                            <div class="upload-sub">Accepted formats: JPG, PNG, WEBP &nbsp;·&nbsp; Max size: 5MB</div>
                        </div>
                        <span class="field-hint">A banner image makes your event more visible to the public.</span>
                    </div>

                </div>
            </div>

            <!-- Form Actions -->
            <div class="form-actions">
                <a href="Events.aspx" class="btn-cancel-nav">Cancel</a>
                <asp:Button ID="btnAdd" runat="server" Text="📤  Publish Event" OnClick="btnAdd_Click" CssClass="btn-submit" />
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