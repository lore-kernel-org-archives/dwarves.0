From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: ANNOUNCE: pahole v1.12 (BTF edition)
Date: Fri, 17 Aug 2018 11:38:25 -0300
Message-ID: <20180817143825.GA22443@kernel.org>
References: <20180816200942.GA19939@kernel.org>
 <nycvar.YFH.7.76.1808162328040.2839@n3.vanv.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1808162328040.2839@n3.vanv.qr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Engelhardt <jengelh@inai.de>
Cc: dwarves@vger.kernel.org, Dodji Seketeli <dodji@redhat.com>, Linux Networking Development Mailing List <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: dwarves@vger.kernel.org

Em Thu, Aug 16, 2018 at 11:49:38PM +0200, Jan Engelhardt escreveu:
> On Thursday 2018-08-16 22:09, Arnaldo Carvalho de Melo wrote:
> 
> >	After a long time without announces, here is pahole 1.12,
> >available at:
> >
> >	https://fedorapeople.org/~acme/dwarves/dwarves-1.12.tar.bz2
> >
> >	git://git.kernel.org/pub/scm/devel/pahole/pahole.git	
> >
> >	Some distros haven't picked 1.11, that comes with several
> >goodies, my bad for not having announced it at that time more widely,
> 
> Missing announcements can be forgiven. But there are automatic tools 
> that scrape the web for updates (usually something tries to scan
> the enclosing directory of the last known URL), so uploads are 
> essential.
> Since 1.11 was never uploaded, it did not find its way..
> (One had to grab a tarball gitweb generated from the tag,
> but had to know there was a 1.11, too).
> 
> 
> Can we have signatures for the release tarballs?
> (Only if you think it's worth having.)

Yeah, I think I can create a file with sha256 for the tarball and sign
it, just like I signed the v1.12 tag:

  https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tag/?h=v1.12
 
> >Please report any problems to me, I'll try and get problems fixed.
> 
> Here's one (or six):

Yeah, C++ has been a second class citizen for all pahole's life, with
progress being made mostly when I collaborate with folks at the ATLAS
project at CERN that had tons of C++ code being ported from 32-bit based
clusters to 64-bit ones.

I'll try to work some time on the reports below to see if we get a bit
more progress there.

> $ cat x.cpp 
> #include <utility>
> struct F {
>         template<typename T, typename... A> F(T &, T &&, A &&...x) { }
>         F clone() const && { int q; return F(q, 3, 4); }
>         int xpub() { return xprot(); }
>         protected:
>         int xprot() { return xpriv(); }
>         private:
>         int xpriv() { return 0; }
> };
> int z;
> F f(z,2,3,4);
> int main()
> {
>         f.xpub();
>         std::move(f).clone();
> }
> 
> 
> $ g++-7 x.cpp -c -ggdb3 -Wall && pahole x.o
> die__process_function: tag not supported 0x2f (template_type_parameter)!
> //expected: handle type
> die__process_function: tag not supported 0x4107 (GNU_template_parameter_pack)!
> //expected: handle type
> die__process_function: tag not supported 0x4108 (GNU_formal_parameter_pack)!
> //expected: handle type
> ftype__recode_dwarf_types: couldn't find 0x321 abstract_origin for 0x397 (formal_parameter)!
> //expected: handle type
> ftype__recode_dwarf_types: couldn't find 0x326 abstract_origin for 0x39f (formal_parameter)!
> ftype__recode_dwarf_types: couldn't find 0x3e0 abstract_origin for 0x447 (formal_parameter)!
> struct F {
>         class F clone(const class F  *);
> 	//expected: "struct F clone(const struct F *&&);"
> 
>         int xpub(class F *);
> 
> protected:
> 
>         int xprot(class F *);
> 
> private:
> 
>         int xpriv(class F *);
> 
> //expected: "public:"
> 
>         void F<int, int, int>(class F *, int &, , , );
> 	//expected: "void F<int, int, int>(struct F *, int &, int &&, int &&, int &&);
> 
>         void F<int, int>(class F *, int &, , );
> 	//expected: "void F<int, int, int>(struct F *, int &, int &&, int &&);
> 
>         /* size: 1, cachelines: 0, members: 0 */
>         /* last cacheline: 1 bytes */
> };
