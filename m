Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE018474255;
	Fri,  7 Aug 2026 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106648; cv=none; b=nEJeOqLJNTUOyyz9T1RPh24tuKGPT9/dUZ2TgpvWyPvwQyqWv415WlvCDpBvUp3PFbCjyBcTrjM7tM2OdkzyTVQ5Ittx8apHFXwfY5JKOns509oi7l5tcJRfLpBiExCaNmQ/TaxoEAaEo/7ofDFpO1NCAC85UIFiYsX+0hba3P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106648; c=relaxed/simple;
	bh=mEqdHq3zAQdwAH5qwSb9GfrlEy2DgN7nM0JCewlN0lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcJN/JF0J36AHbwTH8y/75pt0ei/+YdF9hUWs3ozycD+7NTsM+3ChGdFjL77PuE6hGElxkjZdQRhvHbgkveNBR6VjCa2Olvb+M3OZpYfDu54a+9z34ZhKFwrE9s8wD7HsU8KQq2s1OjxfDIy7ahismT4kH6oyd4lJZM9x64uMpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNSKcXfz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNSKcXfz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22261F000E9;
	Fri,  7 Aug 2026 12:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786106628;
	bh=d+ti9cD3m5Jq2uOB+xKC+ttmlcU5brp+ALk1T6yW+UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TNSKcXfza9PdM0BY+Sem3v8/beCd2BW4kKtPXTehyGK62vw7giD88eaiayVkzC1TP
	 NyUMSnrm6yP6W12ykm9DHjgxg5QgCCh8yShpCdPBXbxf5YPT6TeA9IfGjMVmB8j63P
	 DVH+VHxeeLOi/5jqOck9kEBCjc+7PY5INMbSNwA19fWf6l1p0LP1Rpj8A+jqh+H7/D
	 FktXHcSYVjz7fYvDP0B3IQ8GJPJdffajmd+f/IzGSJ7ydYfdzREq9ryQ2O7k7tCP0z
	 v8tMvMmlu4BBzX+6XmnsglGS6u0hmQLzSP1vZLkRcmTAGQDfF1Exicji1NhmkvVafl
	 lE3506CSKEspw==
Date: Fri, 7 Aug 2026 09:43:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org, bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mark Wieelard <mjw@redhat.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCHES 00/12] pahole: Support more rust tags and references to
 dwz alternate debug files
Message-ID: <anXTAComw6XAvnXU@x1>
References: <20260731193102.110693-1-acme@kernel.org>
 <18b557a8-e1ca-46cf-b03f-5e68490c9229@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18b557a8-e1ca-46cf-b03f-5e68490c9229@oracle.com>

Adding Miguel to the CC list, Miguel we're trying to improve BTF support
for Rust, this series handles multiple enabling fixes/improvements that
gets us to the next level, i.e. we can load everything from DWARF, now
its time to try to map it to existing BTF kinds and propose BTF
extensions when we can't use existing encodings.

On Fri, Aug 07, 2026 at 09:09:16AM +0100, Alan Maguire wrote:
> On 31/07/2026 20:30, Arnaldo Carvalho de Melo wrote:
> > Add support for Rust discriminated unions (enums with explicit
> > discriminants).
> > 
> > Rust enums like Option<u32> and Result<i32,u8> are represented in DWARF
> > as DW_TAG_variant_part containing DW_TAG_variant children with
> > discriminant values. These patches:
> > 
> >   - Load DW_TAG_variant_part containers with discriminant tracking
> >   - Populate DW_TAG_variant children with discriminant values
> >   - Handle DW_FORM_block encoding for discriminant values
> >   - Handle DW_TAG_subprogram inside DW_TAG_enumeration (Rust methods)
> >   - Encode variant parts as BTF_KIND_UNION members
> > 
> > Before: Rust Option<u32> showed as empty struct (0 members)
> > 
> > After:  Shows None and Some variants with correct layout
> > 
> >   === pahole --expand_types output ===
> >   struct Option<u32> {
> >       struct None {
> >       } __attribute__((__aligned__(4)));
> >       struct Some {
> >           /* XXX 4 bytes hole, try to pack */
> >           u32  __0 __attribute__((__aligned__(4)));  /*  4  4 */
> >       } __attribute__((__aligned__(4)));
> >   } __attribute__((__aligned__(4)));
> > 
> > BTF has no discriminated-union kind, so variant parts are tentatively
> > encoded as BTF_KIND_UNION with overlapping members at offset 0. Further
> > discussion is needed to see if we can keep that.
 
> It seems like these variants mostly have a leading discriminating
> value (telling us which variant is selected), and it looks like it is
> possible to infer its presence by determining by its members if it has 
> that discriminant (do any members have niche layout? if not it is there)
> and its size (depends on the number of variants). Given that, would
> it make sense to have a discriminant too? It seems that the above
> example Option<u32> has one, so we'd have
 
> struct Option<u32> {
>     uint8_t tag;          // 1 byte: Explicit discriminant
>     uint8_t pad[3];
>     struct Some {
> ...
 
> This would give us a better match for the in-memory representation.
> What do you think, is it doable?

It seems we have help from DWARF5 for that, I'm studying this Opus 4.8
response:

-------------

Don't infer it, read DW_AT_discr. Per DWARF 5 §5.7.10,
DW_TAG_variant_part carries DW_AT_discr referencing a DW_TAG_member
child of the variant part itself — the tag, with a real type, real
DW_AT_data_member_location, real size. That member is being dropped on
the floor today, which is exactly why Some.__0 shows a phantom 4-byte
hole instead of the true 1-byte tag + 3-byte pad. Load it as an ordinary
member of the enclosing struct and the layout falls out correct with no
heuristics. (If DW_AT_discr is absent but DW_AT_type is present on the
variant part, the tag exists but isn't separately addressable — that's
the spec's signal, not something you compute.)

Inferring from "does any member have a niche layout" means
reverse-engineering rustc's layout algorithm, which is explicitly
unstable and unspecified. It'd break silently on a compiler bump, with
no way to tell from the DWARF that you got it wrong.

Where it gets sharp:

Niche-optimized enums overlap. For Option<&T> or Option<NonZeroU32> the
discriminant member is the payload field — same offset, same bytes.
Emitting it unconditionally gives you two members at offset 0 covering
the same storage. So the rule wants to be: emit as a struct member only
when it doesn't overlap any variant's members; otherwise it belongs
inside the union encoding, where overlap is already the semantics.

Tag isn't always at offset 0. rustc places it after the payload in some
layouts when that shrinks the type. Take the offset from the DIE.

Naming. rustc frequently emits the tag member unnamed/DW_AT_artificial.
You'll need a synthetic name, and it lands in BTF where consumers will
see it forever. Worth picking something unmistakably synthetic rather
than plausible-looking.

DW_AT_discr_list. Niche layouts use range lists
(DW_DSC_label/DW_DSC_range in a block), not a scalar DW_AT_discr_value.
Your DW_FORM_block handling is the right groundwork but the list form is
a separate shape.
-------------

 <1><931e405>: Abbrev Number: 6 (DW_TAG_base_type)
    <931e406>   DW_AT_name        : (indirect string, offset: 0x8235d): u32
    <931e40a>   DW_AT_encoding    : 7   (unsigned)
    <931e40b>   DW_AT_byte_size   : 4

 <3><92dadb3>: Abbrev Number: 8 (DW_TAG_structure_type)
    <92dadb4>   DW_AT_name        : (indirect string, offset: 0x205eab): Option<u32>
    <92dadb8>   DW_AT_byte_size   : 8
    <92dadb9>   DW_AT_accessibility: 1	(public)
    <92dadba>   DW_AT_alignment   : 4
 <4><92dadbb>: Abbrev Number: 56 (DW_TAG_variant_part)
    <92dadbc>   DW_AT_discr       : <0x92dadc0>
 <5><92dadc0>: Abbrev Number: 57 (DW_TAG_member)
    <92dadc1>   DW_AT_type        : <0x931e405>
    <92dadc5>   DW_AT_alignment   : 4
    <92dadc6>   DW_AT_data_member_location: 0
    <92dadc7>   DW_AT_artificial  : 1
 <5><92dadc7>: Abbrev Number: 58 (DW_TAG_variant)
    <92dadc8>   DW_AT_discr_value : 0
 <6><92dadc9>: Abbrev Number: 4 (DW_TAG_member)
    <92dadca>   DW_AT_name        : (indirect string, offset: 0x3c4642): None
    <92dadce>   DW_AT_type        : <0x92dade4>
    <92dadd2>   DW_AT_alignment   : 4
    <92dadd3>   DW_AT_data_member_location: 0
 <6><92dadd4>: Abbrev Number: 0
 <5><92dadd5>: Abbrev Number: 58 (DW_TAG_variant)
    <92dadd6>   DW_AT_discr_value : 1
 <6><92dadd7>: Abbrev Number: 4 (DW_TAG_member)
    <92dadd8>   DW_AT_name        : (indirect string, offset: 0x3bf339): Some
    <92daddc>   DW_AT_type        : <0x92dadf6>
    <92dade0>   DW_AT_alignment   : 4
    <92dade1>   DW_AT_data_member_location: 0
 <6><92dade2>: Abbrev Number: 0
 <5><92dade3>: Abbrev Number: 0
 <4><92dade4>: Abbrev Number: 8 (DW_TAG_structure_type)
    <92dade5>   DW_AT_name        : (indirect string, offset: 0x3c4642): None
    <92dade9>   DW_AT_byte_size   : 8
    <92dadea>   DW_AT_accessibility: 1	(public)
    <92dadeb>   DW_AT_alignment   : 4
 <5><92dadec>: Abbrev Number: 59 (DW_TAG_template_type_param)
    <92daded>   DW_AT_type        : <0x931e405>
    <92dadf1>   DW_AT_name        : (indirect string, offset: 0x29c455): T
 <5><92dadf5>: Abbrev Number: 0
 <4><92dadf6>: Abbrev Number: 8 (DW_TAG_structure_type)
    <92dadf7>   DW_AT_name        : (indirect string, offset: 0x3bf339): Some
    <92dadfb>   DW_AT_byte_size   : 8
    <92dadfc>   DW_AT_accessibility: 1	(public)
    <92dadfd>   DW_AT_alignment   : 4
 <5><92dadfe>: Abbrev Number: 59 (DW_TAG_template_type_param)
    <92dadff>   DW_AT_type        : <0x931e405>
    <92dae03>   DW_AT_name        : (indirect string, offset: 0x29c455): T
 <5><92dae07>: Abbrev Number: 9 (DW_TAG_member)
    <92dae08>   DW_AT_name        : (indirect string, offset: 0x2c1fb): __0
    <92dae0c>   DW_AT_type        : <0x931e405>
    <92dae10>   DW_AT_alignment   : 4
    <92dae11>   DW_AT_data_member_location: 4
    <92dae12>   DW_AT_accessibility: 1	(public)
 <5><92dae13>: Abbrev Number: 0
 <4><92dae14>: Abbrev Number: 0

So in this case it says the discriminant is indeed at offset zero:

 <4><92dadbb>: Abbrev Number: 56 (DW_TAG_variant_part)
    <92dadbc>   DW_AT_discr       : <0x92dadc0>
 <5><92dadc0>: Abbrev Number: 57 (DW_TAG_member)
    <92dadc1>   DW_AT_type        : <0x931e405>
    <92dadc5>   DW_AT_alignment   : 4
    <92dadc6>   DW_AT_data_member_location: 0
    <92dadc7>   DW_AT_artificial  : 1

I.e. DW_AT_discr points to that artificial member, we need to synthesize
a name for it as BTF doesn't support nameless members, and we're using
it to:

        if (tag->tag == DW_TAG_imported_module || tag->tag == DW_TAG_imported_declaration)
                dwarf_tag__set_attr_type(dtag, type, die, DW_AT_import, cu);
        else if (tag->tag == DW_TAG_variant_part)
                dwarf_tag__set_attr_type(dtag, type, die, DW_AT_discr, cu);
        else
                dwarf_tag__set_attr_type(dtag, type, die, DW_AT_type, cu);

Set the variant part type.

_and_

static struct variant *variant__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
{
        struct variant *var = tag__alloc(cu, sizeof(*var));

        if (var != NULL) {
                tag__init(&var->tag, cu, die);
                /* DW_AT_discr_value uses DW_FORM_block, needs target endianness */
                var->discr_value = __attr_numeric(die, DW_AT_discr_value, cu->little_endian);

But that now is just a read only field:

acme@number:~/git/pahole$ grep discr_value *.[ch]
dwarf_loader.c: * When the attribute can be a block (e.g. DW_AT_discr_value), use
dwarf_loader.c:		/* DW_AT_discr_value uses DW_FORM_block, needs target endianness */
dwarf_loader.c:		var->discr_value = __attr_numeric(die, DW_AT_discr_value, cu->little_endian);
dwarves.h:	uint64_t	 discr_value;
acme@number:~/git/pahole$

We need to use it when pretty printing structs, encoding BTF
(synthesizing some "__discriminant" member that can be used by the BPF
verifier, etc) and in the hole calculations. Pretty printing it with the
current C only code would be done with a comment.

So the way this series does now is incomplete, but moves the needle a
bit, but lemme try to cook up a patch that removes the "3 bytes hole,
try to pack" comment on the alignent hole that sometimes gets after the
artifical member that is the discriminant and the payload, as nobody can
actually make use of that, i.e. if the member is a discriminant, the
comment can be "discriminant hole, unusable" or some other better
phrasing.

I.e. something like:

struct Option<u32> {
    u8                  __discriminant;      /*  0  1 */

    /* 3 byte discriminant hole, innacessible */

    union {
        struct None {
        };
        struct Some {
            u32         __0;                 /*  0  4 */
        };
    };                                       /*  4  4 */
};

Right now we have:

acme@number:~/git/pahole$ pahole --expand_types -F btf -C 'Option<u32>' vmlinux.btf
union Option<u32> {
	struct None {
	} __attribute__((__aligned__(16))) None;                          /*     0     8 */
	struct Some {

		/* XXX 4 bytes hole, try to pack */

		u32                __0 __attribute__((__aligned__(8)));                  /*     4     4 */
	} Some; /*     0     8 */
};

acme@number:~/git/pahole$

Which is just not showing the discriminant, so perhaps, to make
progress, we can land the series and work on top of it?

Supporting DWARF5 and cross cu references helps testing building the
kernel with:

│ vmlinux.dwarf5.zstd       │ 454.7MB │   5 │ GNU C11 16.1.1 -gdwarf-5 -gz=zstd │ 218.1MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │

And if it proves reliable (should be from my tests so far) we can speed
up building the kernel, which in itself is a big improvement.

Regards,

- Arnaldo
  
> > DW_FORM_block byte order fix: uses CU-recorded endianness instead of
> > assuming little-endian when decoding DW_AT_const_value and
> > DW_AT_default_value. Fixes cross-endian DWARF processing (e.g.  reading
> > big-endian s390x debug info on x86).
> > 
> > Also add support for cross-CU type references and dwz alternate debug
> > files.
> > 
> > This is needed to improve the support for, among other things, Rust, as
> > noticed in the pretty printing or a perf binary that has rust objects
> > linked, built by clang/llvm that use cross-CU references.
> > 
> > DW_TAG_imported_unit support:
> > 
> >   Handle same-file partial units where types are shared across CUs
> >   via DW_TAG_imported_unit. Force-merge CUs that contain inter-CU
> >   references (DW_FORM_ref_addr) so type lookups resolve correctly.
> > 
> >   Fix cus__merging_cu failing to detect DW_FORM_ref_addr when
> >   DW_FORM_implicit_const causes dwarf_getabbrevattr() to fail.
> > 
> > dwz alternate debug file support:
> > 
> >   Handle DW_FORM_GNU_ref_alt references to dwz-compressed alternate
> >   debug files (.dwz). Pre-processes all alternate partial units with
> >   separate hash tables and dedup tracking.
> > 
> >   Before (Firefox): 1774 "has no entry in cu" errors
> >   After:  processes cleanly with 0 errors
> > 
> >   Firefox uses dwz compression which moves common types into a
> >   separate .dwz file and replaces duplicates with DW_FORM_GNU_ref_alt
> >   references. pahole now pre-loads the alternate file's partial units,
> >   resolves all cross-file references, and processes Firefox DWARF
> >   cleanly.
> > 
> > Includes inter-CU type reference comparison test and
> > vmlinux_comparison.py for DWARF/BTF analysis across kernel configs.
> > 
> > Known limitations:
> >   - Pruning of unreferenced alt PUs is conservatively over-approximated
> >   - Merged-CU path is single-threaded by design
> > 
> > This makes pahole to be able to support more of the CONFIG_DEBUG_ DWARF
> > options, including DWARF5 and compression, see the latest patch in the
> > series for more details about how this table is produced:
> > 
> >   ┌───────────────────────────┬─────────┬─────┬───────────────────────────────────┬─────────┬───────┬──────────┬────────┬──────────┬─────────┐
> >   │ File                      │  Size   │ Ver │ Producer                          │  DWARF  │  BTF  │ DW-Hash  │ DW-Out │ BTF-Hash │ BTF-Out │
> >   ├───────────────────────────┼─────────┼─────┼───────────────────────────────────┼─────────┼───────┼──────────┼────────┼──────────┼─────────┤
> >   │ vmlinux.dwarf4            │ 835.7MB │   4 │ GNU C11 16.1.1 -gdwarf-4          │ 599.2MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │
> >   │ vmlinux.dwarf5            │ 736.3MB │   5 │ GNU C11 16.1.1 -gdwarf-5          │ 499.7MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │
> >   │ vmlinux.dwarf5.zlib       │ 497.8MB │   5 │ GNU C11 16.1.1 -gdwarf-5 -gz=zlib │ 261.2MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │
> >   │ vmlinux.dwarf5.zstd       │ 454.7MB │   5 │ GNU C11 16.1.1 -gdwarf-5 -gz=zstd │ 218.1MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │
> >   │ vmlinux.toolchain_default │ 736.3MB │   5 │ GNU C11 16.1.1                    │ 499.7MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │
> >   └───────────────────────────┴─────────┴─────┴───────────────────────────────────┴─────────┴───────┴──────────┴────────┴──────────┴─────────┘
> > 
> > Split DWARF support (skeleton CUs) will be supported in upcoming work,
> > so as to cover all the possibilities the kernel build system offers
> > for generating DWARF.
> > 
> > - Arnaldo
> > 
> > Arnaldo Carvalho de Melo (12):
> >   dwarf_loader: Initial support for DW_TAG_variant_part
> >   dwarf_loader: Initial support for DW_TAG_subprogram in DW_TAG_enumeration
> >   dwarf_loader: Populate DW_TAG_variant children in DW_TAG_variant_part
> >   btf_encoder: Encode variant parts as union members in BTF
> >   dwarf_loader: Handle DW_FORM_block in attr_numeric for Rust discriminant values
> >   dwarf_loader: Allow forcing the merge of CUs for solving inter CU tag references
> >   dwarf_loader: Support DW_TAG_imported_unit for same-file partial units
> >   dwarf_loader: Fix cus__merging_cu failing to detect DW_FORM_ref_addr
> >   dwarf_loader: Add cu parameter to tag__set_spec() and dwarf_tag__set_attr_type()
> >   dwarf_loader: Support DW_FORM_GNU_ref_alt references to dwz alternate debug files
> >   tests: Add inter-CU type reference comparison test
> >   scripts: Add vmlinux_comparison.py for DWARF/BTF analysis
> > 
> >  btf_encoder.c                 |  66 ++-
> >  ctf_encoder.c                 |  34 +-
> >  dwarf_loader.c                | 873 ++++++++++++++++++++++++++++++----
> >  dwarves.c                     |  77 ++-
> >  dwarves.h                     |  63 ++-
> >  dwarves_emit.c                |  10 +-
> >  dwarves_fprintf.c             |  54 ++-
> >  man-pages/pahole.1            |  18 +-
> >  pahole.c                      |  20 +-
> >  scripts/vmlinux_comparison.py | 367 ++++++++++++++
> >  tests/block_endian.sh         | 146 ++++++
> >  tests/dwz_alt_file.sh         | 204 ++++++++
> >  tests/inter_cu_refs.sh        |  50 ++
> >  tests/prettify_perf.data.sh   |   4 +-
> >  14 files changed, 1854 insertions(+), 132 deletions(-)
> >  create mode 100755 scripts/vmlinux_comparison.py
> >  create mode 100755 tests/block_endian.sh
> >  create mode 100755 tests/dwz_alt_file.sh
> >  create mode 100755 tests/inter_cu_refs.sh
> > 
