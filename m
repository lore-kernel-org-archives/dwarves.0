From: Yulia Kartseva <hex-b10kYP2dOMg@public.gmane.org>
Subject: [PATCH 0/2] pahole: fix maybe-uninitialized and rpm build
Date: Thu, 16 Jan 2020 16:59:11 -0800
Message-ID: <cover.1579221668.git.hex@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Julia Kartseva <hex-b10kYP2dOMg@public.gmane.org>, andriin-b10kYP2dOMg@public.gmane.org
List-Id: dwarves@vger.kernel.org

From: Julia Kartseva <hex-b10kYP2dOMg@public.gmane.org>

Fix issues encountered while builing RPM w/ v1.16:
- maybe uninitialized variable in =E2=80=98pahole_stealer' function
- malformed date in dwarves.spec changelog causing rpm build failure

Arnaldo, I wonder if we can have v1.16 package bump in the distros sooner=
?
Thanks!

Julia Kartseva (2):
  pahole: fix compiler warning
  pahole: fix changelog date in dwarves.spec

 pahole.c               | 2 +-
 rpm/SPECS/dwarves.spec | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--=20
2.17.1
