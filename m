From: Nicolas <nikos42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Brain fart alert
Date: Thu, 30 Aug 2012 18:35:41 +0200
Message-ID: <CACHCVZ5EJadxOTJ0T4phSfAcm1FK7wfeDTp9QcSa1V1JCpa8SA@mail.gmail.com>
References: <CACHCVZ6oDyFwGbC4EwF_wsR9tCkoych5N6buLhRRLcyaL6iifw@mail.gmail.com>
	<20120820180216.GE3046@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120820180216.GE3046-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Hello,

> Can you please clone my git tree and try it from there?

I just gave it a try, and it seems to work for me, except that the
ios_base class has a size of 0 here (on amd64 with g++ 4.7). Thanks a
lot for fixing this!

On my i386 box, pahole segfaults in dwfl_module_getelf (in libdw.so.1,
version 0.153), but the problem may be on elfutils' side.

Nicolas
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
