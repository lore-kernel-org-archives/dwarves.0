From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Yet another pahole crash
Date: Fri, 8 May 2009 01:12:59 -0300
Message-ID: <20090508041259.GO12165@ghostprotocols.net>
References: <1241738974.21706.5.camel@yamato> <20090508035407.GN12165@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090508035407.GN12165-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Diego =?utf-8?B?RS4g4oCcRmxhbWVleWVz4oCdIFBldHRlbsOy?= <flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Fri, May 08, 2009 at 12:54:08AM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> Em Fri, May 08, 2009 at 01:29:34AM +0200, Diego E. =E2=80=9CFlameeyes=
=E2=80=9D Petten=C3=B2 escreveu:
> > Trying to debug some problems I found a fun crash in pahole. The fi=
le
> > producing the error is available at
> > http://www.flameeyes.eu/tmp/feng.pahole.crasher.20090508.bz2
>=20
> You forgot to mention that this is only when you ask for the anonymou=
s structs:
>=20
> [acme@doppio object_samples]$ pahole --anon_include feng.pahole.crash=
er.20090508
> <BIG SNIP>
> typedef struct {
> 	sock_type                  socktype;        /*     0     4 */
> 	int                        fd;              /*     4     4 */
> 	struct sockaddr_storage    local_stg;       /*     8   128 */
> 	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
> 	struct sockaddr_storage    remote_stg;      /*   136   128 */
> 	/* --- cacheline 4 boundary (256 bytes) was 8 bytes ago --- */
> 	struct sockaddr_storage    multicast_stg;   /*   264   128 */
> 	/* --- cacheline 6 boundary (384 bytes) was 8 bytes ago --- */
> 	sock_flags                 flags;           /*   392     4 */
>=20
> 	/* XXX 4 bytes hole, try to pack */
>=20
> 	char *                     remote_host;     /*   400     8 */
> 	char *                     local_host;      /*   408     8 */
> 	in_port_t                  remote_port;     /*   416     2 */
> 	in_port_t                  local_port;      /*   418     2 */
>=20
> 	/* XXX 4 bytes hole, try to pack */
>=20
> 	void *                     ssl;             /*   424     8 */
> 	void *                     data;            /*   432     8 */
>=20
> 	/* size: 440, cachelines: 7, members: 12 */
> 	/* sum members: 432, holes: 2, sum holes: 8 */
> 	/* last cacheline: 56 bytes */
> } Sock;
> Segmentation fault
> [acme@doppio object_samples]$ pahole -Aa feng.pahole.crasher.20090508
>=20
> Must be some bug I introduced in the last month or so, investigating.
> =20
> > Have fun!
>=20
> Having.

Put a bandaid for now, only side effect, obvious for a multi-object fil=
e like this:

$ readelf -wi feng.pahole.crasher.20090508 | grep DW_TAG_compile_unit |=
 wc -l
56

Is that anonymous structs will be printed for every CU where they are d=
efined:

$ pahole --anon_include feng.pahole.crasher.20090508  | grep '} server_=
config' | wc -l
18

Yes, avoiding duplicates by looking for the same name always was, hum, =
lame and
could avoid printing a different struct that has the same name (as
unlikely/stupid as this may be, its possible), I'll get that properly f=
ixed
soon.

And here is the bandaid, for reference, already commited and pushed, th=
anks one
more time for reporting Diego!

- Arnaldo

[acme@doppio pahole]$ git-diff
diff --git a/pahole.c b/pahole.c
index 0ba7dde..1c0eef8 100644
--- a/pahole.c
+++ b/pahole.c
@@ -295,6 +295,16 @@ static void print_classes(struct cu *cu)
                        print_packable_info(pos, cu, id);
                else if (formatter !=3D NULL)
                        formatter(pos, cu, id);
+               /*
+                * FIXME: No sense in adding an anonymous struct to the=
 list of
+                * structs already printed, as we look for the name... =
The
+                * right fix probably will be to call class__fprintf on=
 a
+                * in-memory FILE, do a hash, and look it by full conte=
nts, not
+                * by name. And this is needed for CTF as well, but its=
 late now
+                * and I'm sleepy, will leave for later...
+                */
+               if (pos->type.namespace.name =3D=3D 0)
+                       continue;
=20
                if (structures__add(pos, cu) =3D=3D NULL) {
                        fprintf(stderr, "pahole: insufficient memory fo=
r "

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
