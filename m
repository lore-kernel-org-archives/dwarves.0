Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6E31DEFE0
	for <dwarves@vger.kernel.org>; Sun, 30 Nov 2025 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764475435; cv=none; b=G5aSXH3pg1xngTyCO91+aRuW8y4tSBwGyWsWLXWOqm0COBHqGKyfG5emlHu6b6ZHAHthYJpsTH+E/XjKSALn3wFebBDAHuj/R4oYU5MrlMznxSZWZ9Ymy6oyzth7jiReqTuL6/+MzxkaZCwhHi6gFx1Rtvyf8vUKIphdHOMtz2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764475435; c=relaxed/simple;
	bh=Pi+uRRXTqjdCTHs0keobIT+ISn7uebdl8n3ibZHys/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bitadLvMpx92c1KNlvIT6R8PAKFHy5EI6+5RsLWz791TFwW2eG/tCC50EOP0+viH6WKj3qLPGOAgiYZb6JuLM5IUGZTuSxNQa5q2zIWuuIIw6S+/PB69OmhqnhiEItwhrbXOv70eKfvLFrfXapXr3JCOlB5psaTeoa+yBvHA8EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 3C24115D63B5B; Sat, 29 Nov 2025 20:03:40 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	David Faust <david.faust@oracle.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com
Subject: [PATCH dwarves v2 0/2] pahole: Replace or add functions with true signatures in btf
Date: Sat, 29 Nov 2025 20:03:40 -0800
Message-ID: <20251130040340.2636458-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Current vmlinux BTF encoding is based on the source level signatures.
But the compiler may do some optimization and changed the signature.
If the user tried with source level signature, their initial implementati=
on
may have wrong results and then the user need to check what is the
problem and work around it, e.g. through kprobe since kprobe does not
need vmlinux BTF.

The following is a concrete example for [1].
The original source signature:
  typedef struct {
        union {
                void            *kernel;
                void __user     *user;
        };
        bool            is_kernel : 1;
  } sockptr_t;
  typedef sockptr_t bpfptr_t;
  static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
After compiler optimization, the signature becomes:
  static int map_create(union bpf_attr *attr, bool is_kernel) { ... }

To do proper tracing, it would be good for the users to know the
changed signature. With the actual signature, both kprobe and fentry
should work as usual. This can avoid user surprise and improve
developer productivity.

The llvm compiler patch [1] collects true signature and encoded those
functions in dwarf. pahole will process these functions and
replace old signtures with true signatures. Additionally,
new functions (e.g., foo.llvm.<hash>) can be encoded in
vmlinux BTF as well.

Patches 1 is a refactor change. Patch 2 has the detailed explanation
in commit message and implements the logic to encode replaced or new
signatures to vmlinux BTF. Please see Patch 2 for details.

  [1] https://github.com/llvm/llvm-project/pull/165310

Changelogs:
  v1 -> v2:
   - v1: https://lore.kernel.org/bpf/20251111170424.286892-1-yonghong.son=
g@linux.dev/
   - For functions like <foo>.llvm.<hash>() where the function <foo> is p=
romoted
     to <foo>.llvm.<hash>(). Previous llvm ([1]) allows to have new-signa=
ture dwarf
     entries for both <foo> and <foo>.llvm.<hash> and pahole will generat=
e two
     new functions. Now, llvm will only generate one entry with name <foo=
>.llvm.<hash>
     so pahole will generate one entry for <foo>.llvm.<hash>.
   - Since v2 approach intends to generate functions with name in kallsym=
s,
     removing function suffix is avoided.

Yonghong Song (2):
  btf_encoder: Refactor elf_functions__new() with struct btf_encoder as
    argument
  pahole: Replace or add functions with true signatures in btf

 btf_encoder.c  | 52 +++++++++++++++++++++++++-------
 dwarf_loader.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++
 dwarves.h      |  4 +++
 pahole.c       |  9 ++++++
 4 files changed, 136 insertions(+), 10 deletions(-)

--=20
2.47.3

