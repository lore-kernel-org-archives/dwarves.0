From: jamal <hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org>
Subject: Re: Changing the word-size was: Re: eat your own dog food?
Date: Sat, 12 Jan 2008 19:42:06 -0500
Message-ID: <1200184926.31540.13.camel@localhost>
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
Reply-To: hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080112184211.GA17675-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

On Sat, 2008-12-01 at 16:42 -0200, Arnaldo Carvalho de Melo wrote:

> As I said in the cset commit, I'm no cmake/autoconf guy, but I'll check
> that, after all this is a prime area where these otherwise distracting
> things should help.


Ok, sorry - didnt see that until now; dont worry about it for now.
The fix is good enough for me as is; i just changed #if 1 to 0.

> I'll check that, thanks for the research, that may well be the starting
> point for arch descriptions, that if libebl from elfutils doesn't
> already provide that to us, something I haven't checked.

youre more than likely right; i think that libel will have all the
details somewhere ... and reading from it would be the better option
since you dont have to maintain that.

I am going to pull your latest change and test.

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
