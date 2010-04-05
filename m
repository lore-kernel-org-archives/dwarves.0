From: Rakesh Pandit <rakesh.pandit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dwarf_loader.c: Fixed leaked bogon
Date: Mon, 5 Apr 2010 12:57:15 +0530
Message-ID: <k2sb401d2531004050027z43f91c9xe946bd95a0205670@mail.gmail.com>
References: <b401d2531001060724r4a06401fx9cc8a5dbf24518d3@mail.gmail.com>
	 <20100106164444.GB18919@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100106164444.GB18919-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

On 6 January 2010 22:14, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jan 06, 2010 at 08:54:59PM +0530, Rakesh Pandit escreveu:
>> While checking one of big shared objects I found kernel getting
>> unhappy and sending SIGKILL. File was 282M libwebkit-1.0.so.2.8.1 from
>> webkit project. (Can be obtained from
>> http://kojipkgs.fedoraproject.org/packages/webkitgtk/1.1.12/2.fc12/x86_64/webkitgtk-debuginfo-1.1.12-2.fc12.x86_64.rpm
>> and extracted via rpm2cpio, file is libwebkit-1.0.so.2.8.1.debug)
>>
>> URL: http://rakesh.fedorapeople.org/misc/0001-dwarf_loader.c-Fixed-leaked-bogon.patch
>
> What is the exact command line you are using? You cannot destroy that
> obstack if you really will use the extra debugging info that is has
> many pointers that will point to some other info if you destroy it.
>

Sorry for delay in responding. Hardly had any time to look at this
one. Will reply in few days.

-- 
Rakesh Pandit
https://fedoraproject.org/wiki/User:Rakesh
freedom, friends, features, first
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
