From: jamal <hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org>
Subject: Re: Changing the word-size was: Re: eat your own dog food?
Date: Sat, 12 Jan 2008 20:15:55 -0500
Message-ID: <1200186955.31540.26.camel@localhost>
References: <1199973341.4438.56.camel@localhost>
	 <20080110140635.GG22437@ghostprotocols.net>
	 <20080110163959.GJ22437@ghostprotocols.net>
	 <20080110213909.GS22437@ghostprotocols.net>
	 <1200001276.4443.40.camel@localhost>
	 <20080112152109.GA23567@ghostprotocols.net>
	 <20080112155404.GB23567@ghostprotocols.net>
	 <20080112162808.GC23567@ghostprotocols.net>
	 <20080112172856.GD23567@ghostprotocols.net>
	 <1200161321.31540.10.camel@localhost>
	 <20080112184211.GA17675@ghostprotocols.net>
	 <1200184926.31540.13.camel@localhost>
Reply-To: hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1200184926.31540.13.camel@localhost>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

On Sat, 2008-12-01 at 19:42 -0500, jamal wrote:

> I am going to pull your latest change and test.

Just one bug to report: you dont adjust your tail padding when the size
changes from native; example:

------
hadi@lilsol:~/pahole-tests$ pahole -C s4 ./a.out
struct s4 {
        char                       a;                 /*     0     1 */

        /* XXX 3 bytes hole, try to pack */

        double                     b;                /*     4     8 */
        char                       c;                /*    12     1 */

        /* size: 16, cachelines: 1 */
        /* sum members: 10, holes: 1, sum holes: 3 */
        /* padding: 3 */
        /* last cacheline: 16 bytes */
};
hadi@lilsol:~/pahole-tests$ pahole -w 8 -C s4 ./a.out
struct s4 {
        char                       a;                 /*     0     1 */

        /* XXX 7 bytes hole, try to pack */

        double                     b;                /*     8     8 */
        char                       c;                /*    16     1 */

        /* size: 20, cachelines: 1 */
        /* sum members: 10, holes: 1, sum holes: 7 */
        /* padding: 3 */
        /* last cacheline: 20 bytes */
};
hadi@lilsol:~/pahole-tests$

---------------

In this case the tail padding should be 7.

The rules say:
1) aggregates have alignment equal to that of their most aligned
  member - which happens to be 8 above
2) aggregates have sizes which are a multiple of their alignment
  This may result in tail padding - the tail contains a char.

So the padding above should be 7.

Heres something that initially puzzled me:

---
hadi@lilsol:~/pahole-tests$ pahole -C s1 ./a.out
struct s1 {
        short int                  a1;               /*     0     2 */
        short int                  a2;               /*     2     2 */
        short int                  a3;               /*     4     2 */

        /* size: 6, cachelines: 1 */
        /* last cacheline: 6 bytes */
};
hadi@lilsol:~/pahole-tests$ pahole -C s1 -w 8 ./a.out
struct s1 {
        short int                  a1;               /*     0     2 */
        short int                  a2;               /*     2     2 */
        short int                  a3;              /*     4     2 */

        /* size: 6, cachelines: 1 */
        /* last cacheline: 6 bytes */
};
------------

It puzzled me initially because i thought we'd need a tail padding of
some sort for both 32 bit and 64 bit - but it turns out from rule #1
that the most aligned member was 2 bytes, so no padding was needed for
either. So whatever was done here to follow the rules is key.


cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
