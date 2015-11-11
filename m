From: Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Brain fart alert
Date: Wed, 11 Nov 2015 17:11:51 -0300
Message-ID: <20151111201151.GA6712@kernel.org>
References: <20151111182618.GF6445@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151111182618.GF6445-AlSwsSmVLrQ@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Sterba <dsterba-AlSwsSmVLrQ@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Wed, Nov 11, 2015 at 07:26:18PM +0100, David Sterba escreveu:
> Hi,
> 
> with current git version 1.10 (79536f4f9587703c7136d2654824630689880f5c):
> 
> struct btrfs_path {
>         struct extent_buffer *     nodes[8];             /*     0    64 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         int                        slots[8];             /*    64    32 */
>         int                        locks[8];             /*    96    32 */
>         /* --- cacheline 2 boundary (128 bytes) --- */
>         u8                         reada;                /*   128     1 */
>         u8                         lowest_level;         /*   129     1 */
> 
>         /* Bitfield combined with previous fields */
> 
>         unsigned int               search_for_split:1;   /*   128:15  4 */
>         unsigned int               keep_locks:1;         /*   128:14  4 */
>         unsigned int               skip_locking:1;       /*   128:13  4 */
>         unsigned int               leave_spinning:1;     /*   128:12  4 */
>         unsigned int               search_commit_root:1; /*   128:11  4 */
>         unsigned int               need_commit_sem:1;    /*   128:10  4 */
>         unsigned int               skip_release_on_error:1; /*   128: 9  4 */
> 
>         /* size: 136, cachelines: 3, members: 12 */
>         /* padding: 4 */
>         /* bit_padding: 25 bits */
>         /* last cacheline: 8 bytes */
>         /* BRAIN FART ALERT! 136 != 136 + 0(holes), diff = 0 */
> };
 
> Looks like it's the bitfield combining.
 
> $ gcc --version
> gcc (SUSE Linux) 4.5.1 20101208 [gcc-4_5-branch revision 167585]
 
> binutils-2.23.2
 
> Let me know if you need more information.

Ok, so with:

[acme@zoo linux]$ pahole -C btrfs_path ../build/v4.3.0+/fs/btrfs/btrfs.o
die__process_function: tag not supported 0x4109 (GNU_call_site)!
struct btrfs_path {
	struct extent_buffer *     nodes[8];             /*     0    64 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	int                        slots[8];             /*    64    32 */
	int                        locks[8];             /*    96    32 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	int                        reada;                /*   128     4 */
	int                        lowest_level;         /*   132     4 */
	unsigned int               search_for_split:1;   /*   136:31  4 */
	unsigned int               keep_locks:1;         /*   136:30  4 */
	unsigned int               skip_locking:1;       /*   136:29  4 */
	unsigned int               leave_spinning:1;     /*   136:28  4 */
	unsigned int               search_commit_root:1; /*   136:27  4 */
	unsigned int               need_commit_sem:1;    /*   136:26  4 */
	unsigned int               skip_release_on_error:1; /*   136:25  4 */

	/* size: 144, cachelines: 3, members: 12 */
	/* padding: 4 */
	/* bit_padding: 25 bits */
	/* last cacheline: 16 bytes */
};
[acme@zoo linux]$

Ok, but then 'reada' and 'lowest_level' are both int in my file, lemme try
converting it and rebuilding...

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
