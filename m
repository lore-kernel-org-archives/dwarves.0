From: David Sterba <dsterba-AlSwsSmVLrQ@public.gmane.org>
Subject: Brain fart alert
Date: Wed, 11 Nov 2015 19:26:18 +0100
Message-ID: <20151111182618.GF6445@suse.cz>
Reply-To: dsterba-AlSwsSmVLrQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Hi,

with current git version 1.10 (79536f4f9587703c7136d2654824630689880f5c):

struct btrfs_path {
        struct extent_buffer *     nodes[8];             /*     0    64 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        int                        slots[8];             /*    64    32 */
        int                        locks[8];             /*    96    32 */
        /* --- cacheline 2 boundary (128 bytes) --- */
        u8                         reada;                /*   128     1 */
        u8                         lowest_level;         /*   129     1 */

        /* Bitfield combined with previous fields */

        unsigned int               search_for_split:1;   /*   128:15  4 */
        unsigned int               keep_locks:1;         /*   128:14  4 */
        unsigned int               skip_locking:1;       /*   128:13  4 */
        unsigned int               leave_spinning:1;     /*   128:12  4 */
        unsigned int               search_commit_root:1; /*   128:11  4 */
        unsigned int               need_commit_sem:1;    /*   128:10  4 */
        unsigned int               skip_release_on_error:1; /*   128: 9  4 */

        /* size: 136, cachelines: 3, members: 12 */
        /* padding: 4 */
        /* bit_padding: 25 bits */
        /* last cacheline: 8 bytes */

        /* BRAIN FART ALERT! 136 != 136 + 0(holes), diff = 0 */

};

Looks like it's the bitfield combining.

$ gcc --version
gcc (SUSE Linux) 4.5.1 20101208 [gcc-4_5-branch revision 167585]

binutils-2.23.2

Let me know if you need more information.

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
