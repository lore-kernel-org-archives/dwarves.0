From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Unknown error 18446744073709551615
Date: Thu, 1 May 2008 17:12:00 -0300
Message-ID: <20080501201200.GG28327@ghostprotocols.net>
References: <m24p9idga9.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m24p9idga9.fsf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Diego 'Flameeyes' =?iso-8859-1?Q?Petten=F2?= <flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Thu, May 01, 2008 at 02:22:38AM +0200, Diego 'Flameeyes' Petten=F2 e=
screveu:
>=20
> I'm not sure what is causing this, but while trying to compare two
> different versions of openrc's rc binary I got this error. I'm runnin=
g
> dwarves from Git of a day or two ago.
>=20
> The two files are in http://www.flameeyes.eu/tmp/dwarves-error.tbz2

Tried several variants for the URL, all gave me:

[acme@doppio examples]$ wget
http://www.flameeyes.eu/tmp/dwarves-error.tbz2
--2008-05-01 17:11:14--  http://www.flameeyes.eu/tmp/dwarves-error.tbz2
Resolving www.flameeyes.eu... 213.239.249.247
Connecting to www.flameeyes.eu|213.239.249.247|:80... connected.
HTTP request sent, awaiting response... 404 Not Found
2008-05-01 17:11:15 ERROR 404: Not Found.

[acme@doppio examples]$=20

Can you please also make available the openrc rc binary that produces
this error?

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
