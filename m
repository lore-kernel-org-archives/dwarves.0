From: Hagen Paul Pfeifer <hagen-GvnIQ6b/HdU@public.gmane.org>
Subject: Re: die__process_function: tag not supported (INVALID)!
Date: Fri, 17 Jul 2015 23:08:27 +0200 (CEST)
Message-ID: <701123757.4784.1437167307775.JavaMail.open-xchange@ox1app>
References: <559E9FA5.1090307@gnu.org> <2129979699.4572.1437162664096.JavaMail.open-xchange@ox1app> <55A96B38.7050103@gnu.org>
Reply-To: Hagen Paul Pfeifer <hagen-GvnIQ6b/HdU@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55A96B38.7050103-mXXj517/zsQ@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: DWARVES <dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, bkorb <bkorb-mXXj517/zsQ@public.gmane.org>
List-Id: dwarves@vger.kernel.org

> On July 17, 2015 at 10:53 PM Bruce Korb <bkorb-mXXj517/zsQ@public.gmane.org> wrote:
>
> Now that I've read the source, I don't know what to do.
> I really did not mean to have a GNU_call_site in my code,
> so is there something to do to make pahole happy?
> (It's not C++, so I'm guessing it isn't the template thing...)
> I assume that consideration was made to just ignore it,
> but it didn't work out?  Is there a way to print tags?
> "man readelf" didn't seem to get me anywhere.

Can you post a minimal example and your exact build environment including
compiler flags? This would speed up the process ...

Hagen
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
