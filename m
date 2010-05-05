From: Rakesh Pandit <rakesh.pandit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: option for printing all matching function names
Date: Wed, 5 May 2010 17:15:20 +0530
Message-ID: <q2qb401d2531005050445wb33461ecnab0f752909fb4a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Hello,

If we are using pfunct right with option --function, it prints the
first matched function name. This does not satisfy those cases where
object file has more then one functions with same name. I would like
it to print all matching cases not just the first one. Would it be
acceptable ? Or if it is not acceptable as it may break few scripts
written by users which are consuming the tool. An alternate
implementation could be if supplied with an extra option print all
matches and by default just print first one.

Suggestions ? If any of above to is acceptable I can straight right
down a patch accordingly.

Thanks,

-- 
Rakesh Pandit
https://fedoraproject.org/wiki/User:Rakesh
freedom, friends, features, first
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
