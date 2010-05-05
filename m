From: Arnaldo Carvalho de Melo <acme-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Subject: Re: option for printing all matching function names
Date: Wed, 5 May 2010 09:44:01 -0300
Message-ID: <20100505124401.GG970@ghostprotocols.net>
References: <q2qb401d2531005050445wb33461ecnab0f752909fb4a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <q2qb401d2531005050445wb33461ecnab0f752909fb4a4-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rakesh Pandit <rakesh.pandit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Wed, May 05, 2010 at 05:15:20PM +0530, Rakesh Pandit escreveu:
> Hello,
> 
> If we are using pfunct right with option --function, it prints the
> first matched function name. This does not satisfy those cases where
> object file has more then one functions with same name. I would like
> it to print all matching cases not just the first one. Would it be
> acceptable ? Or if it is not acceptable as it may break few scripts
> written by users which are consuming the tool. An alternate
> implementation could be if supplied with an extra option print all
> matches and by default just print first one.
> 
> Suggestions ? If any of above to is acceptable I can straight right
> down a patch accordingly.

well, if you say something like:

pfunct --function do_read --all-units

Meaning that it will print something like:

obj_foo: void do_read(char buffer);
obj_bar: int do_read(char bf, int size);
obj_baz: size_t do_read(int fd, char buf, int ln);

Its useful, send the patch :-)

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
