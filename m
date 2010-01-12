From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] scncopy: Fix minor problems with --usage.
Date: Tue, 12 Jan 2010 16:38:02 -0200
Message-ID: <20100112183802.GB2934@ghostprotocols.net>
References: <1263320238-21124-1-git-send-email-pjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1263320238-21124-1-git-send-email-pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Tue, Jan 12, 2010 at 01:17:18PM -0500, Peter Jones escreveu:
> - "-s section 0" doesn't really read the same as "-s section0"
> - "--help" is something we should allow
> - usage should say "scncopy" not "pjoc"

Please add a s-o-b line in the next patches.

Thanks, applied and pushed out!

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
