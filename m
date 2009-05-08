From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Yet another pahole crash
Date: Fri, 8 May 2009 00:54:08 -0300
Message-ID: <20090508035407.GN12165@ghostprotocols.net>
References: <1241738974.21706.5.camel@yamato>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1241738974.21706.5.camel@yamato>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Diego =?utf-8?B?RS4g4oCcRmxhbWVleWVz4oCdIFBldHRlbsOy?= <flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Fri, May 08, 2009 at 01:29:34AM +0200, Diego E. =E2=80=9CFlameeyes=E2=
=80=9D Petten=C3=B2 escreveu:
> Trying to debug some problems I found a fun crash in pahole. The file
> producing the error is available at
> http://www.flameeyes.eu/tmp/feng.pahole.crasher.20090508.bz2

You forgot to mention that this is only when you ask for the anonymous =
structs:

[acme@doppio object_samples]$ pahole --anon_include feng.pahole.crasher=
=2E20090508
<BIG SNIP>
typedef struct {
	sock_type                  socktype;        /*     0     4 */
	int                        fd;              /*     4     4 */
	struct sockaddr_storage    local_stg;       /*     8   128 */
	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
	struct sockaddr_storage    remote_stg;      /*   136   128 */
	/* --- cacheline 4 boundary (256 bytes) was 8 bytes ago --- */
	struct sockaddr_storage    multicast_stg;   /*   264   128 */
	/* --- cacheline 6 boundary (384 bytes) was 8 bytes ago --- */
	sock_flags                 flags;           /*   392     4 */

	/* XXX 4 bytes hole, try to pack */

	char *                     remote_host;     /*   400     8 */
	char *                     local_host;      /*   408     8 */
	in_port_t                  remote_port;     /*   416     2 */
	in_port_t                  local_port;      /*   418     2 */

	/* XXX 4 bytes hole, try to pack */

	void *                     ssl;             /*   424     8 */
	void *                     data;            /*   432     8 */

	/* size: 440, cachelines: 7, members: 12 */
	/* sum members: 432, holes: 2, sum holes: 8 */
	/* last cacheline: 56 bytes */
} Sock;
Segmentation fault
[acme@doppio object_samples]$ pahole -Aa feng.pahole.crasher.20090508

Must be some bug I introduced in the last month or so, investigating.
=20
> Have fun!

Having.

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
