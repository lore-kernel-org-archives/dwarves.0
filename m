From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Changing the word-size was: Re: eat your own dog food?
Date: Sat, 12 Jan 2008 20:08:35 -0200
Message-ID: <20080112220835.GD17675@ghostprotocols.net>
References: <1199973341.4438.56.camel@localhost> <20080110140635.GG22437@ghostprotocols.net> <20080110163959.GJ22437@ghostprotocols.net> <20080110213909.GS22437@ghostprotocols.net> <1200001276.4443.40.camel@localhost> <20080112152109.GA23567@ghostprotocols.net> <20080112155404.GB23567@ghostprotocols.net> <20080112162808.GC23567@ghostprotocols.net> <20080112172856.GD23567@ghostprotocols.net> <20080112213635.GC17675@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080112213635.GC17675-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: jamal <hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Sat, Jan 12, 2008 at 07:36:35PM -0200, Arnaldo Carvalho de Melo escreveu:
> Em Sat, Jan 12, 2008 at 03:28:56PM -0200, Arnaldo Carvalho de Melo escreveu:
> > Now what seems to be the last thing to do is to follow typedefs and find
> > unnamed structs, think about spinlock_t, socket_lock_t, etc.
> 
> OK, typedefs are being followed now, now we get to arrays, working on that.

Fixed'n'pushed, now I'll wait for your comments, I guess everything is
right now when just changing the word-size, and should be OK mostly
apart from unusual alignment rules.

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
