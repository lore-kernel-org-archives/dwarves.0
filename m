From: Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Brain fart alert
Date: Wed, 11 Nov 2015 19:48:20 -0300
Message-ID: <20151111224820.GD12579@kernel.org>
References: <20151111182618.GF6445@suse.cz>
 <20151111201151.GA6712@kernel.org>
 <20151111210519.GG6445@suse.cz>
 <20151111221340.GB12579@kernel.org>
 <20151111221747.GC12579@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151111221747.GC12579-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Sterba <dsterba-AlSwsSmVLrQ@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

ok, so its pahole that is getting this wrong, i.e. the offset is from
the end, so, if all would be represented as bitfields, it would be:

 	unsigned int      reada:8;                 /*   128:24  4 */
 	unsigned int      lowest_level:8;          /*   128:16  4 */
 
 	/* Bitfield combined with previous fields */
 
 	unsigned int      search_for_split:1;      /*   128:15  4 */
 	unsigned int      keep_locks:1;            /*   128:14  4 */
 	unsigned int      skip_locking:1;          /*   128:13  4 */
 	unsigned int      leave_spinning:1;        /*   128:12  4 */
 	unsigned int      search_commit_root:1;    /*   128:11  4 */
 	unsigned int      need_commit_sem:1;       /*   128:10  4 */
 	unsigned int      skip_release_on_error:1; /*   128: 9  4 */

And the bits from 0 to 8, 9 bits, would be the bit hole, well, in this
case, as it is at the end, bit padding, would be of just 9 bits, since
we're using 23 bits, I'll try fixing this.

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
