From: Nicolas <nikos42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Brain fart alert
Date: Sat, 21 Jul 2012 20:22:33 +0200
Message-ID: <CACHCVZ6oDyFwGbC4EwF_wsR9tCkoych5N6buLhRRLcyaL6iifw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf307ac3fdae36f104c55b1892
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

--20cf307ac3fdae36f104c55b1892
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I tried using pahole, but I get a brain fart alert with the file
attached (which is an extract from stdio.h). I'm running dwarves 1.10,
libdw1 0.152 and g++ 4.6.1, on i386.

Here is what I get:

$ g++ -Wall -g -c brainfart.cpp -o brainfart.o && pahole brainfart.o
class ios_base {
	enum _Ios_Openmodeconst    in;                   /*     0     4 */
	typedef enum _Ios_Fmtflags fmtflags;


	/* size: 1, cachelines: 1, members: 1 */
	/* padding: 65533 */
	/* last cacheline: 1 bytes */

	/* BRAIN FART ALERT! 1 != 4 + 0(holes), diff = -3 */

};

Moreover, on amd64, pahole segfaults if I do the same (with dwarves
1.10, libdw1 0.152, g++ 4.6.3).

Any ideas?

Thanks a lot,
Nicolas

--20cf307ac3fdae36f104c55b1892
Content-Type: text/x-c++src; charset=US-ASCII; name="brainfart.cpp"
Content-Disposition: attachment; filename="brainfart.cpp"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h4x0tx0k0

bmFtZXNwYWNlIHN0ZAp7CiAgZW51bSBfSW9zX0ZtdGZsYWdzCiAgICB7CiAgICAgIGEgPSAxLAog
ICAgfTsKICBlbnVtIF9Jb3NfT3Blbm1vZGUKICAgIHsKICAgICAgX1NfaW4gPSAxTCA8PCAzLAog
ICAgfTsKICBjbGFzcyBpb3NfYmFzZQogIHsKICBwdWJsaWM6CiAgICB0eXBlZGVmIF9Jb3NfRm10
ZmxhZ3MgZm10ZmxhZ3M7CiAgICBzdGF0aWMgY29uc3QgX0lvc19PcGVubW9kZSBpbiA9IF9TX2lu
OwogIH07CiAgdm9pZCBzZXRpb3NmbGFncyhpb3NfYmFzZTo6Zm10ZmxhZ3MgX19tYXNrKSAgeyAg
fQp9Cg==
--20cf307ac3fdae36f104c55b1892--
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
