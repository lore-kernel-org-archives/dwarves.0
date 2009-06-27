From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: pahole regression: -a no longer works?
Date: Sat, 27 Jun 2009 12:36:39 -0300
Message-ID: <20090627153639.GB8508@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Bronson <naesten-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Thu, Jun 25, 2009 at 09:29:28PM -0400, Samuel Bronson escreveu:
> I've just noticed that pahole's -a flag does not seem to result in
> typedef'd structs being printed anymore.
> 
> For example, with Debian's dwarves 1.3-1, on a self-compiled libVEX
> from valgrind, I see loads of typedef'd struct types like this one:
> 
> typedef struct {
>         IRTypeEnv *                type_env;             /*     0     4 */
>         HReg *                     vregmap;              /*     4     4 */
>         Int                        n_vregmap;            /*     8     4 */
>         HInstrArray *              code;                 /*    12     4 */
>         Int                        vreg_ctr;             /*    16     4 */
> 
>         /* size: 20, cachelines: 1 */
>         /* last cacheline: 20 bytes */
> } ISelEnv;      /* definitions: 1 */
> 
> but in the latest, I get only the following three:

<SNIP>

Yeah, that is a regression, I'll fix it, till then just use "pdwtags",
it will print all the tags, including the structs that have no name.
 
> This should be pretty easy to reproduce, but if not I could provide
> you with an .o file... I'd bisect it myself if it weren't for the fact
> that libebl.a is no longer available on Debian squeeze/sid, which
> means I can't build without patching the cmake :-(

What about my suggestion to change the proposed patch to check if it is
running on a debian system and if so to avoid checking for libebl?

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
