From: Bart Trojanowski <bart-LIbhotJ4rFdeoWH0uzbU5w@public.gmane.org>
Subject: extracting data access from functions
Date: Tue, 27 Jan 2009 10:11:25 -0500
Message-ID: <20090127151124.GA18307@jukie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

I am trying to do some data mining on a large code base.  I would like
to generate a list of structure members accessed by certain functions.

After studying the examples in the pahole.git tree, I am able to walk
the dwarves structures down to the right tags.  However, I am not sure
how to make the next step.

For example, given

void foo(struct s *s)
{
        ... s->var ...
}

I would like to have a tool that reports foo accessing s->var.

Is that possible with the DWARF debug tags?  Maybe using elftools?  I am
trying to avoid the temptation of parsing the C code in perl :)

Thanks in advance.

Cheers,
-Bart

-- 
				WebSig: http://www.jukie.net/~bart/sig/
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
