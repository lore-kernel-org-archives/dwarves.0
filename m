From: Hagen Paul Pfeifer <hagen-GvnIQ6b/HdU@public.gmane.org>
Subject: Re: new pahole packet structure
Date: Thu, 27 Dec 2007 20:01:34 +0100
Message-ID: <20071227190134.GB28211@c3po.0xdef.net>
References: <20071224224156.GB24470@c3po.0xdef.net> <20071225201226.GA28007@ghostprotocols.net> <20071226171437.GA16456@c3po.0xdef.net> <47729D74.7060506@foo-projects.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <47729D74.7060506-X32NN5VTeG1I9G5hMfIumQ@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

* Kok, Auke | 2007-12-26 10:29:08 [-0800]:

>ldconfig can also live in /sbin/ and variants of that... make sure you check those.

99% in /sbin - but I will catch the other percent too! ;-)

The library is installed in a standard library path, we can therefore skip the
ldconfig call and instead output

@echo
@echo "Please run ldconfig"
@echo

It is often the preferred way by distribution to start ldconfig by them self.
So the @echo "You can now run ldconfig" is the better solution.


HGN


-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
