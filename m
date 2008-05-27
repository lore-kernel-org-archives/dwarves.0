From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Another strange codiff output
Date: Tue, 27 May 2008 19:02:06 -0300
Message-ID: <20080527220206.GA30251@ghostprotocols.net>
References: <m2k5hnkgmt.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m2k5hnkgmt.fsf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Diego 'Flameeyes' =?iso-8859-1?Q?Petten=F2?= <flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Wed, May 21, 2008 at 02:04:26PM +0200, Diego 'Flameeyes' Petten=F2 e=
screveu:
>=20
> While cleaning up xine-lib's code I found another interesting thing:
>=20
> send_ogg_buf         |  +24 # 3671 -> 3695, # inlines: 0 -> 1, size i=
nlines: 0 -> 859
> send_header          | -116 # 7812 -> 7696, # inlines: 13 -> 1, size =
inlines: 6765 -> 418
>=20
> I'm not sure if this is correct, but if the size of inlines increases=
 so
> much and decreases so much, I'd expect the size of the function to
> follow suit..
>=20
> The ELF files causing this are at
> http://www.flameeyes.eu/tmp/dwarves-notsure.tbz2 .

[acme@doppio pahole]$ pfunct -TVi --function send_ogg_buf modified.so |=
 tail
		       int stream_num); /* size=3D596, low_pc=3D0x30f3 */ // 646
	} /* lexblock size=3D800 */
	{ /* send_ogg_buf+0x970 */
		const buf_element_t *  buf;                           // 686
		const uint32_t *  val;                                // 692
		const char *  str;                                    // 693
	} /* lexblock size=3D128 */
	read_chapter_comment(demux_ogg_t * this,
	                     ogg_packet * op); /* size=3D859,
                                                  low_pc=3D0x3460 */   =
 // 657
}/* size: 3695, variables: 3, inline expansions: 1 (859 bytes) */
[acme@doppio pahole]$=20

in send_ogg_buf we got only one new inline, read_chapter_comment, and
this one uses the DW_AT_ranges attribute:

 <2><552a>: Abbrev Number: 66 (DW_TAG_inlined_subroutine)
    <552b>   DW_AT_abstract_origin: <0x5165>   =20
    <552f>   DW_AT_ranges      : 0x4c0 =20
    <5533>   DW_AT_call_file   : 1     =20
    <5534>   DW_AT_call_line   : 657

IIRC this means that the the way the code in the inline was inserted
into the target function (send_ogg_buf) wasn't linear...

It would be a good idea to create a function that is not inline and
includes just read_chapter_comment, produce an object and then
disassemble it, then disassemble send_ogg_buf so that we could check
the difference trying to validate the code in the dwarves that handles
DW__AT_ranges, that is in inline_expansion__new, and that looks quite
fishy :-\

send_header, had 13 inline expansions and now has just 1, the only one
now is:

 <3><5afa>: Abbrev Number: 79 (DW_TAG_inlined_subroutine)
    <5afb>   DW_AT_abstract_origin: <0x5600>   =20
    <5aff>   DW_AT_low_pc      : 0x3e12=20
    <5b07>   DW_AT_high_pc     : 0x40e5=20
    <5b0f>   DW_AT_call_file   : 1     =20
    <5b10>   DW_AT_call_line   : 1337  =20
    <5b12>   DW_AT_sibling     : <0x5b80>

That doesn't use DW_AT_ranges, so we can just do a 0x40e5 - 0x3e12 and
get 712 bytes... We're not accounting lex block nesting, we have inline
expansions inside lex blocks, working on that now.

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
