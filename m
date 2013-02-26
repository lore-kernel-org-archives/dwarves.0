From: Nicolas <nikos42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Brain fart alert
Date: Tue, 26 Feb 2013 02:50:09 +0100
Message-ID: <CACHCVZ6uvDW1CpyxXio3P17EL6bE=FKGDNm11RNZTceR-dWLjg@mail.gmail.com>
References: <CACHCVZ6oDyFwGbC4EwF_wsR9tCkoych5N6buLhRRLcyaL6iifw@mail.gmail.com>
	<20120820180216.GE3046@infradead.org>
	<CACHCVZ5EJadxOTJ0T4phSfAcm1FK7wfeDTp9QcSa1V1JCpa8SA@mail.gmail.com>
	<1346674948.3090.40.camel@springer.wildebeest.org>
	<5060DC56.4080609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5060DC56.4080609-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Hello,

Just pinging the list, about the alert triggered by the example in my
last email (brainfart2.cpp).

Cheers,
Nicolas


2012/9/25 Nicolas <nikos42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hello,
>
> I can't reproduce the segfault on i386 anymore (I updated my system
> since last time I tried), but I got a new brain fart alert, with the
> attached example.
>
> As previously to reproduce: g++ -g -c brainfart2.cpp -o brainfart2.o &&
> pahole brainfart2.o
>
> Thanks a lot,
> Nicolas
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
