From: Tom Tromey <tromey-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: failure with -gdwarf-4
Date: Fri, 01 Jul 2011 12:40:04 -0600
Message-ID: <m3d3htalq3.fsf@fleche.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

pahole doesn't understand the new DWARF 4 .debug_types section.

I'm using the F15 GCC, but really any recent-enough GCC will do.
I compile this:

    struct s
    {
      int x;
      int y : 5;
      int z;
    };
    struct s i;

    int main()
    {
    }

Like so:

    gcc -gdwarf-4 -g -o d d.c

Running pahole gives an error:

    $ pahole --class_name=s ./d
    tag__recode_dwarf_type: couldn't find 0x1d type for 0x51 (variable)!

It would be nice to have support for this feature in dwarves, as
.debug_types can greatly reduce the size of the debuginfo in the final
executable.

Tom

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
