From: Hagen Paul Pfeifer <hagen-GvnIQ6b/HdU@public.gmane.org>
Subject: Re: die__process_function: tag not supported (INVALID)!
Date: Fri, 17 Jul 2015 21:51:03 +0200 (CEST)
Message-ID: <2129979699.4572.1437162664096.JavaMail.open-xchange@ox1app>
References: <559E9FA5.1090307@gnu.org>
Reply-To: Hagen Paul Pfeifer <hagen-GvnIQ6b/HdU@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <559E9FA5.1090307-mXXj517/zsQ@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: DWARVES <dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bruce Korb <bkorb-mXXj517/zsQ@public.gmane.org>
List-Id: dwarves@vger.kernel.org



> On July 9, 2015 at 6:21 PM Bruce Korb <bkorb-mXXj517/zsQ@public.gmane.org> wrote:
> 
> 
> 1. What is that message trying to say?

Take a look here:

https://github.com/acmel/dwarves/blob/master/dwarf_loader.c#L1462

Two cases where tag__print_not_supported() is called -  you stumbled over
one of them.

Hagen
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
