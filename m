From: Dave Rigby <davidr-1LojSYAwM1QXQ3Lr6voeyA@public.gmane.org>
Subject: Re: [PATCH] Add support for filtering classes based on name
Date: Mon, 21 Apr 2008 16:32:52 +0100
Message-ID: <9420C939-5776-4A75-AB06-9C50466BFBA0@transitive.com>
References: <loom.20080421T141540-204@post.gmane.org> <20080421152754.GE12221@ghostprotocols.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080421152754.GE12221-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org


On 21 Apr 2008, at 16:27, Arnaldo Carvalho de Melo wrote:

> Em Mon, Apr 21, 2008 at 02:22:14PM +0000, Dave Rigby escreveu:
>> i,
>>
>> While pahole allows you to exclude classes with a specified prefix  
>> (using
>> --exclude), it doesn't appear to be able to do the opposite - only  
>> show
>> classes with a specific prefix. I found I needed this for my own  
>> use of it,
>> so here is a patch to add this functionality. It seems like it  
>> could be
>> useful for others:
>>
>> Thanks
>
> Thanks a lot! May I add a:
>
> Signed-off-by: Dave Rigby <davidr-1LojSYAwM1QXQ3Lr6voeyA@public.gmane.org>
>

Sure, that's fine. I'm new to this git lark, so wasn't aware of that :)


Dave Rigby
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
