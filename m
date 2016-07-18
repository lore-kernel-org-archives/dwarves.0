From: David Beaulieu <david.beaulieu-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>
Subject: 16-bit id's in =?utf-8?b?Y3VfZm9yX2VhY2g=?= loops cause infinite loops with large libraries
Date: Mon, 18 Jul 2016 18:13:23 +0000 (UTC)
Message-ID: <loom.20160718T200805-633@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Hello,

I'm new to pahole (great tool!)... I downloaded the latest git source 
(b52386d041fac2dc6decf3a9e8e85385784a2de9) and tried to run it against a 
large library from my project. It got caught in an infinite loop in 
cu__find_base_type_by_sname_and_size() in the call to cu__for_each_type(). 
The reason was the uint16_t id was not big enough... it wraps around and 
is always less than cu->types_table.nr_entries. I changed it (and other 
instances of it in dwarves.c) to uint32_t, and that seems to have fixed 
the issue, but I don't know if there are any other side effects.

Anyway, hope this helps!

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
