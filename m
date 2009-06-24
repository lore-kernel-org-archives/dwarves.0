From: "=?ISO-8859-15?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org>
Subject: Re: Formatting "drivers" was Re: Can't persuade pahole to see through
 forward declarations
Date: Wed, 24 Jun 2009 09:58:43 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0906240954550.26611@melkinkari.cs.Helsinki.FI>
References: <20090615172409.6f0f322b@mozilla.com> <20090617170217.GB21530@ghostprotocols.net>
 <20090617102506.34aaf8e2@mozilla.com> <20090618183634.GE21530@ghostprotocols.net>
 <20090618132820.2eb7371a@mozilla.com> <20090618205053.GA4258@ghostprotocols.net>
 <Pine.LNX.4.64.0906240918170.26611@melkinkari.cs.Helsinki.FI>
 <20090623234018.61f1ce02@mozilla.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-696243445-1310615056-1245826723=:26611"
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090623234018.61f1ce02-4eJtQOnFJqFBDgjK7y7TUQ@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zack Weinberg <zweinberg-4eJtQOnFJqFBDgjK7y7TUQ@public.gmane.org>
Cc: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696243445-1310615056-1245826723=:26611
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 23 Jun 2009, Zack Weinberg wrote:

> "Ilpo Järvinen" <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org> wrote:
> > On Thu, 18 Jun 2009, Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Jun 18, 2009 at 01:28:20PM -0700, Zack Weinberg escreveu:
> > > >  - You do not have to process C declaration syntax to find the
> > > > name of each field.
> > 
> > Good point, this is one of the most complex tasks in scripts to get 
> > general case right. Besides typedefs, especially those function
> > pointers which appear in return value and arguments make it a task
> > too hairy for any sane people, not that I'd say it is
> > impossible... :-)
> 
> I used to hack gcc.  I know *exactly* how hard it is to parse C
> declarations. :-)
> 
> I had been doing okay, for the limited thing I am trying to do, with
> sed scripts to munge the pahole output into something that could be
> relatively easily parsed by a Python script, but then I ran into this
> construct:
> 
>   struct S {
>     ...
>     struct T {
>       int a;
>     } tee[2];
>   };
> 
> No hint that there are two copies of T embedded in S, here, until it's
> far too late to do anything about it (if you're a sed script).

Agreed, those kind of constructs are quite annoying. I'd probably do it so 
that I'd tac the input and preprocess it into something I can do line by 
line after another tac (but that of course has some performance penalty
if the input is very large).

-- 
 i.
---696243445-1310615056-1245826723=:26611--
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
