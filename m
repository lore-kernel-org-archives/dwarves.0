From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: The strange ever-changing structure :)
Date: Mon, 12 May 2008 14:54:39 -0300
Message-ID: <20080512175439.GC15306@ghostprotocols.net>
References: <200805121929.19084@enterprise.flameeyes.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200805121929.19084-Pa7mVGAsjv+0j3/lZWhZhlwbbkVOKVeL6HgeeWxq3HYdnm+yROfE0A@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Diego 'Flameeyes' =?iso-8859-1?Q?Petten=F2?= <flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

CCing dwarves ML

Em Mon, May 12, 2008 at 07:29:17PM +0200, Diego 'Flameeyes' Petten=F2 e=
screveu:
> http://www.flameeyes.eu/tmp/dwarves-strange.tbz2
>=20
> The rest of the differences are correct, I'm doing some micro-optimis=
ation to=20
> the code, but this:
>=20
> ../../../src/xine-engine/alphablend.c:
>   struct header_s |  -24
>     data
>      from: uint8_t *             /*     8(0)    48(0) */
>      to:   uint8_t *             /*     8(0)    24(0) */
>  1 struct changed
>=20
>=20
> I always find in my codiff outputs...

Using readelf we can see that we have two header_s definitions:

One that is local to the blend_yuy2_grow_extra_data function and has 32
bytes:

 <2><5d2b2>: Abbrev Number: 19 (DW_TAG_structure_type)
    <5d2b3>   DW_AT_name        : (indirect string, offset: 0x79c6): he=
ader_s  =20
    <5d2b7>   DW_AT_byte_size   : 32   =20
    <5d2b8>   DW_AT_decl_file   : 1    =20
    <5d2b9>   DW_AT_decl_line   : 1549 =20
    <5d2bb>   DW_AT_sibling     : <0x5d2ec>

And another, that is local to the blend_yuv_grow_extra_data function an=
d
that has 56 bytes.

 <2><5d401>: Abbrev Number: 19 (DW_TAG_structure_type)
    <5d402>   DW_AT_name        : (indirect string, offset: 0x79c6): he=
ader_s  =20
    <5d406>   DW_AT_byte_size   : 56   =20
    <5d407>   DW_AT_decl_file   : 1    =20
    <5d408>   DW_AT_decl_line   : 1107 =20
    <5d40a>   DW_AT_sibling     : <0x5d43b>=20

I'm now thinking on how to properly support this... I think that the
data structures in libdwarves are in the right shape, i.e. these struct=
s
already are in separate namespaces, I'll check now how pahole/codiff ar=
e
handling this.

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
