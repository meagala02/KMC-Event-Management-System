<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Events.aspx.cs" Inherits="KMC_ClientApp.Events" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <title>KMC Events Portal — Kandy Municipal Council</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Source+Sans+3:wght@300;400;500;600&display=swap" rel="stylesheet" />
    <style>
        :root {
            --navy:        #0D2340;
            --navy-mid:    #163562;
            --navy-light:  #1E4A87;
            --gold:        #C49A28;
            --gold-light:  #E8B93A;
            --gold-pale:   #FDF6E3;
            --cream:       #F7F4EF;
            --white:       #FFFFFF;
            --text-dark:   #1A1A2E;
            --text-mid:    #3D4A5C;
            --text-muted:  #7A8699;
            --border:      #D9DFE8;
            --success:     #1A6B3A;
            --success-bg:  #EBF5EF;
            --danger:      #8B1A1A;
            --danger-bg:   #FAF0F0;
            --info-bg:     #EBF1FA;
            --shadow-sm:   0 2px 8px rgba(13,35,64,0.08);
            --shadow-md:   0 6px 24px rgba(13,35,64,0.13);
            --shadow-lg:   0 16px 48px rgba(13,35,64,0.18);
            --radius:      8px;
            --radius-lg:   14px;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Source Sans 3', sans-serif;
            background-color: var(--cream);
            color: var(--text-dark);
            min-height: 100vh;
        }

        /* ── TOP UTILITY BAR ── */
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
        .utility-bar .user-info { display: flex; align-items: center; gap: 14px; }
        .utility-bar .welcome-badge {
            background: rgba(196,154,40,0.18);
            border: 1px solid rgba(196,154,40,0.35);
            color: var(--gold-light);
            padding: 3px 10px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 12px;
        }
        .utility-bar .btn-logout {
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.18);
            color: rgba(255,255,255,0.8);
            padding: 3px 12px;
            border-radius: 4px;
            font-size: 12px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
        }
        .utility-bar .btn-logout:hover {
            background: rgba(255,255,255,0.15);
            color: white;
        }

        /* ── MAIN HEADER ── */
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
            top: 0; right: 0; bottom: 0;
            width: 45%;
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
            width: 58px;
            height: 58px;
            background: var(--gold);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Playfair Display', serif;
            font-size: 22px;
            font-weight: 700;
            color: var(--navy);
            flex-shrink: 0;
            box-shadow: 0 0 0 3px rgba(196,154,40,0.3);
        }
        .logo-text { display: flex; flex-direction: column; }
        .logo-text .org-name {
            font-family: 'Playfair Display', serif;
            font-size: 20px;
            font-weight: 700;
            color: var(--white);
            letter-spacing: 0.01em;
            line-height: 1.2;
        }
        .logo-text .org-sub {
            font-size: 11.5px;
            color: var(--gold-light);
            letter-spacing: 0.12em;
            text-transform: uppercase;
            font-weight: 500;
            margin-top: 2px;
        }
        .header-divider {
            width: 1px;
            background: rgba(255,255,255,0.15);
            margin: 20px 30px;
        }
        .header-page-title {
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 22px 0;
        }
        .header-page-title h1 {
            font-family: 'Playfair Display', serif;
            font-size: 26px;
            font-weight: 600;
            color: var(--white);
            letter-spacing: 0.01em;
        }
        .header-page-title .breadcrumb {
            font-size: 12px;
            color: rgba(255,255,255,0.5);
            margin-top: 4px;
            letter-spacing: 0.05em;
            text-transform: uppercase;
        }
        .header-page-title .breadcrumb span { color: var(--gold-light); }

        /* ── PAGE BODY ── */
        .page-body {
            max-width: 1100px;
            margin: 0 auto;
            padding: 36px 24px 60px;
        }

        /* ── SECTION HEADING ── */
        .section-heading {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
        }
        .section-heading h2 {
            font-family: 'Playfair Display', serif;
            font-size: 20px;
            font-weight: 600;
            color: var(--navy);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .section-heading h2::before {
            content: '';
            display: inline-block;
            width: 4px;
            height: 22px;
            background: var(--gold);
            border-radius: 2px;
        }

        /* ── FILTER PANEL ── */
        .filter-panel {
            background: var(--white);
            border: 1px solid var(--border);
            border-top: 3px solid var(--navy-light);
            border-radius: var(--radius-lg);
            padding: 22px 28px;
            margin-bottom: 30px;
            box-shadow: var(--shadow-sm);
        }
        .filter-panel-title {
            font-size: 11px;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            color: var(--text-muted);
            font-weight: 600;
            margin-bottom: 16px;
        }
        .filter-row {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            align-items: flex-end;
        }
        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        .filter-group label {
            font-size: 12px;
            font-weight: 600;
            color: var(--text-mid);
            letter-spacing: 0.04em;
            text-transform: uppercase;
        }
        .filter-group select,
        .filter-group input[type="text"],
        .filter-group input[type="date"] {
            border: 1.5px solid var(--border);
            border-radius: var(--radius);
            padding: 9px 14px;
            font-family: 'Source Sans 3', sans-serif;
            font-size: 14px;
            color: var(--text-dark);
            background: var(--cream);
            outline: none;
            min-width: 170px;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .filter-group select:focus,
        .filter-group input:focus {
            border-color: var(--navy-light);
            box-shadow: 0 0 0 3px rgba(30,74,135,0.12);
            background: var(--white);
        }
        .btn-filter {
            background: var(--navy);
            color: var(--white);
            border: none;
            border-radius: var(--radius);
            padding: 10px 24px;
            font-family: 'Source Sans 3', sans-serif;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            letter-spacing: 0.04em;
            transition: background 0.2s, transform 0.1s;
            display: flex;
            align-items: center;
            gap: 7px;
        }
        .btn-filter:hover { background: var(--navy-light); transform: translateY(-1px); }
        .btn-filter:active { transform: translateY(0); }
        .btn-post-event {
            margin-left: auto;
            background: transparent;
            border: 2px solid var(--gold);
            color: var(--gold);
            text-decoration: none;
            border-radius: var(--radius);
            padding: 9px 20px;
            font-family: 'Source Sans 3', sans-serif;
            font-size: 13.5px;
            font-weight: 600;
            letter-spacing: 0.04em;
            display: inline-flex;
            align-items: center;
            gap: 7px;
            transition: all 0.2s;
        }
        .btn-post-event:hover {
            background: var(--gold);
            color: var(--navy);
        }

        /* ── EVENT CARDS ── */
        .events-grid {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }
        .event-card {
            background: var(--white);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            overflow: hidden;
            display: flex;
            box-shadow: var(--shadow-sm);
            transition: box-shadow 0.25s, transform 0.25s;
            position: relative;
        }
        .event-card:hover {
            box-shadow: var(--shadow-md);
            transform: translateY(-2px);
        }
        .event-card::before {
            content: '';
            position: absolute;
            left: 0; top: 0; bottom: 0;
            width: 4px;
            background: var(--gold);
            border-radius: 4px 0 0 4px;
        }
        .event-image {
            width: 190px;
            flex-shrink: 0;
            background: var(--info-bg);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
        }
        .event-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .event-image-placeholder {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, var(--navy) 0%, var(--navy-light) 100%);
            padding: 20px;
            text-align: center;
        }
        .event-image-placeholder .icon {
            font-size: 32px;
            margin-bottom: 8px;
            opacity: 0.7;
        }
        .event-image-placeholder .title-fallback {
            font-family: 'Playfair Display', serif;
            font-size: 13px;
            font-weight: 600;
            color: rgba(255,255,255,0.85);
            line-height: 1.3;
        }
        .event-body {
            flex-grow: 1;
            padding: 22px 26px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .event-top { margin-bottom: 10px; }
        .event-category-badge {
            display: inline-block;
            background: var(--info-bg);
            color: var(--navy-light);
            font-size: 10.5px;
            font-weight: 700;
            letter-spacing: 0.1em;
            text-transform: uppercase;
            padding: 3px 10px;
            border-radius: 20px;
            margin-bottom: 8px;
            border: 1px solid rgba(30,74,135,0.15);
        }
        .event-title {
            font-family: 'Playfair Display', serif;
            font-size: 20px;
            font-weight: 600;
            color: var(--navy);
            margin-bottom: 8px;
            line-height: 1.3;
        }
        .event-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            margin-bottom: 10px;
        }
        .event-meta-item {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 13.5px;
            color: var(--text-mid);
            font-weight: 500;
        }
        .event-meta-item .meta-icon {
            width: 28px;
            height: 28px;
            background: var(--cream);
            border: 1px solid var(--border);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            flex-shrink: 0;
        }
        .event-description {
            font-size: 14px;
            color: var(--text-mid);
            line-height: 1.6;
            max-width: 680px;
        }
        .event-actions {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 16px;
            padding-top: 16px;
            border-top: 1px solid var(--border);
            flex-wrap: wrap;
        }
        .btn-book {
            background: var(--success);
            color: var(--white);
            border: none;
            border-radius: var(--radius);
            padding: 9px 20px;
            font-family: 'Source Sans 3', sans-serif;
            font-size: 13.5px;
            font-weight: 600;
            cursor: pointer;
            letter-spacing: 0.03em;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 7px;
        }
        .btn-book:hover { background: #155c30; transform: translateY(-1px); }
        .btn-cancel-booking {
            background: var(--white);
            color: var(--danger);
            border: 1.5px solid var(--danger);
            border-radius: var(--radius);
            padding: 8px 20px;
            font-family: 'Source Sans 3', sans-serif;
            font-size: 13.5px;
            font-weight: 600;
            cursor: pointer;
            letter-spacing: 0.03em;
            transition: all 0.2s;
        }
        .btn-cancel-booking:hover { background: var(--danger-bg); }
        .btn-edit {
            background: var(--info-bg);
            color: var(--navy-light);
            border: 1.5px solid rgba(30,74,135,0.25);
            border-radius: var(--radius);
            padding: 8px 18px;
            font-family: 'Source Sans 3', sans-serif;
            font-size: 13.5px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            letter-spacing: 0.03em;
            transition: all 0.2s;
        }
        .btn-edit:hover { background: rgba(30,74,135,0.12); }
        .btn-delete {
            background: var(--white);
            color: var(--danger);
            border: 1.5px solid rgba(139,26,26,0.25);
            border-radius: var(--radius);
            padding: 8px 18px;
            font-family: 'Source Sans 3', sans-serif;
            font-size: 13.5px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            letter-spacing: 0.03em;
            transition: all 0.2s;
        }
        .btn-delete:hover { background: var(--danger-bg); border-color: var(--danger); }

        /* ── EMPTY STATE ── */
        .empty-state {
            text-align: center;
            padding: 70px 40px;
            background: var(--white);
            border: 1px dashed var(--border);
            border-radius: var(--radius-lg);
            color: var(--text-muted);
        }
        .empty-state .empty-icon { font-size: 52px; margin-bottom: 16px; opacity: 0.5; }
        .empty-state h3 {
            font-family: 'Playfair Display', serif;
            font-size: 22px;
            color: var(--text-mid);
            margin-bottom: 8px;
        }
        .empty-state p { font-size: 14.5px; }

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
        @media (max-width: 720px) {
            .utility-bar, .site-header { padding: 8px 16px; }
            .page-body { padding: 20px 14px 40px; }
            .event-card { flex-direction: column; }
            .event-image { width: 100%; height: 160px; }
            .filter-row { flex-direction: column; }
            .btn-post-event { margin-left: 0; }
            .header-divider { display: none; }
            .logo-text .org-name { font-size: 16px; }
        }
    </style>
</head>
<body>
<form id="form1" runat="server">

    <!-- UTILITY BAR -->
    <div class="utility-bar">
        <span>🇱🇰 Official Government Portal &nbsp;|&nbsp; Kandy Municipal Council</span>
        <div class="user-info">
            <% if (Session["UserName"] != null) { %>
                <span class="welcome-badge">👤 <%= Session["UserName"] %></span>
                <a href="Logout.aspx" class="btn-logout">Sign Out</a>
            <% } else { %>
                <a href="Login.aspx">🔑 Login / Register</a>
            <% } %>
        </div>
    </div>

    <!-- MAIN HEADER -->
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
            <h1>City Events Portal</h1>
            <div class="breadcrumb">Home &rsaquo; <span>Public Events</span></div>
        </div>
    </header>

    <!-- PAGE BODY -->
    <div class="page-body">

        <!-- FILTER PANEL -->
        <div class="filter-panel">
            <div class="filter-panel-title">🔍 Search &amp; Filter Events</div>
            <div class="filter-row">
                <div class="filter-group">
                    <label>Event Type</label>
                    <asp:DropDownList ID="ddlTypeSearch" runat="server" CssClass="">
                        <asp:ListItem Value="">All Categories</asp:ListItem>
                        <asp:ListItem>Music</asp:ListItem>
                        <asp:ListItem>Cultural</asp:ListItem>
                        <asp:ListItem>Dance</asp:ListItem>
                        <asp:ListItem>Workshop</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="filter-group">
                    <label>Event Date</label>
                    <asp:TextBox ID="txtDateSearch" runat="server" TextMode="Date"></asp:TextBox>
                </div>
                <asp:Button ID="btnSearch" runat="server" Text="Apply Filters" OnClick="btnSearch_Click" CssClass="btn-filter" />

                <% if (Session["UserRole"] != null && Session["UserRole"].ToString() == "Organizer") { %>
                    <a href="AddEvent.aspx" class="btn-post-event">＋ Post New Event</a>
                <% } %>
            </div>
        </div>

        <!-- SECTION HEADING -->
        <div class="section-heading">
            <h2>Upcoming &amp; Featured Events</h2>
        </div>

        <!-- EVENT LIST -->
        <div class="events-grid">
            <asp:Repeater ID="rptEvents" runat="server">
                <ItemTemplate>
                    <div class="event-card">
                        <!-- IMAGE -->
                        <div class="event-image">
                            <%# (Eval("ImageUrl") != null && !string.IsNullOrEmpty(Eval("ImageUrl").ToString()))
                                ? "<img src='" + Eval("ImageUrl") + "' alt='" + Eval("Title") + "' />"
                                : "<div class='event-image-placeholder'><div class='icon'>🎭</div><div class='title-fallback'>" + Eval("Title") + "</div></div>" %>
                        </div>

                        <!-- BODY -->
                        <div class="event-body">
                            <div class="event-top">
                                <div class="event-category-badge">📌 Public Event</div>
                                <div class="event-title"><%# Eval("Title") %></div>
                                <div class="event-meta">
                                    <div class="event-meta-item">
                                        <div class="meta-icon">📅</div>
                                        <%# Eval("EventDate", "{0:dddd, MMMM dd, yyyy}") %>
                                    </div>
                                    <div class="event-meta-item">
                                        <div class="meta-icon">📍</div>
                                        <%# Eval("Location") %>
                                    </div>
                                </div>
                                <div class="event-description"><%# Eval("Description") %></div>
                            </div>

                            <!-- ACTION BUTTONS -->
                            <div class="event-actions">
                                <%-- Participant Controls --%>
                                <% if (Session["UserRole"] != null && Session["UserRole"].ToString() == "Participant") { %>
                                    <asp:Button ID="btnRegister" runat="server" Text="✔ Confirm Booking"
                                        OnClick="btnRegister_Click"
                                        CommandArgument='<%# Eval("EventId") %>'
                                        CssClass="btn-book" />
                                    <asp:Button ID="btnCancel" runat="server" Text="✕ Cancel Booking"
                                        OnClick="btnCancel_Click"
                                        CommandArgument='<%# Eval("EventId") %>'
                                        OnClientClick="return confirm('Are you sure you want to cancel this booking?');"
                                        CssClass="btn-cancel-booking" />
                                <% } %>

                                <%-- Organizer Controls --%>
                                <asp:HyperLink ID="lnkEdit" runat="server" Text="✏ Edit Event"
                                    Visible='<%# Session["UserId"] != null && Eval("OrganizerId") != null && Eval("OrganizerId").ToString() == Session["UserId"].ToString() %>'
                                    NavigateUrl='<%# "EditEvent.aspx?id=" + Eval("EventId") %>'
                                    CssClass="btn-edit" />

                                <asp:LinkButton ID="lnkDelete" runat="server" Text="🗑 Delete"
                                    Visible='<%# Session["UserId"] != null && Eval("OrganizerId") != null && Eval("OrganizerId").ToString() == Session["UserId"].ToString() %>'
                                    OnClick="btnDelete_Click"
                                    CommandArgument='<%# Eval("EventId") %>'
                                    OnClientClick="return confirm('Are you sure you want to delete this event?');"
                                    CssClass="btn-delete" />
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- EMPTY STATE -->
        <asp:PlaceHolder ID="phNoData" runat="server" Visible="false">
            <div class="empty-state">
                <div class="empty-icon">📭</div>
                <h3>No Events Found</h3>
                <p>There are currently no events matching your criteria. Please adjust the filters or check back later.</p>
            </div>
        </asp:PlaceHolder>

    </div>

    <!-- FOOTER -->
    <footer class="site-footer">
        &copy; 2025 <span>Kandy Municipal Council</span> &nbsp;·&nbsp; Official Government Web Portal &nbsp;·&nbsp; All Rights Reserved
    </footer>

</form>
</body>
</html>