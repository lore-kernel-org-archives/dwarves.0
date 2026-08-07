Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B7A395AD4;
	Fri,  7 Aug 2026 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786134660; cv=none; b=ThKMrwxVGrjV81UhqZal93yNf687FSDlMa5nM2Zk26dKjKjgQlPtldtuSYGQzszGSagfOGU1m1vvZj1DCk8NZVu/yB2eNLq5S94Je9WYVhcYphdUWMrSu5Dz7nGWUAzTWREP+5d951hNz2yzEqbHfmQWdkztv3iA6A4UEw1aVwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786134660; c=relaxed/simple;
	bh=2RhuFsKN6eClD1RC3T8UCpobkmhVAFvGB9mXP6BU+tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwHKRoUpBE/M8sqBoX7MksCmGyF/hEJFtSO+sbC/nNEwbaoYqCkAxI4WBvvILOBpndRkNHJhlGz4aqS+soaYKXNkBLIzenGErEvX913oWa0AcLB0cMuAb99wPVs0JLyO/c98hy0Z6/Iyu6atZybm0oQQF/lnzG/Py2c6/cGzWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3bVECdw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3bVECdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2951F000E9;
	Fri,  7 Aug 2026 20:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786134657;
	bh=gpq8pVcKoYWI6ShJ4Tw663ZVtPNrDJrx2olDMJJFU+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z3bVECdwExlUJG4FrdRif9eDCRvs1Gue/J2+8PLKNUzWwdLmzSJp7xAXyvF8m1tFw
	 364rjH51xfiOjfmBnoEGYgM7pCS0rq2BXoTbOIfL8jOIldpBUntPw4qUX51DdHOoZ0
	 noCPpmnytuIEPDxPY5OotO57hLfGoqqksmuojSUkUtJFn2rj51/N0AZ2mlxxgnuLh4
	 OLq3ixnA4ruA/UB1NFjFI1BniDX7ivGvInPGrfmxaMaM4mWCcnYfMFW5N3POIBsYuU
	 N2wSTMIyXvmksU7SPHEv283XIMOOOW2B0dOGmCmYHEenawvOlazuOR4Y936VzW9tYA
	 WXAdW0MkgZcXw==
Date: Fri, 7 Aug 2026 17:30:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>, dwarves@vger.kernel.org,
	bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mark Wieelard <mjw@redhat.com>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Gary Guo <gary@garyguo.net>
Subject: Re: [PATCHES 00/12] pahole: Support more rust tags and references to
 dwz alternate debug files
Message-ID: <anZAfc7sikAx8ikS@x1>
References: <20260731193102.110693-1-acme@kernel.org>
 <18b557a8-e1ca-46cf-b03f-5e68490c9229@oracle.com>
 <anXTAComw6XAvnXU@x1>
 <CANiq72nHWY638h4mxJCfh_HFtzhwFEPyo6a-7k_3CxZsRV+Jiw@mail.gmail.com>
 <anYpwcDBtkzE3WIt@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anYpwcDBtkzE3WIt@x1>

On Fri, Aug 07, 2026 at 03:53:53PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Aug 07, 2026 at 07:34:10PM +0200, Miguel Ojeda wrote:
> > On Fri, Aug 7, 2026 at 2:43 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Adding Miguel to the CC list, Miguel we're trying to improve BTF support
> > > for Rust, this series handles multiple enabling fixes/improvements that
> > > gets us to the next level, i.e. we can load everything from DWARF, now

> > Thanks for the Cc! Cc'ing rust-for-linux and Gary.

> > > its time to try to map it to existing BTF kinds and propose BTF
> > > extensions when we can't use existing encodings.

> > Sounds cool :)

> > > Inferring from "does any member have a niche layout" means
> > > reverse-engineering rustc's layout algorithm, which is explicitly
> > > unstable and unspecified. It'd break silently on a compiler bump, with
> > > no way to tell from the DWARF that you got it wrong.

> > Yeah, the LLM is correct here: the Rust compiler gives very few
> > guarantees for the default `repr`, i.e. in common cases it has the
> > freedom to use whatever layout it wants (i.e. even for essentially
> > equivalent types in the same compilation unit) -- the official docs
> > are at:

> >   https://doc.rust-lang.org/reference/type-layout.html

> > >     u8                  __discriminant;      /*  0  1 */

> > For the niche cases like `Option<NonZero<u32>>`, what would be printed?
 
> Can you think about one such niche case that is present in the kernel
> rust .o files right now? I tried finding the `Option<NonZero<u32>>` to
> look at its DWARF but couldn't find one.

Good, so I went ahead and built the exact case, together with the
explicit `Option<u32>` one, so we can compare them.  The source,
containing the struct I dump below:

  use std::num::NonZeroU32;

  #[no_mangle]
  pub struct Container {
  	pub a: Option<NonZeroU32>,  // niche: 4 bytes, tag == payload
  	pub b: Option<u32>,        // explicit: tag at 0, payload at 4
  	pub c: Option<i32>,
  }

  #[no_mangle]
  pub fn consume(c: Container) -> u32 {
  	c.a.map(|x| x.get()).unwrap_or(0) + c.b.unwrap_or(0)
  }

  fn main() {
  	let c = Container { a: None, b: Some(3), c: Some(-1) };
  	let _ = consume(c);
  }

Compile (rustc 1.93.x here, don't link, just get an object file,
otherwise you'll debug 1M+ lines of std DWARF and the type will be
there but buried):

  acme@number:~/git/pahole$ rustc --edition 2021 --emit=obj -C debuginfo=2 \
  				  option_non_zero.rs -o option_non_zero.o

then dump the DWARF, note that the DW_AT_name has the expanded generic,
i.e. 'Option<core::num::nonzero::NonZero<u32>>', the NonZeroU32 alias
seems to be expanded at compile time and, thus, doesn't appear in DWARF:

  acme@number:~/git/pahole$ readelf --debug-dump=info option_non_zero.o \
  				  | grep -n 'nonzero::NonZero<u32>'
				  acme@number:~$ readelf --debug-dump=info option_non_zero.o | grep -n 'nonzero::NonZero<u32>'
  295: <2ca>   DW_AT_name  : (indirect string, offset: 0x213): Option<core::num::nonzero::NonZero<u32>>
  348: <32e>   DW_AT_name  : (indirect string, offset: 0x2ef): map<core::num::nonzero::NonZero<u32>, u32, option_non_zero::consume::{closure_env#0}>
  acme@number:~$

and you can see the niche case layout, size 4, the discriminant member
is the payload itself, same offset, same size, and the Some variant
doesn't even get a DW_AT_discr_value, it is just the default, so the
answer: nothing separate to print, the tag IS the payload.

Here is the full DIE for the niche case:

acme@number:~$ readelf --debug-dump=info option_non_zero.o | grep -B1 -A25 'Option<core::num::nonzero::NonZero<u32>>'
 <3><2c9>: Abbrev Number: 19 (DW_TAG_structure_type)
    <2ca>   DW_AT_name        : (indirect string, offset: 0x213): Option<core::num::nonzero::NonZero<u32>>
    <2ce>   DW_AT_byte_size   : 4
    <2cf>   DW_AT_accessibility: 1	(public)
    <2d0>   DW_AT_alignment   : 4
 <4><2d1>: Abbrev Number: 26 (DW_TAG_variant_part)
    <2d2>   DW_AT_discr       : <0x2d6>
 <5><2d6>: Abbrev Number: 27 (DW_TAG_member)
    <2d7>   DW_AT_type        : <0x5b2>
    <2db>   DW_AT_alignment   : 4
    <2dc>   DW_AT_data_member_location: 0
    <2dd>   DW_AT_artificial  : 1
 <5><2dd>: Abbrev Number: 28 (DW_TAG_variant)
    <2de>   DW_AT_discr_value : 0
 <6><2df>: Abbrev Number: 4 (DW_TAG_member)
    <2e0>   DW_AT_name        : (indirect string, offset: 0x1ce): None
    <2e4>   DW_AT_type        : <0x2f9>
    <2e8>   DW_AT_alignment   : 4
    <2e9>   DW_AT_data_member_location: 0
 <6><2ea>: Abbrev Number: 0
 <5><2eb>: Abbrev Number: 29 (DW_TAG_variant)
 <6><2ec>: Abbrev Number: 4 (DW_TAG_member)
    <2ed>   DW_AT_name        : (indirect string, offset: 0x20e): Some
    <2f1>   DW_AT_type        : <0x30b>
    <2f5>   DW_AT_alignment   : 4
    <2f6>   DW_AT_data_member_location: 0
 <6><2f7>: Abbrev Number: 0
acme@number:~$

On the explicit `Option<u32>` case the picture is different, the tag is
a real member at offset 0 with 4 bytes and Some.__0 moved to offset 4:

acme@number:~$ readelf --debug-dump=info option_non_zero.o | grep -B1 -A25 'Option<u32>'
 <3><360>: Abbrev Number: 19 (DW_TAG_structure_type)
    <361>   DW_AT_name        : (indirect string, offset: 0x345): Option<u32>
    <365>   DW_AT_byte_size   : 8
    <366>   DW_AT_accessibility: 1	(public)
    <367>   DW_AT_alignment   : 4
 <4><368>: Abbrev Number: 26 (DW_TAG_variant_part)
    <369>   DW_AT_discr       : <0x36d>
 <5><36d>: Abbrev Number: 27 (DW_TAG_member)
    <36e>   DW_AT_type        : <0x5b2>
    <372>   DW_AT_alignment   : 4
    <373>   DW_AT_data_member_location: 0
    <374>   DW_AT_artificial  : 1
 <5><374>: Abbrev Number: 28 (DW_TAG_variant)
    <375>   DW_AT_discr_value : 0
 <6><376>: Abbrev Number: 4 (DW_TAG_member)
    <377>   DW_AT_name        : (indirect string, offset: 0x1ce): None
    <37b>   DW_AT_type        : <0x391>
    <37f>   DW_AT_alignment   : 4
    <380>   DW_AT_data_member_location: 0
 <6><381>: Abbrev Number: 0
 <5><382>: Abbrev Number: 28 (DW_TAG_variant)
    <383>   DW_AT_discr_value : 1
 <6><384>: Abbrev Number: 4 (DW_TAG_member)
    <385>   DW_AT_name        : (indirect string, offset: 0x20e): Some
    <389>   DW_AT_type        : <0x3a3>
    <38d>   DW_AT_alignment   : 4
    <38e>   DW_AT_data_member_location: 0
acme@number:~$

So this is the one where we want a synthetic __discriminant member.

And what we do today for the niche one, with current pahole (built from
this series):

acme@number:~$ pahole -C 'Option<core::num::nonzero::NonZero<u32>>' option_non_zero.o
struct Option<core::num::nonzero::NonZero<u32>> {
	struct None {

		/* size: 4, cachelines: 1, members: 0 */
		/* padding: 4 */
		/* last cacheline: 4 bytes */
	} __attribute__((__aligned__(4)));

	struct Some {
	public:

		struct NonZero<u32>        __0 __attribute__((__aligned__(4))); /*     0     4 */

		/* size: 4, cachelines: 1, members: 1 */
		/* forced alignments: 1 */
		/* last cacheline: 4 bytes */
	} __attribute__((__aligned__(4)));

	struct Option<u32> map<core::num::nonzero::NonZero<u32>, u32, option_non_zero::consume::{closure_env#0}>(struct Option<core::num::nonzero::NonZero<u32>>, struct {closure_env#0});


	/* size: 4, cachelines: 1, members: 0 */
	/* padding: 4 */
	/* last cacheline: 4 bytes */
} __attribute__((__aligned__(4)));

acme@number:~$

and on the BTF side, also with this series:

acme@number:~$ pahole --btf_encode option_non_zero.o
acme@number:~$ pahole -F btf -C 'Option<core::num::nonzero::NonZero<u32>>' option_non_zero.o
union Option<core::num::nonzero::NonZero<u32>> {
	struct None                None;               /*     0     4 */
	struct Some                Some;               /*     0     4 */
};

acme@number:~$ pahole --expand_types -F btf -C 'Option<core::num::nonzero::NonZero<u32>>' option_non_zero.o
union Option<core::num::nonzero::NonZero<u32>> {
	struct None {
	} __attribute__((__aligned__(8))) None;                           /*     0     4 */
	struct Some {
		struct NonZero<u32> {
			struct NonZeroU32Inner {
				u32 __0;                                                 /*     0     4 */
			} __0; /*     0     4 */
		} __0; /*     0     4 */
	} Some; /*     0     4 */
};

acme@number:~$

matches the real in-memory layout, size 4, no extra member.

So for the future __discriminant work the rule should be: only emit it
when its location doesn't overlap with the payload, i.e. on the explicit
form; on the niche that field is the data itself, adding one would mean
two members covering the same bytes, and we'd be lying about the layout.

I'll add a test with both forms, pinning this behavior, so we don't
regress it, and then, when we improve support for the synthetic
discriminants, we can update it.

And yes, I used OpenCode + DeepSeek to iterate multiple times and
manually checked everything before hitting send, it helps me a lot and I
hope that if I missed something, you will correct me so that we can make
progress.

Regards,

- Arnaldo
