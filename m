Received: from gnu.wildebeest.org (gnu.wildebeest.org [45.83.234.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5452C1B7
	for <dwarves@vger.kernel.org>; Sun, 14 Jan 2024 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klomp.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klomp.org
Received: by gnu.wildebeest.org (Postfix, from userid 1000)
	id 10D24302BBEA; Sun, 14 Jan 2024 23:29:30 +0100 (CET)
Date: Sun, 14 Jan 2024 23:29:30 +0100
From: Mark Wielaard <mark@klomp.org>
To: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc: dwarves@vger.kernel.org, elfutils-devel@sourceware.org, acme@kernel.org
Subject: Re: Porting pahole from dwarf_next_unit() to dwarf_get_units()
Message-ID: <20240114222930.GC14151@gnu.wildebeest.org>
References: <CADWks+b06hpoBJpVdtd4HXdC0w24hObq0WOGCdfMGkpC7k=2vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADWks+b06hpoBJpVdtd4HXdC0w24hObq0WOGCdfMGkpC7k=2vQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Dimitri,

Sorry, this arrived before my vacation and then the new year happened.

On Tue, Dec 05, 2023 at 01:03:01PM +0000, Dimitri John Ledkov wrote:
> Currently pahole warns and does nothing upon hitting
> DW_TAG_skeleton_unit as implemented at
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=0135ccd632796ab3aff65b7c99b374c4682c2bcf
> 
> In elfutils, a while back a new API got added that aids with discovery
> and processing of such tags -
> https://sourceware.org/git/?p=elfutils.git;a=commitdiff;h=79f0e623dcde4b042bb72f636a2211d67d5c0ade
> 
> It seems to me if pahole is ported from using dwarf_next_unit() to
> instead use dwarf_get_units() native support can be added for
> split-dwarf (dwo) files.
> 
> I am trying to write such a port, but it is proving to be very
> difficult. I am entirely unfamiliar with neither pahole nor libdw nor
> the dwarf file format. Thus it is very confusing when both pahole and
> dwarf library use very similar type names and structs. For example
> libdw has struct Dwarf_CU and pahole has unrelated dwarf_cu struct.
> 
> What are the differences between dwarf_nextcu(), dwarf_next_unit(),
> dwarf_get_units() and when should one use each one of them? (or nest
> them?)

The dwarf_nextcu was the original way to iterate over the CUs from
.debug_info. Then dwarf_next_unit was added when type units could come
from a .debug_types section. Both functions use and return offsets to
iterate through the section and then get the CU DIE using dwarf_offdie
(or dwarf_offdie_types). This requires the user to know beforehand
where to DIE data is stored (in the .debug_info or .debug_types
section).  For type units one also needs to use the type offset to
create the actual type DIE. In DWARF5 DIEs can come from even more
data locations. And there are also skeleton units which require the
user to find the associated split compile unit DIE (which would come
from a different file).
    
The new dwarf_get_units function simplifies iterating over the units
in a DWARF file. It doesn't require the user to know where the DIE
data is stored, it will automagically iterate over all know data
sources (sections) returning the Dwarf_CU and the associated Dwarf_Die
if requested. If the user requests to know the associated "subdie" it
will also be resolved.
    
A subdie is either a type DIE for a type unit or a split unit DIE for
a skeleton unit. The same (and some more) info about DWARF_CUs can
also be gotten through the dwarf_cu_info function.

You should either use dwarf_nextcu or dwarf_next_unit with
dwarf_offdie to get the (top-level) DIE. Or use dwarf_get_units and
possibly dwarf_cu_info. In general you shouldn't mix them.

Hope this helps and let me know if you need more info.

Cheers,

Mark
