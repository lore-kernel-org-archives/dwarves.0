From: Arnaldo Carvalho de Melo <acme-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Subject: Re: dwarf_loader.c: Fixed leaked bogon
Date: Wed, 6 Jan 2010 14:44:44 -0200
Message-ID: <20100106164444.GB18919@ghostprotocols.net>
References: <b401d2531001060724r4a06401fx9cc8a5dbf24518d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b401d2531001060724r4a06401fx9cc8a5dbf24518d3-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rakesh Pandit <rakesh.pandit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Wed, Jan 06, 2010 at 08:54:59PM +0530, Rakesh Pandit escreveu:
> While checking one of big shared objects I found kernel getting
> unhappy and sending SIGKILL. File was 282M libwebkit-1.0.so.2.8.1 from
> webkit project. (Can be obtained from
> http://kojipkgs.fedoraproject.org/packages/webkitgtk/1.1.12/2.fc12/x86_64/webkitgtk-debuginfo-1.1.12-2.fc12.x86_64.rpm
> and extracted via rpm2cpio, file is libwebkit-1.0.so.2.8.1.debug)
> 
> URL: http://rakesh.fedorapeople.org/misc/0001-dwarf_loader.c-Fixed-leaked-bogon.patch

What is the exact command line you are using? You cannot destroy that
obstack if you really will use the extra debugging info that is has
many pointers that will point to some other info if you destroy it.

By default cu->extra_dbg_info is false, it only is true if set
explicitely by one of the tools, like:

[acme@doppio pahole]$ grep extra_dbg_info *.c
dwarf_loader.c:	if (cu->extra_dbg_info) {
dwarf_loader.c:	return cu->extra_dbg_info ?
dwarf_loader.c:	return cu->extra_dbg_info ? dtag->decl_line : 0;
dwarf_loader.c:	return cu->extra_dbg_info ? dtag->id : 0;
dwarf_loader.c:	return cu->extra_dbg_info ? dtag->type : 0;
dwarf_loader.c:		cu->extra_dbg_info = conf ? conf->extra_dbg_info : 0;
dwarf_loader.c:		if (!cu->extra_dbg_info)
dwarves.c:		self->extra_dbg_info = 0;
pahole.c:		  conf_load.extra_dbg_info = 1;		break;
pahole.c:		  conf_load.extra_dbg_info = 1;		break;
pahole.c:		  conf_load.extra_dbg_info = 1;		break;
pfunct.c:		  conf_load.extra_dbg_info = true;
pfunct.c:		  conf_load.extra_dbg_info = 1;		 break;
pfunct.c:		  conf_load.extra_dbg_info = true;
[acme@doppio pahole]$

pahole and pfunct, and inpahole, assuming it is the one you are using:

                .name = "decl_exclude",
                .key  = 'D',
                .arg  = "PREFIX",
                .doc  = "exclude classes declared in files with PREFIX",

        case 'D': decl_exclude_prefix = arg;
                  decl_exclude_prefix_len = strlen(decl_exclude_prefix);
                  conf_load.extra_dbg_info = 1;         break;

                .name = "show_decl_info",
                .key  = 'I',
                .doc  = "Show the file and line number where the tags were defined"

        case 'I': conf.show_decl_info = 1;
                  conf_load.extra_dbg_info = 1;         break;

                .name = "packable",
                .key  = 'P',
                .doc  = "show only structs that has holes that can be packed",

        case 'P': show_packable = 1;
                  conf_load.extra_dbg_info = 1;         break;


The only seemingly "strange" case above is --packable, that I bet is
what you're using, where it needs the extra debug info because for
anonymous structs it shows in which file and line the struct is, and
that is only available from the DWARF info.

Can you try the following patch to see if the problem goes away? We may
want to just enable extra_dbg_info in this case if used with --verbose,
something like that.

Regards,

- Arnaldo

diff --git a/pahole.c b/pahole.c
index 5dad6c2..24845cd 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1000,8 +1000,7 @@ static error_t pahole__options_parser(int key, char *arg,
 	case 'm': stats_formatter = nr_methods_formatter; break;
 	case 'N': formatter = class_name_len_formatter;	break;
 	case 'n': formatter = nr_members_formatter;	break;
-	case 'P': show_packable	= 1;
-		  conf_load.extra_dbg_info = 1;		break;
+	case 'P': show_packable	= 1;			break;
 	case 'p': conf.expand_pointers = 1;		break;
 	case 'q': conf.emit_stats = 0;
 		  conf.suppress_comments = 1;
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
