From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: eat your own dog food?
Date: Sat, 12 Jan 2008 13:21:09 -0200
Message-ID: <20080112152109.GA23567@ghostprotocols.net>
References: <1199968968.4438.49.camel@localhost> <20080110133926.GF22437@ghostprotocols.net> <1199973341.4438.56.camel@localhost> <20080110140635.GG22437@ghostprotocols.net> <20080110163959.GJ22437@ghostprotocols.net> <20080110213909.GS22437@ghostprotocols.net> <1200001276.4443.40.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1200001276.4443.40.camel@localhost>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jamal <hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Thu, Jan 10, 2008 at 04:41:16PM -0500, jamal escreveu:
> On Thu, 2008-10-01 at 19:39 -0200, Arnaldo Carvalho de Melo wrote:
> 
> 
> > Working now on unions, etc, have you had the chance of testing this
> > patch?
> 
> I should be able to test it in a couple of hours. If you have the unions
> change before then, send me a unified patch - else an incremental
> version.

Remove the non-commited patches and do a git-pull, basic work is done,
reusing code I had in ctracer to do some simple alignment fixups.

Please let me know about any bugs you may find.

- Arnaldo

commit f6eb9ed92dafbd8cac082737fe0352c0ff6e7fdc
Author: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Sat Jan 12 13:14:40 2008 -0200

    [PAHOLE]: Allow changing the architecture word-size
    
    Using a x86_64 binary:
    
    [acme@doppio pahole]$ build/pahole -C restart_block /usr/lib/debug/lib/modules/2.6.21-65.el5rt/kernel/drivers/net/e1000/e1000.ko.debug
    struct restart_block {
    	long int          (*fn)(struct restart_block *); /*     0     8 */
    	union {
    		struct {
    			long unsigned int arg0;          /*     8     8 */
    			long unsigned int arg1;          /*    16     8 */
    			long unsigned int arg2;          /*    24     8 */
    			long unsigned int arg3;          /*    32     8 */
    		};                                       /*          32 */
    		struct {
    			u32 *      uaddr;                /*     8     8 */
    			u32        val;                  /*    16     4 */
    			u32        flags;                /*    20     4 */
    			u64        time;                 /*    24     8 */
    		} fu;                                    /*          24 */
    	};                                               /*     8    32 */
    
    	/* size: 40, cachelines: 1 */
    	/* last cacheline: 40 bytes */
    };
    
    Changing the word-size from 8 to 4 bytes:
    
    [acme@doppio pahole]$ build/pahole -w 4 -C restart_block /usr/lib/debug/lib/modules/2.6.21-65.el5rt/kernel/drivers/net/e1000/e1000.ko.debug
    struct restart_block {
    	long int       (*fn)(struct restart_block *); /*     0     4 */
    	union {
    		struct {
    			long unsigned int arg0;          /*     4     4 */
    			long unsigned int arg1;          /*     8     4 */
    			long unsigned int arg2;          /*    12     4 */
    			long unsigned int arg3;          /*    16     4 */
    		};                                       /*          16 */
    		struct {
    			u32 *      uaddr;                /*     4     4 */
    			u32        val;                  /*     8     4 */
    			u32        flags;                /*    12     4 */
    			u64        time;                 /*    16     8 */
    		} fu;                                    /*          20 */
    	};                                               /*     4    20 */
    
    	/* size: 24, cachelines: 1 */
    	/* last cacheline: 24 bytes */
    };
    
    And from 8 to 16:
    
    [acme@doppio pahole]$ build/pahole -w 16 -C restart_block /usr/lib/debug/lib/modules/2.6.21-65.el5rt/kernel/drivers/net/e1000/e1000.ko.debug
    struct restart_block {
    	long int          (*fn)(struct restart_block *); /*     0    16 */
    	union {
    		struct {
    			long unsigned int arg0;          /*    16    16 */
    			long unsigned int arg1;          /*    32    16 */
    			long unsigned int arg2;          /*    48    16 */
    			long unsigned int arg3;          /*    64    16 */
    			/* --- cacheline 1 boundary (64 bytes) --- */
    		};                                       /*          64 */
    		struct {
    			u32 *      uaddr;                /*    16    16 */
    			u32        val;                  /*    32     4 */
    			u32        flags;                /*    36     4 */
    			u64        time;                 /*    40     8 */
    		} fu;                                    /*          32 */
    	};                                               /*    16    64 */
    	/* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
    
    	/* size: 80, cachelines: 2 */
    	/* last cacheline: 16 bytes */
    };
    
    More work is required to specify different alignment rules.
    
    Signed-off-by: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
