From: Dodji Seketeli <dodji-fIDRvF7C5exg9hUCZPvPmw@public.gmane.org>
Subject: Re: Brain fart alert
Date: Mon, 20 Aug 2012 15:45:51 +0200
Message-ID: <m3obm5fzhs.fsf@seketeli.org>
References: <CACHCVZ6oDyFwGbC4EwF_wsR9tCkoych5N6buLhRRLcyaL6iifw@mail.gmail.com>
	<20120815175647.GK2370@infradead.org>
	<20120816195224.GC10277@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Arnaldo Carvalho de Melo <acme-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
a =C3=A9crit:

> I need to capture the fact that it is a static const, and investigate
> the C++ structure encoding rules,

The DWARF 4 spec reads in 5.5.6 - Data Member Entries:

    The member entry corresponding to a data member that is defined in =
a
    structure, union or class may have either a
    DW_AT_data_member_location attribute or a DW_AT_data_bit_offset
    attribute.

It turns out that for DW_TAG_member DIEs representing non-static data
members, GCC emits the DW_AT_data_member_location attribute.  If it's
not present, I guess you can safely assume the DIE is for a static data
member and that it does not contribute to the size of its enclosing
class.

--=20
		Dodji

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
