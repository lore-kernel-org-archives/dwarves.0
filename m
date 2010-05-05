From: Arnaldo Carvalho de Melo <acme-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Subject: Re: option for printing all matching function names
Date: Wed, 5 May 2010 10:12:30 -0300
Message-ID: <20100505131230.GA10363@ghostprotocols.net>
References: <q2qb401d2531005050445wb33461ecnab0f752909fb4a4@mail.gmail.com>
 <20100505124401.GG970@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100505124401.GG970-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rakesh Pandit <rakesh.pandit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Wed, May 05, 2010 at 09:44:01AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, May 05, 2010 at 05:15:20PM +0530, Rakesh Pandit escreveu:
> > If we are using pfunct right with option --function, it prints the
> > first matched function name. This does not satisfy those cases where
> > object file has more then one functions with same name. I would like
> > it to print all matching cases not just the first one. Would it be
> > acceptable ? Or if it is not acceptable as it may break few scripts
> > written by users which are consuming the tool. An alternate
> > implementation could be if supplied with an extra option print all
> > matches and by default just print first one.
> > 
> > Suggestions ? If any of above to is acceptable I can straight right
> > down a patch accordingly.
> 
> well, if you say something like:
> 
> pfunct --function do_read --all-units
> 
> Meaning that it will print something like:
> 
> obj_foo: void do_read(char buffer);
> obj_bar: int do_read(char bf, int size);
> obj_baz: size_t do_read(int fd, char buf, int ln);
> 
> Its useful, send the patch :-)

But that is not exactly what you want, as you more precisely described
here:

https://bugzilla.redhat.com/show_bug.cgi?id=495606

<quote>
Actually this does not results in correct match because corresponding
symbool name which we provide it with function arg is mangled. In case
we want to get a perfect matched we need to provide it de-mangled actual
function name.

But for C++ say (even in C) we can have more then one function with same
name.  In that case right now it will just print the first match.
</quote>

So what you want is that we traverse all the C++ classes finding which
ones have methods with that name, which is way more sensible than what
pfunct, being mostly oriented, so far, to C, does.

I don't have time right now to devote to this, but what you want is to:

1. go on CU by CU looking at all structs
2. look at each namespace in them looking for functions with the desired
   name, printing it in some C++ sensible way, perhaps:

return_type1 class_foo::method_searched(parameter list1); /* mangled name=EQWTVARSAE */
return_type2 class_foo::method_searched(parameter list2); /* mangled name=YTEYRWTQRD */

etc.

What I suggested about --all-units still is useful as we can have the
functions with the same name in multiple object files in C too, they
just have to be static not to cause linking problems.

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
