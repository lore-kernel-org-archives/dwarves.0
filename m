From: Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Brain fart alert
Date: Wed, 11 Nov 2015 19:13:40 -0300
Message-ID: <20151111221340.GB12579@kernel.org>
References: <20151111182618.GF6445@suse.cz>
 <20151111201151.GA6712@kernel.org>
 <20151111210519.GG6445@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151111210519.GG6445-AlSwsSmVLrQ@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Sterba <dsterba-AlSwsSmVLrQ@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Wed, Nov 11, 2015 at 10:05:19PM +0100, David Sterba escreveu:
> On Wed, Nov 11, 2015 at 05:11:51PM -0300, Arnaldo Carvalho de Melo wrote:
> > > struct btrfs_path {
> ...
> > >         u8                         reada;                /*   128     1 */
> > >         u8                         lowest_level;         /*   129     1 */
> ...
> > > };
...
> > 	int                        reada;                /*   128     4 */
> > 	int                        lowest_level;         /*   132     4 */
> > 	unsigned int               search_for_split:1;   /*   136:31  4 */
> > 	unsigned int               keep_locks:1;         /*   136:30  4 */
...
> > Ok, but then 'reada' and 'lowest_level' are both int in my file, lemme try
> > converting it and rebuilding...
 
> Yes, they're both 'int' in current git versions, I'm trying to reduce
> size of the structure and using pahole to see the result. When both
> members were switched to u8 the warning appeared. Sorry for confusion.

So, I did the change and got the same BFA, with:

gcc version 4.9.2 20150212 (Red Hat 4.9.2-6) (GCC) 

I'm trying to figure out how this can make sense:

	u8                reada;                   /*   128     1 */
	u8                lowest_level;            /*   129     1 */

	/* Bitfield combined with previous fields */

	unsigned int      search_for_split:1;      /*   128:15  4 */
	unsigned int      keep_locks:1;            /*   128:14  4 */
	unsigned int      skip_locking:1;          /*   128:13  4 */
	unsigned int      leave_spinning:1;        /*   128:12  4 */
	unsigned int      search_commit_root:1;    /*   128:11  4 */
	unsigned int      need_commit_sem:1;       /*   128:10  4 */
	unsigned int      skip_release_on_error:1; /*   128: 9  4 */

I.e. it is like skip_release_on_error uses the first bit of 'lowest_level',
i.e. the ninth bit starting at byte offset 128... I was expecting it to be:

	u8                reada;                   /*   128     1 */
	u8                lowest_level;            /*   129     1 */

	/* Bitfield combined with previous fields */

	unsigned int      search_for_split:1;      /*   128:22  4 */
	unsigned int      keep_locks:1;            /*   128:21  4 */
	unsigned int      skip_locking:1;          /*   128:20  4 */
	unsigned int      leave_spinning:1;        /*   128:19  4 */
	unsigned int      search_commit_root:1;    /*   128:18  4 */
	unsigned int      need_commit_sem:1;       /*   128:17  4 */
	unsigned int      skip_release_on_error:1; /*   128:16  4 */

Because by combining the bitfield with the two u8 before it, it would read as:

	unsigned int      reada:8;                 /*   128:0   4 */
	unsigned int      lowest_level:8;          /*   128:8   4 */


:-\

Looking at the readelf output now...

- Arnaldo

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
