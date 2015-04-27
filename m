From: Cody Schafer <cody-QpQMm/NnEELQT0dZR+AlfA@public.gmane.org>
Subject: Re: pahole DW_TAG_mutable_type
Date: Mon, 27 Apr 2015 19:47:02 -0400
Message-ID: <CA+E_MsxY9sC2Eh2gSx5U1z7Ay-nPOnC3ZraaLzcopkSvwX6MJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Elliott, Robert (Server Storage)" <Elliott-VXdhtT5mjnY@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

On Mon, Apr 27, 2015 at 12:25 PM, Elliott, Robert (Server Storage)
<Elliott-VXdhtT5mjnY@public.gmane.org> wrote:
>
> Recent versions of libdwarves have removed DW_TAG_mutable_type, which
> affects dwarves_fprintf.c.
>                 http://www.spinics.net/lists/dwarves/msg00121.html
>
> This causes an error building pahole, which has a copy of dwarves_fprintf.c:
>
>
> [  8%] Building C object CMakeFiles/dwarves.dir/dwarves_fprintf.o
> /home/orange/sw/pahole/dwarves_fprintf.c:77:3: error: 'DW_TAG_mutable_type' undeclared here (not in a function)
>   [DW_TAG_mutable_type]    = "mutable_type",
>    ^
> /home/orange/sw/pahole/dwarves_fprintf.c:77:2: error: array index in initializer not of integer type
>   [DW_TAG_mutable_type]    = "mutable_type",
>   ^
> /home/orange/sw/pahole/dwarves_fprintf.c:77:2: error: (near initialization for 'dwarf_tag_names')
> make[2]: *** [CMakeFiles/dwarves.dir/dwarves_fprintf.o] Error 1
>
>
> Deleting that line seems to fix the problem.


I'm not upstream, I'm just some guy with a github repo of pahole :)

Redirecting this to the right mailing list, might already be fixed
upstream (https://git.kernel.org/cgit/devel/pahole/pahole.git), I
haven't checked.

Probably a good idea to add the mailing list (and git url) to the
README to make it more discover-able for folks that find the source
code in other places.
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
