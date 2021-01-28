Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06AAC433E0
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Jan 2021 12:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B51164DCC
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Jan 2021 12:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhA1MMI (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 28 Jan 2021 07:12:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhA1MMH (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 28 Jan 2021 07:12:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FFA064DDD;
        Thu, 28 Jan 2021 12:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611835886;
        bh=xM5cLiayNryHstVPBnLIE8vTsekX8sgaOfafKEWyEJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sg5G3hqWo9K2ecHdM3/OcSeDheIsVA2hweKPv+ObAntbpYthe/CcQY9UhPLZR7A+R
         gJxsZqa0qG+HTB8Jul9ox9Sc/dtbFh2vj8qlgdscSAEiR1wIGTuEyLb0pJBVcCjoKx
         7dH26s2+qxwXAGYPkdBsBni8l0wpaVbfW0fzdNBjckutRjiHnXtxfDx5wzHbj/QozY
         VS8B3SWuMgUoNopKjF+lbe2U++906O8Qf1MoWBr/glCuZwwI2fJ6mZxGNvedL4ECKQ
         w9UfpEvNbAUh+UGb25YRLzRvXnGSLZef7EHOMpRIOFxFOcmyFAjnN1pQ6tW7bbvTx5
         VpitcxMN13VdA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E3FFF40513; Thu, 28 Jan 2021 09:11:22 -0300 (-03)
Date:   Thu, 28 Jan 2021 09:11:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mark Wielaard <mark@klomp.org>
Cc:     Daniel =?iso-8859-1?Q?Berrang=E9?= <berrange@redhat.com>,
        dwarves@vger.kernel.org
Subject: [PATCH/RFC] Re: DWARF5 DW_AT_data_bit_offset
Message-ID: <20210128121122.GA775562@kernel.org>
References: <5ee85ca6e3b06b07c83b150912fbcfc1a4c13e19.camel@klomp.org>
 <20201002211819.GA127275@kernel.org>
 <20210121113516.GA8492@wildebeest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121113516.GA8492@wildebeest.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Jan 21, 2021 at 12:35:16PM +0100, Mark Wielaard escreveu:
> On Fri, Oct 02, 2020 at 06:18:19PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Oct 02, 2020 at 06:11:06PM +0200, Mark Wielaard escreveu:
> > > Seems pahole with a recent version of elfutils libdw already handles
> > > most DWARF5 encodings. One thing it doesn't handle yet is
> > > DW_AT_data_bit_offset (this is actually a DWARF4 thing, but gcc only
> > > emits it for -gdwarf-5).

<SNIP>

> > > $ gcc -gdwarf-5 -c bf.c
> > > $ ./pahole ./bf.o 
> > > DW_AT_<0xd>=0x21
> > > DW_AT_<0xd>=0x21
> > > DW_AT_<0xd>=0x21
> > > struct pea {
> > > 	int                        type;                 /*     0     4 */
> > > 	static long int                   a;             /*     0     0 */
> > > 	static long int                   b;             /*     0     0 */
> > > 	static long int                   c;             /*     0     0 */
> > > 
> > > 	/* size: 8, cachelines: 1, members: 1, static members: 3 */
> > > 	/* padding: 4 */
> > > 	/* last cacheline: 8 bytes */
> > > };

> > > Note that GCC11 might default to DWARF5.

> > Thanks for the detailed report, I'm releasing v1.18 right now, will look
> > into that for v1.19.

> Note that GCC11 indeed just switched to producing DWARF5 by default.
> It is not released yet, but already in stage4 and Fedora will start
> doing a mass-rebuild with it soon to shake out the last remaining bugs.

So, 1.20 will have the fix below, please check if what is in:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=DW_AT_data_bit_offset

Fixes it for you, the cset with all the tests performed is this one:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=DW_AT_data_bit_offset&id=a77f039bb49bc97badf938049245f013fe3de4aa

Now looking at https://bugzilla.redhat.com/show_bug.cgi?id=1919965 ...

For convenience:

commit a77f039bb49bc97badf938049245f013fe3de4aa
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu Jan 28 08:51:31 2021 -0300

    dwarf_loader: Support DW_AT_data_bit_offset
    
    This appeared in DWARF4 but is supported only in gcc's -gdwarf-5,
    support it in a way that makes the output be the same for both cases:
    
      $ gcc -gdwarf-4 -c examples/dwarf5/bf.c
      $ pahole bf.o
      struct pea {
            long int                   a:1;                  /*     0: 0  8 */
            long int                   b:1;                  /*     0: 1  8 */
            long int                   c:1;                  /*     0: 2  8 */
    
            /* XXX 29 bits hole, try to pack */
            /* Bitfield combined with next fields */
    
            int                        after_bitfield;       /*     4     4 */
    
            /* size: 8, cachelines: 1, members: 4 */
            /* sum members: 4 */
            /* sum bitfield members: 3 bits, bit holes: 1, sum bit holes: 29 bits */
            /* last cacheline: 8 bytes */
      };
      $ gcc -gdwarf-5 -c examples/dwarf5/bf.c
      $ pahole bf.o
      struct pea {
            long int                   a:1;                  /*     0: 0  8 */
            long int                   b:1;                  /*     0: 1  8 */
            long int                   c:1;                  /*     0: 2  8 */
    
            /* XXX 29 bits hole, try to pack */
            /* Bitfield combined with next fields */
    
            int                        after_bitfield;       /*     4     4 */
    
            /* size: 8, cachelines: 1, members: 4 */
            /* sum members: 4 */
            /* sum bitfield members: 3 bits, bit holes: 1, sum bit holes: 29 bits */
            /* last cacheline: 8 bytes */
      };
      $
    
    Now with an integer before the bitfield:
    
      $ cat examples/dwarf5/bf.c
      struct pea {
            int before_bitfield;
            long a:1, b:1, c:1;
            int after_bitfield;
      } p;
      $ gcc -gdwarf-4 -c examples/dwarf5/bf.c
      $ pahole bf.o
      struct pea {
            int                        before_bitfield;      /*     0     4 */
    
            /* Bitfield combined with previous fields */
    
            long int                   a:1;                  /*     0:32  8 */
            long int                   b:1;                  /*     0:33  8 */
            long int                   c:1;                  /*     0:34  8 */
    
            /* XXX 29 bits hole, try to pack */
    
            int                        after_bitfield;       /*     8     4 */
    
            /* size: 16, cachelines: 1, members: 5 */
            /* sum members: 8 */
            /* sum bitfield members: 3 bits, bit holes: 1, sum bit holes: 29 bits */
            /* padding: 4 */
            /* last cacheline: 16 bytes */
      };
      $ gcc -gdwarf-5 -c examples/dwarf5/bf.c
      $ pahole bf.o
      struct pea {
            int                        before_bitfield;      /*     0     4 */
    
            /* Bitfield combined with previous fields */
    
            long int                   a:1;                  /*     0:32  8 */
            long int                   b:1;                  /*     0:33  8 */
            long int                   c:1;                  /*     0:34  8 */
    
            /* XXX 29 bits hole, try to pack */
    
            int                        after_bitfield;       /*     8     4 */
    
            /* size: 16, cachelines: 1, members: 5 */
            /* sum members: 8 */
            /* sum bitfield members: 3 bits, bit holes: 1, sum bit holes: 29 bits */
            /* padding: 4 */
            /* last cacheline: 16 bytes */
      };
      $
    
    And an array of long integers at the start, before the combination of an
    integer with a long integer bitfield:
    
      $ cat examples/dwarf5/bf.c
      struct pea {
            long array[3];
            int before_bitfield;
            long a:1, b:1, c:1;
            int after_bitfield;
      } p;
      $ gcc -gdwarf-4 -c examples/dwarf5/bf.c
      $ pahole bf.o
      struct pea {
            long int                   array[3];             /*     0    24 */
            int                        before_bitfield;      /*    24     4 */
    
            /* Bitfield combined with previous fields */
    
            long int                   a:1;                  /*    24:32  8 */
            long int                   b:1;                  /*    24:33  8 */
            long int                   c:1;                  /*    24:34  8 */
    
            /* XXX 29 bits hole, try to pack */
    
            int                        after_bitfield;       /*    32     4 */
    
            /* size: 40, cachelines: 1, members: 6 */
            /* sum members: 32 */
            /* sum bitfield members: 3 bits, bit holes: 1, sum bit holes: 29 bits */
            /* padding: 4 */
            /* last cacheline: 40 bytes */
      };
      $ gcc -gdwarf-5 -c examples/dwarf5/bf.c
      $ pahole bf.o
      struct pea {
            long int                   array[3];             /*     0    24 */
            int                        before_bitfield;      /*    24     4 */
    
            /* Bitfield combined with previous fields */
    
            long int                   a:1;                  /*    24:32  8 */
            long int                   b:1;                  /*    24:33  8 */
            long int                   c:1;                  /*    24:34  8 */
    
            /* XXX 29 bits hole, try to pack */
    
            int                        after_bitfield;       /*    32     4 */
    
            /* size: 40, cachelines: 1, members: 6 */
            /* sum members: 32 */
            /* sum bitfield members: 3 bits, bit holes: 1, sum bit holes: 29 bits */
            /* padding: 4 */
            /* last cacheline: 40 bytes */
      };
      $
    
    Reported-by: Mark Wielaard <mark@klomp.org>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 8d27e4fc236b9575..ac22c1b0883ddee6 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -776,27 +776,36 @@ static struct class_member *class_member__new(Dwarf_Die *die, struct cu *cu,
 
 		Dwarf_Attribute attr;
 
-		if (dwarf_attr(die, DW_AT_data_member_location, &attr) != NULL) {
-			member->byte_offset = __attr_offset(&attr);
+		member->has_bit_offset = dwarf_attr(die, DW_AT_data_bit_offset, &attr) != NULL;
+
+		if (member->has_bit_offset) {
+			member->bit_offset = __attr_offset(&attr);
+			// byte_offset and bitfield_offset will be recalculated later, when
+			// we discover the size of this bitfield base type.
 		} else {
-			member->is_static = !in_union;
+			if (dwarf_attr(die, DW_AT_data_member_location, &attr) != NULL) {
+				member->byte_offset = __attr_offset(&attr);
+			} else {
+				member->is_static = !in_union;
+			}
+
+			/*
+			 * Bit offset calculated here is valid only for byte-aligned
+			 * fields. For bitfields on little-endian archs we need to
+			 * adjust them taking into account byte size of the field,
+			 * which might not be yet known. So we'll re-calculate bit
+			 * offset later, in class_member__cache_byte_size.
+			 */
+			member->bit_offset = member->byte_offset * 8;
+			member->bitfield_offset = attr_numeric(die, DW_AT_bit_offset);
 		}
 
-		/*
-		 * Bit offset calculated here is valid only for byte-aligned
-		 * fields. For bitfields on little-endian archs we need to
-		 * adjust them taking into account byte size of the field,
-		 * which might not be yet known. So we'll re-calculate bit
-		 * offset later, in class_member__cache_byte_size.
-		 */
-		member->bit_offset = member->byte_offset * 8;
 		/*
 		 * If DW_AT_byte_size is not present, byte size will be
 		 * determined later in class_member__cache_byte_size using
 		 * base integer/enum type
 		 */
 		member->byte_size = attr_numeric(die, DW_AT_byte_size);
-		member->bitfield_offset = attr_numeric(die, DW_AT_bit_offset);
 		member->bitfield_size = attr_numeric(die, DW_AT_bit_size);
 		member->bit_hole = 0;
 		member->bitfield_end = 0;
@@ -2275,24 +2284,31 @@ static int class_member__cache_byte_size(struct tag *tag, struct cu *cu,
 		return 0;
 	}
 
-	/*
-	 * For little-endian architectures, DWARF data emitted by gcc/clang
-	 * specifies bitfield offset as an offset from the highest-order bit
-	 * of an underlying integral type (e.g., int) to a highest-order bit
-	 * of a bitfield. E.g., for bitfield taking first 5 bits of int-backed
-	 * bitfield, bit offset will be 27 (sizeof(int) - 0 offset - 5 bit
-	 * size), which is very counter-intuitive and isn't a natural
-	 * extension of byte offset, which on little-endian points to
-	 * lowest-order byte. So here we re-adjust bitfield offset to be an
-	 * offset from lowest-order bit of underlying integral type to
-	 * a lowest-order bit of a bitfield. This makes bitfield offset
-	 * a natural extension of byte offset for bitfields and is uniform
-	 * with how big-endian bit offsets work.
-	 */
-	if (cu->little_endian) {
-		member->bitfield_offset = member->bit_size - member->bitfield_offset - member->bitfield_size;
+	if (!member->has_bit_offset) {
+		/*
+		 * For little-endian architectures, DWARF data emitted by gcc/clang
+		 * specifies bitfield offset as an offset from the highest-order bit
+		 * of an underlying integral type (e.g., int) to a highest-order bit
+		 * of a bitfield. E.g., for bitfield taking first 5 bits of int-backed
+		 * bitfield, bit offset will be 27 (sizeof(int) - 0 offset - 5 bit
+		 * size), which is very counter-intuitive and isn't a natural
+		 * extension of byte offset, which on little-endian points to
+		 * lowest-order byte. So here we re-adjust bitfield offset to be an
+		 * offset from lowest-order bit of underlying integral type to
+		 * a lowest-order bit of a bitfield. This makes bitfield offset
+		 * a natural extension of byte offset for bitfields and is uniform
+		 * with how big-endian bit offsets work.
+		 */
+		if (cu->little_endian)
+			member->bitfield_offset = member->bit_size - member->bitfield_offset - member->bitfield_size;
+
+		member->bit_offset = member->byte_offset * 8 + member->bitfield_offset;
+	} else {
+		// DWARF5 has DW_AT_data_bit_offset, offset in bits from the
+		// start of the container type (struct, class, etc).
+		member->byte_offset = member->bit_offset / 8;
+		member->bitfield_offset = member->bit_offset - member->byte_offset * 8;
 	}
-	member->bit_offset = member->byte_offset * 8 + member->bitfield_offset;
 
 	/* make sure bitfield offset is non-negative */
 	if (member->bitfield_offset < 0) {
diff --git a/dwarves.h b/dwarves.h
index 24405b79ac71e686..98caf1abc54d58fa 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -899,6 +899,7 @@ static inline int function__inlined(const struct function *func)
  * @accessibility - DW_ACCESS_{public,protected,private}
  * @virtuality - DW_VIRTUALITY_{none,virtual,pure_virtual}
  * @hole - If there is a hole before the next one (or the end of the struct)
+ * @has_bit_offset: Don't recalcule this, it came from the debug info (DWARF5's DW_AT_data_bit_offset)
  */
 struct class_member {
 	struct tag	 tag;
@@ -915,6 +916,7 @@ struct class_member {
 	uint32_t	 alignment;
 	uint8_t		 visited:1;
 	uint8_t		 is_static:1;
+	uint8_t		 has_bit_offset:1;
 	uint8_t		 accessibility:2;
 	uint8_t		 virtuality:2;
 	uint16_t	 hole;
