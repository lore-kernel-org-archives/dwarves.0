From: David Sterba <dsterba-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Brain fart alert
Date: Wed, 11 Nov 2015 22:05:19 +0100
Message-ID: <20151111210519.GG6445@suse.cz>
References: <20151111182618.GF6445@suse.cz>
 <20151111201151.GA6712@kernel.org>
Reply-To: dsterba-AlSwsSmVLrQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151111201151.GA6712-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

On Wed, Nov 11, 2015 at 05:11:51PM -0300, Arnaldo Carvalho de Melo wrote:
> > struct btrfs_path {
...
> >         u8                         reada;                /*   128     1 */
> >         u8                         lowest_level;         /*   129     1 */
...
> > };

> [acme@zoo linux]$ pahole -C btrfs_path ../build/v4.3.0+/fs/btrfs/btrfs.o
> die__process_function: tag not supported 0x4109 (GNU_call_site)!
> struct btrfs_path {
> 	struct extent_buffer *     nodes[8];             /*     0    64 */
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	int                        slots[8];             /*    64    32 */
> 	int                        locks[8];             /*    96    32 */
> 	/* --- cacheline 2 boundary (128 bytes) --- */
> 	int                        reada;                /*   128     4 */
> 	int                        lowest_level;         /*   132     4 */
> 	unsigned int               search_for_split:1;   /*   136:31  4 */
> 	unsigned int               keep_locks:1;         /*   136:30  4 */
> 	unsigned int               skip_locking:1;       /*   136:29  4 */
> 	unsigned int               leave_spinning:1;     /*   136:28  4 */
> 	unsigned int               search_commit_root:1; /*   136:27  4 */
> 	unsigned int               need_commit_sem:1;    /*   136:26  4 */
> 	unsigned int               skip_release_on_error:1; /*   136:25  4 */
> 
> 	/* size: 144, cachelines: 3, members: 12 */
> 	/* padding: 4 */
> 	/* bit_padding: 25 bits */
> 	/* last cacheline: 16 bytes */
> };
> [acme@zoo linux]$
> 
> Ok, but then 'reada' and 'lowest_level' are both int in my file, lemme try
> converting it and rebuilding...

Yes, they're both 'int' in current git versions, I'm trying to reduce
size of the structure and using pahole to see the result. When both
members were switched to u8 the warning appeared. Sorry for confusion.
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
