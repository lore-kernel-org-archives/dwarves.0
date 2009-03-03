From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: codiff new features
Date: Tue, 3 Mar 2009 11:09:01 -0300
Message-ID: <20090303140901.GA22356@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Hi,

	This is just to let you know about some new features in codiff:

commit dc5592b84424025171bf6b12d4660de5cfef76a3
Author: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Tue Mar 3 10:55:25 2009 -0300

    codiff: Detect changes in padding and the number of holes/bit_holes
    
    $ codiff -V /tmp/pahole.old build/pahole
    /home/acme/git/pahole/pahole.c:
      struct tag |   +0
       padding: +2
        refcnt
         removed: uint16_t              /*    56( 0)     2( 0) */
        recursivity_level
         from:    uint16_t              /*    58( 0)     2( 0) */
         to:      uint16_t              /*    56( 0)     2(15) */
        visited
         added:   uint16_t              /*    56(15)     2( 1) */
     1 struct changed
    
    Size is the same, but now we have padding (2 bytes).

commit 585075767171d52240457eaed58e3d1eb4823f7d
Author: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Tue Mar 3 10:31:14 2009 -0300

    codiff: improve detection removal and addition of members in structs
    
    Consider this case:
    
    $ codiff -V /tmp/pahole.old build/pahole
    /home/acme/git/pahole/pahole.c:
      struct tag |   +0
        refcnt
         removed: uint16_t              /*    56( 0)     2( 0) */
        recursivity_level
         from:    uint16_t              /*    58( 0)     2( 0) */
         to:      uint16_t              /*    56( 0)     2(15) */
        used
         added:   uint16_t              /*    56(15)     2( 1) */
     1 struct changed
    
    The number of members is the same and so is the size of the struct, but
    'refcnt' was removed (in fact renamed to used) and 'used' was added.

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
