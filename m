From: Rakesh Pandit <rakesh.pandit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: option for printing all matching function names
Date: Wed, 5 May 2010 20:00:28 +0530
Message-ID: <y2rb401d2531005050730q130526f0o7fa0950958e3ad92@mail.gmail.com>
References: <q2qb401d2531005050445wb33461ecnab0f752909fb4a4@mail.gmail.com>
	 <20100505124401.GG970@ghostprotocols.net>
	 <20100505131230.GA10363@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100505131230.GA10363-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

On 5 May 2010 18:42, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 05, 2010 at 09:44:01AM -0300, Arnaldo Carvalho de Melo es=
creveu:
[..]
> https://bugzilla.redhat.com/show_bug.cgi?id=3D495606
>
> <quote>
> Actually this does not results in correct match because corresponding
> symbool name which we provide it with function arg is mangled. In cas=
e
> we want to get a perfect matched we need to provide it de-mangled act=
ual
> function name.
>
> But for C++ say (even in C) we can have more then one function with s=
ame
> name. =A0In that case right now it will just print the first match.
> </quote>
>
> So what you want is that we traverse all the C++ classes finding whic=
h
> ones have methods with that name, which is way more sensible than wha=
t
> pfunct, being mostly oriented, so far, to C, does.
>
> I don't have time right now to devote to this, but what you want is t=
o:
>

No problem, I will try to get some patches for review ready.

> 1. go on CU by CU looking at all structs
> 2. look at each namespace in them looking for functions with the desi=
red
> =A0 name, printing it in some C++ sensible way, perhaps:
>
> return_type1 class_foo::method_searched(parameter list1); /* mangled =
name=3DEQWTVARSAE */
> return_type2 class_foo::method_searched(parameter list2); /* mangled =
name=3DYTEYRWTQRD */
>
> etc.
>
> What I suggested about --all-units still is useful as we can have the
> functions with the same name in multiple object files in C too, they
> just have to be static not to cause linking problems.
>

Exactly,

I would consider it as a two step problem. First add --all-units which
works as you specified in previous reply. Later on work on what you
suggested in here (on giving output somewhat more sensible C++ way),
following the very algo you mentioned.

I will first work on former first (--all-units) and then later move to =
C++ :)

Between thanks for your suggestions.

Regards,

--=20
Rakesh Pandit
https://fedoraproject.org/wiki/User:Rakesh
freedom, friends, features, first
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
