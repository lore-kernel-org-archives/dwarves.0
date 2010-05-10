From: Rakesh Pandit <rakesh.pandit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dwarf_loader.c: Fixed leaked bogon
Date: Mon, 10 May 2010 16:33:26 +0530
Message-ID: <AANLkTil8acwy2ory42GSCT-8e-Nh1jlo--Cg4HSjoie5@mail.gmail.com>
References: <b401d2531001060724r4a06401fx9cc8a5dbf24518d3@mail.gmail.com>
	 <20100106164444.GB18919@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100106164444.GB18919-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

=46inally had a look at this case again and I am able to reproduce it.
Kernel kills the command:
[rakesh@simu build]$ ./pfunct -l -P
~/testrpms/webkitgtk-debuginfo-1.1.12-1.fc12.x86_64/usr/lib/debug/usr/l=
ib64/libwebkit-1.0.so.2.debug
with message:
May 10 12:19:20 simu kernel: Out of memory: kill process 2956 (bash)
score 496818 or a child
May 10 12:19:20 simu kernel: Killed process 5758 (pfunct)

On 6 January 2010 22:14, Arnaldo Carvalho de Melo  wrote:
> Em Wed, Jan 06, 2010 at 08:54:59PM +0530, Rakesh Pandit escreveu:
>> While checking one of big shared objects I found kernel getting
>> unhappy and sending SIGKILL. File was 282M libwebkit-1.0.so.2.8.1 fr=
om
>> webkit project. (Can be obtained from
>> http://kojipkgs.fedoraproject.org/packages/webkitgtk/1.1.12/2.fc12/x=
86_64/webkitgtk-debuginfo-1.1.12-2.fc12.x86_64.rpm
>> and extracted via rpm2cpio, file is libwebkit-1.0.so.2.8.1.debug)
>>
>> URL: http://rakesh.fedorapeople.org/misc/0001-dwarf_loader.c-Fixed-l=
eaked-bogon.patch
>
> What is the exact command line you are using? You cannot destroy that
> obstack if you really will use the extra debugging info that is has
> many pointers that will point to some other info if you destroy it.
>
> By default cu->extra_dbg_info is false, it only is true if set
> explicitely by one of the tools, like:
>
> [acme@doppio pahole]$ grep extra_dbg_info *.c
> dwarf_loader.c: if (cu->extra_dbg_info) {
> dwarf_loader.c: return cu->extra_dbg_info ?
> dwarf_loader.c: return cu->extra_dbg_info ? dtag->decl_line : 0;
> dwarf_loader.c: return cu->extra_dbg_info ? dtag->id : 0;
> dwarf_loader.c: return cu->extra_dbg_info ? dtag->type : 0;
> dwarf_loader.c: =A0 =A0 =A0 =A0 cu->extra_dbg_info =3D conf ? conf->e=
xtra_dbg_info : 0;
> dwarf_loader.c: =A0 =A0 =A0 =A0 if (!cu->extra_dbg_info)
> dwarves.c: =A0 =A0 =A0 =A0 =A0 =A0 =A0self->extra_dbg_info =3D 0;
> pahole.c: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 conf_load.extra_dbg_info =3D=
 1; =A0 =A0 =A0 =A0 break;
> pahole.c: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 conf_load.extra_dbg_info =3D=
 1; =A0 =A0 =A0 =A0 break;
> pahole.c: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 conf_load.extra_dbg_info =3D=
 1; =A0 =A0 =A0 =A0 break;
> pfunct.c: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 conf_load.extra_dbg_info =3D=
 true;
> pfunct.c: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 conf_load.extra_dbg_info =3D=
 1; =A0 =A0 =A0 =A0 =A0break;
> pfunct.c: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 conf_load.extra_dbg_info =3D=
 true;
> [acme@doppio pahole]$
>
> pahole and pfunct, and inpahole, assuming it is the one you are using=
:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "decl_exclude",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.key =A0=3D 'D',
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.arg =A0=3D "PREFIX",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.doc =A0=3D "exclude classes declared =
in files with PREFIX",
>
> =A0 =A0 =A0 =A0case 'D': decl_exclude_prefix =3D arg;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0decl_exclude_prefix_len =3D strlen=
(decl_exclude_prefix);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0conf_load.extra_dbg_info =3D 1; =A0=
 =A0 =A0 =A0 break;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "show_decl_info",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.key =A0=3D 'I',
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.doc =A0=3D "Show the file and line nu=
mber where the tags were defined"
>
> =A0 =A0 =A0 =A0case 'I': conf.show_decl_info =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0conf_load.extra_dbg_info =3D 1; =A0=
 =A0 =A0 =A0 break;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "packable",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.key =A0=3D 'P',
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.doc =A0=3D "show only structs that ha=
s holes that can be packed",
>
> =A0 =A0 =A0 =A0case 'P': show_packable =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0conf_load.extra_dbg_info =3D 1; =A0=
 =A0 =A0 =A0 break;
>
>
> The only seemingly "strange" case above is --packable, that I bet is
> what you're using, where it needs the extra debug info because for
> anonymous structs it shows in which file and line the struct is, and
> that is only available from the DWARF info.
>

I am using -l ( along with -P & one more option also) among the above.
ELF file is webkitgtk-debuginfo-1.1.12-1.fc12.x86_64/usr/lib/debug/usr/=
lib64/libwebkit-1.0.so.2.debug
which is essentially a symlink to libwebkit-1.0.so.2.8.1.debug in same
debuginfo rpm.

Link to debuginfo rpm is:
http://kojipkgs.fedoraproject.org/packages/webkitgtk/1.1.12/1.fc12/x86_=
64/webkitgtk-debuginfo-1.1.12-1.fc12.x86_64.rpm

It is 290 MB ELF file.

> Can you try the following patch to see if the problem goes away? We m=
ay
> want to just enable extra_dbg_info in this case if used with --verbos=
e,
> something like that.
>

Looking into where this leaks happens and what would be better way to
deal with it.

--=20
Rakesh Pandit
https://fedoraproject.org/wiki/User:Rakesh
freedom, friends, features, first
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
