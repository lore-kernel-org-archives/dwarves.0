From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dwarves_fprintf.c: DW_TAG_mutable_type doesn't exist.
Date: Thu, 3 Jul 2014 12:34:37 -0300
Message-ID: <20140703153437.GC2745@redhat.com>
References: <1403082847-15424-1-git-send-email-mjw@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403082847-15424-1-git-send-email-mjw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Wielaard <mjw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Wed, Jun 18, 2014 at 11:14:07AM +0200, Mark Wielaard escreveu:
> DW_TAG_mutable_type was a mistake in an early DWARFv3 draft and was removed
> in the final version. http://dwarfstd.org/ShowIssue.php?issue=050223.1

Thanks, applied.

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
