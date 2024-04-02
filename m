Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808B015B962;
	Tue,  2 Apr 2024 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086800; cv=none; b=BygbBwbnx+KkIoysa4d5II3Shht0+OrZys8kHo7t+h63SCdMqO66hOnb0qyVwGZXYR9CwSTwoMrV8z5l7ye6XcEydbnYrH0Cyy6N0YZLPcqec14Y7S4iIimmosl+jArVeHSzQnWXDvqw/wEo4y39ZihM9a+7AnOaKl5a77xsYqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086800; c=relaxed/simple;
	bh=yaRjQzEABL8hzuUckBbpGPbH5cBdTm25T5g2Axc+dyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gyqg0dYr/Pldgjvu+tIp6dt28NM6mNDkrrVJ9XJ420G/1wLU6eC34Gc6zX7KVXl8vXDRZqsNywlrYJeojhPe8kipwq1O2Wvy4bZq7xN0FPTa4SCwx+PPfXNcmttXna/2ugS1MPe9+mJNztcVasvPFgVCWRv+gEfLd3F29kFPHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iriRV2RE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iriRV2RE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED003C43399;
	Tue,  2 Apr 2024 19:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086800;
	bh=yaRjQzEABL8hzuUckBbpGPbH5cBdTm25T5g2Axc+dyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iriRV2REB+Ewiu6YsLc/ph0ktZQEc0XCXCqjYZrplsC4UyPFOlZqYbo1RDyYNcgPC
	 DiWPk/aBrPN5Cqns+XGCh+YL2g202pLIUE3diHyylME1kUAkXeCf8D/0Epd01G0AlI
	 /NREQWnSLZb6Qh+z5pFk/LEFy5ShM3BpP9lKkt4psoVyWvjhSXUQibSDRACdbRfzEK
	 uMN9EZ42ifu64ggyvP3gGs3czzJUqQk0hh8+EToaafX31ttdMSkyeUoMREEHHJ8jfX
	 Y65AiswvnVNKV3LxtR/YAVwkbN9EDn9+qzy1VVM+QmUY5CvLK/DQbzg5QW8QWnk4ft
	 s2qr4BisMH+lg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Kui-Feng Lee <kuifeng@fb.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 02/12] pahole: Disable BTF multithreaded encoded when doing reproducible builds
Date: Tue,  2 Apr 2024 16:39:35 -0300
Message-ID: <20240402193945.17327-3-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402193945.17327-1-acme@kernel.org>
References: <20240402193945.17327-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Reproducible builds need to produce BTF that have the same ids, which is
not possible at the moment to do in parallel with libbpf, so serialize
the encoding.

The next patches will also make sure that DWARF while being read in
parallel into internal representation for later BTF encoding has its CU
(Compile Units) fed to the BTF encoder in the same order as it is in the
DWARF file, this way we'll produce the same BTF output no matter how
many threads are used to read BTF.

Then we'll make sure we have tests in place that compare the output of
parallel BTF encoding (well, just the DWARF loading part, maybe the BTF
in the future), i.e. when using 'pahole -j' with the one obtained when
doing single threaded encoding.

Testing it on a:

  # grep -m1 "model name" /proc/cpuinfo
  model name	: 13th Gen Intel(R) Core(TM) i7-1365U
  ~#

I.e. 2 performance cores (4 threads) + 8 efficiency cores.

From:

  $ perf stat -r5 pahole -j --btf_encode_detached=vmlinux.btf.parallel vmlinux

   Performance counter stats for 'pahole -j --btf_encode_detached=vmlinux.btf.parallel vmlinux' (5 runs):

         17,187.27 msec task-clock:u       #    6.153 CPUs utilized   ( +-  0.34% )
  <SNIP>
            2.7931 +- 0.0336 seconds time elapsed  ( +-  1.20% )

  $

To:

  $ perf stat -r5 pahole -j --reproducible_build --btf_encode_detached=vmlinux.btf.parallel.reproducible_build vmlinux

   Performance counter stats for 'pahole -j --reproducible_build --btf_encode_detached=vmlinux.btf.parallel.reproducible_build vmlinux' (5 runs):

         14,654.06 msec task-clock:u       #    3.507 CPUs utilized   ( +-  0.45% )
  <SNIP>
            4.1787 +- 0.0344 seconds time elapsed  ( +-  0.82% )

  $

Which is still a nice improvement over doing it completely serially:

  $ perf stat -r5 pahole --btf_encode_detached=vmlinux.btf.serial vmlinux

   Performance counter stats for 'pahole --btf_encode_detached=vmlinux.btf.serial vmlinux' (5 runs):

          7,506.93 msec task-clock:u       #    1.000 CPUs utilized   ( +-  0.13% )
  <SNIP>
            7.5106 +- 0.0115 seconds time elapsed  ( +-  0.15% )

  $

  $ pahole vmlinux.btf.parallel > /tmp/parallel
  $ pahole vmlinux.btf.parallel.reproducible_build > /tmp/parallel.reproducible_build
  $ diff -u /tmp/parallel /tmp/parallel.reproducible_build | wc -l
  269920
  $ pahole --sort vmlinux.btf.parallel > /tmp/parallel.sorted
  $ pahole --sort vmlinux.btf.parallel.reproducible_build > /tmp/parallel.reproducible_build.sorted
  $ diff -u /tmp/parallel.sorted /tmp/parallel.reproducible_build.sorted | wc -l
  0
  $

The BTF ids continue to be undeterministic, as we need to process the
CUs (compile unites) in the same order that they are on vmlinux:

  $ bpftool btf dump file vmlinux.btf.serial > btfdump.serial
  $ bpftool btf dump file vmlinux.btf.parallel.reproducible_build > btfdump.parallel.reproducible_build
  $ bpftool btf dump file vmlinux.btf.parallel > btfdump.parallel
  $ diff -u btfdump.serial btfdump.parallel | wc -l
  624144
  $ diff -u btfdump.serial btfdump.parallel.reproducible_build | wc -l
  594622
  $ diff -u btfdump.parallel.reproducible_build btfdump.parallel | wc -l
  623355
  $

The BTF ids don't match, we'll get them to match at the end of this
patch series:

  $ tail -5 btfdump.serial
  	type_id=127124 offset=219200 size=40 (VAR 'rt6_uncached_list')
  	type_id=11760 offset=221184 size=64 (VAR 'vmw_steal_time')
  	type_id=13533 offset=221248 size=8 (VAR 'kvm_apic_eoi')
  	type_id=13532 offset=221312 size=64 (VAR 'steal_time')
  	type_id=13531 offset=221376 size=68 (VAR 'apf_reason')
  $ tail -5 btfdump.parallel.reproducible_build
  	type_id=113812 offset=219200 size=40 (VAR 'rt6_uncached_list')
  	type_id=87979 offset=221184 size=64 (VAR 'vmw_steal_time')
  	type_id=127391 offset=221248 size=8 (VAR 'kvm_apic_eoi')
  	type_id=127390 offset=221312 size=64 (VAR 'steal_time')
  	type_id=127389 offset=221376 size=68 (VAR 'apf_reason')
  $

Now to make it process the CUs in order, that should get everything
straight without hopefully not degrading it further too much.

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Kui-Feng Lee <kuifeng@fb.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 pahole.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/pahole.c b/pahole.c
index 96e153432fa212a5..fcb4360f11debeb9 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3173,6 +3173,14 @@ struct thread_data {
 	struct btf_encoder *encoder;
 };
 
+static int pahole_threads_prepare_reproducible_build(struct conf_load *conf, int nr_threads, void **thr_data)
+{
+	for (int i = 0; i < nr_threads; i++)
+		thr_data[i] = NULL;
+
+	return 0;
+}
+
 static int pahole_threads_prepare(struct conf_load *conf, int nr_threads, void **thr_data)
 {
 	int i;
@@ -3283,7 +3291,10 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 				thread->btf = btf_encoder__btf(btf_encoder);
 			}
 		}
-		pthread_mutex_unlock(&btf_lock);
+
+		// Reproducible builds don't have multiple btf_encoders, so we need to keep the lock until we encode BTF for this CU.
+		if (thr_data)
+			pthread_mutex_unlock(&btf_lock);
 
 		if (!btf_encoder) {
 			ret = LSK__STOP_LOADING;
@@ -3319,6 +3330,8 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 			exit(1);
 		}
 out_btf:
+		if (!thr_data) // See comment about reproducibe_build above
+			pthread_mutex_unlock(&btf_lock);
 		return ret;
 	}
 #if 0
@@ -3689,8 +3702,14 @@ int main(int argc, char *argv[])
 
 	conf_load.steal = pahole_stealer;
 	conf_load.thread_exit = pahole_thread_exit;
-	conf_load.threads_prepare = pahole_threads_prepare;
-	conf_load.threads_collect = pahole_threads_collect;
+
+	if (conf_load.reproducible_build) {
+		conf_load.threads_prepare = pahole_threads_prepare_reproducible_build;
+		conf_load.threads_collect = NULL;
+	} else {
+		conf_load.threads_prepare = pahole_threads_prepare;
+		conf_load.threads_collect = pahole_threads_collect;
+	}
 
 	// Make 'pahole --header type < file' a shorter form of 'pahole -C type --count 1 < file'
 	if (conf.header_type && !class_name && prettify_input) {
-- 
2.44.0

