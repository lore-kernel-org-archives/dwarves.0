From: Bruce Korb <bkorb-mXXj517/zsQ@public.gmane.org>
Subject: Re: die__process_function: tag not supported (INVALID)!
Date: Fri, 17 Jul 2015 13:53:12 -0700
Message-ID: <55A96B38.7050103@gnu.org>
References: <559E9FA5.1090307@gnu.org> <2129979699.4572.1437162664096.JavaMail.open-xchange@ox1app>
Reply-To: bkorb-mXXj517/zsQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2129979699.4572.1437162664096.JavaMail.open-xchange@ox1app>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hagen Paul Pfeifer <hagen-GvnIQ6b/HdU@public.gmane.org>, DWARVES <dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: dwarves@vger.kernel.org

On 07/17/15 12:51, Hagen Paul Pfeifer wrote:
>
>
>> On July 9, 2015 at 6:21 PM Bruce Korb <bkorb-mXXj517/zsQ@public.gmane.org> wrote:
>>
>>
>> 1. What is that message trying to say?
>
> Take a look here:
>
> https://github.com/acmel/dwarves/blob/master/dwarf_loader.c#L1462
>
> Two cases where tag__print_not_supported() is called -  you stumbled over
> one of them.

Now that I've read the source, I don't know what to do.
I really did not mean to have a GNU_call_site in my code,
so is there something to do to make pahole happy?
(It's not C++, so I'm guessing it isn't the template thing...)
I assume that consideration was made to just ignore it,
but it didn't work out?  Is there a way to print tags?
"man readelf" didn't seem to get me anywhere.

Thank you!

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
