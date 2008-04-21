From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Add support for filtering classes based on name
Date: Mon, 21 Apr 2008 12:43:57 -0300
Message-ID: <20080421154357.GA30713@ghostprotocols.net>
References: <loom.20080421T141540-204@post.gmane.org> <20080421152754.GE12221@ghostprotocols.net> <9420C939-5776-4A75-AB06-9C50466BFBA0@transitive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9420C939-5776-4A75-AB06-9C50466BFBA0-1LojSYAwM1QXQ3Lr6voeyA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Rigby <davidr-1LojSYAwM1QXQ3Lr6voeyA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Mon, Apr 21, 2008 at 04:32:52PM +0100, Dave Rigby escreveu:
>
> On 21 Apr 2008, at 16:27, Arnaldo Carvalho de Melo wrote:
>
>> Em Mon, Apr 21, 2008 at 02:22:14PM +0000, Dave Rigby escreveu:
>>> i,
>>>
>>> While pahole allows you to exclude classes with a specified prefix (using
>>> --exclude), it doesn't appear to be able to do the opposite - only show
>>> classes with a specific prefix. I found I needed this for my own use of 
>>> it,
>>> so here is a patch to add this functionality. It seems like it could be
>>> useful for others:
>>>
>>> Thanks
>>
>> Thanks a lot! May I add a:
>>
>> Signed-off-by: Dave Rigby <davidr-1LojSYAwM1QXQ3Lr6voeyA@public.gmane.org>
>>
>
> Sure, that's fine. I'm new to this git lark, so wasn't aware of that :)

Then thanks again, works like a charm:

[acme@doppio pahole]$ pahole --sizes -y argp build/pahole 
argp_child	32	1
argp		56	0
argp_state	96	1
argp_option	48	2
[acme@doppio pahole]$

Applied and pushed out, please do a git-pull :-)

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
