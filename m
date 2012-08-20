From: Arnaldo Carvalho de Melo <acme-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: Brain fart alert
Date: Mon, 20 Aug 2012 14:35:25 -0300
Message-ID: <20120820173525.GD3046@infradead.org>
References: <CACHCVZ6oDyFwGbC4EwF_wsR9tCkoych5N6buLhRRLcyaL6iifw@mail.gmail.com>
 <20120815175647.GK2370@infradead.org>
 <20120816195224.GC10277@infradead.org>
 <m3obm5fzhs.fsf@seketeli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m3obm5fzhs.fsf-fIDRvF7C5exg9hUCZPvPmw@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dodji Seketeli <dodji-fIDRvF7C5exg9hUCZPvPmw@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Mon, Aug 20, 2012 at 03:45:51PM +0200, Dodji Seketeli escreveu:
> Arnaldo Carvalho de Melo <acme-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> a =E9crit:
>=20
> > I need to capture the fact that it is a static const, and investiga=
te
> > the C++ structure encoding rules,
>=20
> The DWARF 4 spec reads in 5.5.6 - Data Member Entries:
>=20
>     The member entry corresponding to a data member that is defined i=
n a
>     structure, union or class may have either a
>     DW_AT_data_member_location attribute or a DW_AT_data_bit_offset
>     attribute.
>=20
> It turns out that for DW_TAG_member DIEs representing non-static data
> members, GCC emits the DW_AT_data_member_location attribute.  If it's
> not present, I guess you can safely assume the DIE is for a static da=
ta

Right, unless it is in an union, ok.

> member and that it does not contribute to the size of its enclosing
> class.

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
