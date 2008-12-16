From: chipzz1 <chipzz1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: dwarfdump ERROR: =?utf-8?b?ZHdhcmZfZWxmX2luaXQ6?= =?utf-8?b?RFdfRExFX0lOSVRfQUNDRVNTX1dST05H?=
Date: Tue, 16 Dec 2008 18:36:54 +0000 (UTC)
Message-ID: <loom.20081216T183519-628@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

dwarfdump built on Cygwin (DLL version: 1.5.19) reports the following
error:

529> readelf -I foo0

Histogram for bucket list length (total of 37 buckets):
 Length  Number     % of total  Coverage
     0  23         ( 62.2%)
     1  11         ( 29.7%)     64.7%
     2  3          (  8.1%)    100.0%

530> dwarfdump foo0
dwarfdump ERROR:  dwarf_elf_init:  DW_DLE_INIT_ACCESS_WRONG 26 A call
to dwarf_init had an access of other than DW_DLC_READ (26)

531> dwarfdump -vv -V foo0
Version 4May2007
dwarfdump ERROR:  dwarf_elf_init:  DW_DLE_INIT_ACCESS_WRONG 26 A call
to dwarf_init had an access of other than DW_DLC_READ (26)


TIA,

chipzz1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
