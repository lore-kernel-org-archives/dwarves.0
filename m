From: Mark Wielaard <mjw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Brain fart alert
Date: Mon, 03 Sep 2012 14:22:28 +0200
Message-ID: <1346674948.3090.40.camel@springer.wildebeest.org>
References: <CACHCVZ6oDyFwGbC4EwF_wsR9tCkoych5N6buLhRRLcyaL6iifw@mail.gmail.com>
	 <20120820180216.GE3046@infradead.org>
	 <CACHCVZ5EJadxOTJ0T4phSfAcm1FK7wfeDTp9QcSa1V1JCpa8SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACHCVZ5EJadxOTJ0T4phSfAcm1FK7wfeDTp9QcSa1V1JCpa8SA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas <nikos42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Arnaldo Carvalho de Melo <acme-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

On Thu, 2012-08-30 at 18:35 +0200, Nicolas wrote:
> On my i386 box, pahole segfaults in dwfl_module_getelf (in libdw.so.1,
> version 0.153), but the problem may be on elfutils' side.

I cannot replicate that on i386 with 0.152 or 0.155 (so it might be
0.153 specific). But could you give a bit more details, and/or supply
the binaries you tried to pahole, a core file or backtrace when this
happens?

Thanks,

Mark
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
