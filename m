Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22F7270575;
	Mon, 31 Aug 2026 00:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788137300; cv=none; b=Hmu6dwJrrpX7boYmdksMPRWFT976SP9hJ0JP/tEwkZYbiWF4k59u6fr+bMRV26Fa/r/QGS5Ozns2YfIHMF9CZ0S6Y0S+YmmlbwoviGVXiHWWv2oJnrr/lmLslXGClSYq7JJGPdG0YV0YQEwOPXf28d2nbZCSlTKpELwd+Tmx24o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788137300; c=relaxed/simple;
	bh=ZKKkAX1O/9ZntI2bzwHBjkF8AbvmY3tpPde2YkaYm2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGCvKcBViaQ23UlsPtfEAn7ZyRf9vxyfh20NmeQ/JWaYD6rcfDxnbW1M9lB4m3mUB3HnjrXljAJbJEN+fJg7bcqM5thnDk7enahMQTPwI/09Rnlq97KfgWB7jQHXeKvj7kqVwueWj98xXvEs9pGzHLy4SAF0UWCOS8n3p2R0pak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8na6tIL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8na6tIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F811F000E9;
	Mon, 31 Aug 2026 00:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788137298;
	bh=Wg5ZlP2hfOIKL0TYzWJdGj2gxFQg0kHBzOBTxdfTGlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X8na6tIL32TvBj9QrjK58v204pQAZsX6tkgA9tCo1vEunDVQm4cmX2oXNrVnboa2I
	 XjJlJ0qzHHwpXap4ST8refdcB33ZHGG/Z97izXlX9FkHj7hwBpl9WXnJChl2uwtRUB
	 viNSMVC3k5NQdQzRRfsKtgcMR9u7qqipT8j+tSL79G7ge1S+jOh+LnDFzWTbCs/MxS
	 csRVXhoAoLl9qoHbem246RVJpMX415OVw5q2QO5vVmpdi10/683JjtfQvgXbyiFqkk
	 jgqSC7NiolGBpP5Es3vaIcohaKoxz6f4OFtSkYdp9Uy9/00nP2hddJQWEuljQPGHHz
	 8Ubh02VfEV6Zw==
Date: Sun, 30 Aug 2026 21:48:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
	bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: RFT: coverage analysis and lots more regression tests in the
 'next' branch. Was: Re: [PATCH v2 0/9] pahole: Support cross-CU type
 references and dwz alternate debug files
Message-ID: <apTPTyp31CUiX9Lf@x2>
References: <20260821213510.22423-1-acme@kernel.org>
 <ao442rldWrCNG3zC@x2>
 <d85a69a5-b08a-4ec8-b09c-4e45b7c1f712@oracle.com>
 <ao7lqxytDiHmVmkk@x2>
 <0e1c3820-c16b-4266-bde4-655b760b3db4@oracle.com>
 <apISzIQ-gjPB8Xqw@x2>
 <apM_W9ld8Bj3q5Vk@x2>
 <5e3b9e48-00f5-43d1-a383-2b1c59342e87@oracle.com>
 <apTIZoZoxj_gGx_e@x2>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apTIZoZoxj_gGx_e@x2>

On Sun, Aug 30, 2026 at 09:18:50PM -0300, Arnaldo Carvalho de Melo wrote:
> On Sun, Aug 30, 2026 at 06:08:49PM +0100, Alan Maguire wrote:
> > On 29/08/2026 21:21, Arnaldo Carvalho de Melo wrote:
> > > Got all of the coverage analysis and new regression tests on the next
> > > branch, and run the 'build-and-test.sh' script on my set of containers,
> > > where all the test ran on:
>  
> > This looks fantastic! I ran it thru CI: 
> 
> Yeah, lots of tests, some simple, some more involved, and several
> scripts to help in development, like the one for test build after a
> range of patches :-)
>  
> > https://github.com/alan-maguire/dwarves/actions/runs/33255515875
>  
> > Let's get the coverage report enabled as part of CI too..
> 
> Right, taking a look at it before after patches seems like a good way to
> notice the need for further tests to cover new code or further test
> existing one.

And BTW, here is an example of the output of coverage analysis, after
installing the the llvm-profdata package (on Fedora), starting from the
most compact part, that is the coverage table, and after it what is
needed first to then generate the table:

⬢ [acme@toolbx pahole]$ make -C build coverage-table
make: Entering directory '/home/acme/git/pahole/build'
[100%] Display ASCII coverage table from existing profdata
┌──────────────────────┬───────┬──────┬──────┬─────────────────────────────┬─────────┬─────────┐
│ File                 │ Lines │  Hit │ Miss │        Line Coverage        │   Funcs │ FuncCov │
├──────────────────────┼───────┼──────┼──────┼─────────────────────────────┼─────────┼─────────┤
│ prefcnt.c            │    99 │   89 │   10 │ █████████████████░░░  89.9% │  11/11  │ 100.00% │
│ btf_loader.c         │   553 │  470 │   83 │ ████████████████░░░░  85.0% │  36/37  │  97.30% │
│ pfunct.c             │   474 │  391 │   83 │ ████████████████░░░░  82.5% │  28/29  │  96.55% │
│ pglobal.c            │   193 │  159 │   34 │ ████████████████░░░░  82.4% │  17/18  │  94.44% │
│ pdwtags.c            │   101 │   83 │   18 │ ████████████████░░░░  82.2% │   5/5   │ 100.00% │
│ codiff.c             │   580 │  472 │  108 │ ████████████████░░░░  81.4% │  20/20  │ 100.00% │
│ dtagnames.c          │    30 │   24 │    6 │ ████████████████░░░░  80.0% │   4/4   │ 100.00% │
│ dutil.c              │   210 │  152 │   58 │ ██████████████░░░░░░  72.4% │  13/15  │  86.67% │
│ dwarves_fprintf.c    │  1598 │ 1154 │  444 │ ██████████████░░░░░░  72.2% │  40/47  │  85.11% │
│ dwarves_emit.c       │   326 │  231 │   95 │ ██████████████░░░░░░  70.9% │  15/18  │  83.33% │
│ gobuffer.c           │    40 │   27 │   13 │ █████████████░░░░░░░  67.5% │   3/5   │  60.00% │
│ dwarf_loader.c       │  3376 │ 2214 │ 1162 │ █████████████░░░░░░░  65.6% │ 146/178 │  82.02% │
│ btf_encoder.c        │  2188 │ 1401 │  787 │ ████████████░░░░░░░░  64.0% │  72/83  │  86.75% │
│ dwarves.c            │  1872 │ 1118 │  754 │ ███████████░░░░░░░░░  59.7% │ 118/161 │  73.29% │
│ dwarves_reorganize.c │   275 │  162 │  113 │ ███████████░░░░░░░░░  58.9% │   6/8   │  75.00% │
│ pahole.c             │  2132 │ 1083 │ 1049 │ ██████████░░░░░░░░░░  50.8% │  60/90  │  66.67% │
│ elf_symtab.c         │    55 │   27 │   28 │ █████████░░░░░░░░░░░  49.1% │   2/2   │ 100.00% │
│ rbtree.c             │   286 │  137 │  149 │ █████████░░░░░░░░░░░  47.9% │   7/10  │  70.00% │
│ libctf.c             │   353 │   28 │  325 │ █░░░░░░░░░░░░░░░░░░░   7.9% │   1/29  │   3.45% │
│ ctf_loader.c         │   502 │    5 │  497 │ ░░░░░░░░░░░░░░░░░░░░   1.0% │   1/29  │   3.45% │
│ ctracer.c            │   521 │    0 │  521 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │   0/31  │   0.00% │
│ elfcreator.c         │   201 │    0 │  201 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │   0/12  │   0.00% │
│ scncopy.c            │    12 │    0 │   12 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │   0/1   │   0.00% │
│ syscse.c             │    83 │    0 │   83 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │   0/6   │   0.00% │
├──────────────────────┼───────┼──────┼──────┼─────────────────────────────┼─────────┼─────────┤
│ TOTAL                │ 16060 │ 9427 │ 6633 │ ███████████░░░░░░░░░  58.7% │ 605/849 │   71.3% │
└──────────────────────┴───────┴──────┴──────┴─────────────────────────────┴─────────┴─────────┘
[100%] Built target coverage-table
make: Leaving directory '/home/acme/git/pahole/build'
⬢ [acme@toolbx pahole]$

⬢ [acme@toolbx pahole]$ make -C build list-targets
make: Entering directory '/home/acme/git/pahole/build'

pahole build targets:
  make                  - Build all binaries and libraries
  make install          - Install to CMAKE_INSTALL_PREFIX

Testing:
  make check            - Run the test suite

Coverage:
  make coverage         - Full coverage: rebuild, run tests, report diff
  make coverage-report  - Regenerate report from existing profdata
  make coverage-table   - Display ASCII coverage table

  Coverage uses build-coverage/ as the instrumented build directory.
  Set BUILD_DIR to override.

Tarball generation:
  make tarxz-pkg        - Create .tar.xz release tarball
  make targz-pkg        - Create .tar.gz release tarball
  make tarbz2-pkg       - Create .tar.bz2 release tarball
  make tar-pkg          - Create .tar release tarball

  Tarballs created in current directory by default. Set TARBALL_DIR to override.
  See README.tarball for details.

Built target list-targets
make: Leaving directory '/home/acme/git/pahole/build'
⬢ [acme@toolbx pahole]$ make -C build coverage
make: Entering directory '/home/acme/git/pahole/build'
[100%] Full coverage: rebuild with instrumentation, run tests, report
=== Step 1: Rebuilding with coverage instrumentation ===
[100%] Built target pahole

=== Step 2: Running tests with coverage ===
 73: Typedef chain display.                                             : Ok
Saved timing data to .test-times (73 tests)


=== Merging 1025 profile files ===

=== Step 3: Generating coverage report ===

File                        Previous   Current      Delta
--------------------------  --------  --------  ---------
btf_encoder.c                  0.00%    64.03%    +64.03%
btf_loader.c                   0.00%    84.99%    +84.99%
codiff.c                       0.00%    81.38%    +81.38%
ctf_loader.c                   0.00%     1.00%     +1.00%
ctracer.c                      0.00%     0.00%     +0.00%
dtagnames.c                    0.00%    80.00%    +80.00%
dutil.c                        0.00%    72.38%    +72.38%
dutil.h                        0.00%    10.00%    +10.00%
dwarf_loader.c                 0.00%    65.58%    +65.58%
dwarves.c                      0.21%    59.72%    +59.51%
dwarves.h                      0.00%    81.54%    +81.54%
dwarves_emit.c                 0.00%    70.86%    +70.86%
dwarves_fprintf.c              0.00%    72.22%    +72.22%
dwarves_reorganize.c           0.00%    58.91%    +58.91%
elf_symtab.c                   0.00%    49.09%    +49.09%
elf_symtab.h                   0.00%    55.81%    +55.81%
elfcreator.c                   0.00%     0.00%     +0.00%
gobuffer.c                     0.00%    67.50%    +67.50%
gobuffer.h                     0.00%    33.33%    +33.33%
hash.h                         0.00%   100.00%   +100.00%
libctf.c                       0.00%     7.93%     +7.93%
list.h                         0.00%    32.58%    +32.58%
pahole.c                       1.45%    50.80%    +49.35%
pdwtags.c                      0.00%    82.18%    +82.18%
pfunct.c                       0.00%    82.49%    +82.49%
pglobal.c                      0.00%    82.38%    +82.38%
prefcnt.c                      0.00%    89.90%    +89.90%
rbtree.c                       0.00%    47.90%    +47.90%
rbtree.h                       0.00%    66.67%    +66.67%
scncopy.c                      0.00%     0.00%     +0.00%
syscse.c                       0.00%     0.00%     +0.00%

=== All .c files by coverage (ascending) ===

  File                         Lines %  Missed
  --------------------------  --------  ------
  ctracer.c                      0.00%     521
  elfcreator.c                   0.00%     201
  scncopy.c                      0.00%      12
  syscse.c                       0.00%      83
  ctf_loader.c                   1.00%     497
  libctf.c                       7.93%     325
  rbtree.c                      47.90%     149
  elf_symtab.c                  49.09%      28
  pahole.c                      50.80%    1049
  dwarves_reorganize.c          58.91%     113
  dwarves.c                     59.72%     754
  btf_encoder.c                 64.03%     787
  dwarf_loader.c                65.58%    1162
  gobuffer.c                    67.50%      13
  dwarves_emit.c                70.86%      95
  dwarves_fprintf.c             72.22%     444
  dutil.c                       72.38%      58
  dtagnames.c                   80.00%       6
  codiff.c                      81.38%     108
  pdwtags.c                     82.18%      18
  pglobal.c                     82.38%      34
  pfunct.c                      82.49%      83
  btf_loader.c                  84.99%      83
  prefcnt.c                     89.90%      10

Baseline updated: /home/acme/git/pahole/coverage-report.txt
Previous baseline saved: /home/acme/git/pahole/coverage-report.txt.prev

=== Generating HTML report ===
HTML report: /home/acme/git/pahole/build-coverage/coverage/html/index.html
Done.
[100%] Built target coverage
make: Leaving directory '/home/acme/git/pahole/build'
⬢ [acme@toolbx pahole]$
