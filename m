Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B0EC433B4
	for <linux-dwarves@archiver.kernel.org>; Wed, 19 May 2021 02:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94D466139A
	for <linux-dwarves@archiver.kernel.org>; Wed, 19 May 2021 02:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbhESCqF (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 18 May 2021 22:46:05 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:42679 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235114AbhESCqF (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 18 May 2021 22:46:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=chengshuyi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UZLvOlq_1621392284;
Received: from B-39YZML7H-2200.local(mailfrom:chengshuyi@linux.alibaba.com fp:SMTPD_---0UZLvOlq_1621392284)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 May 2021 10:44:45 +0800
From:   Shuyi Cheng <chengshuyi@linux.alibaba.com>
Subject: [PATCH v2] pahole: Add --kabi_prefix flag
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     dwarves@vger.kernel.org, wenan.mao@linux.alibaba.com,
        Jiri Olsa <jolsa@kernel.org>
References: <a249699a-7c6c-4d4a-71b0-87981c8d229e@linux.alibaba.com>
 <YKKA64WWqYN3P7YJ@kernel.org>
 <c3520803-77af-cc34-000a-de4ba6334bcb@linux.alibaba.com>
 <YKO34fq6P8G9IyMD@kernel.org>
 <CAEf4Bzazh4RNCY3rGRRXfO2wJ7DSiMx8w+61B_hjhu9FrOffpQ@mail.gmail.com>
Message-ID: <ec80d351-ac2f-5c48-c339-c2c503d36d68@linux.alibaba.com>
Date:   Wed, 19 May 2021 10:44:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAEf4Bzazh4RNCY3rGRRXfO2wJ7DSiMx8w+61B_hjhu9FrOffpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

To solve problems similar to _RH_KABI_REPLACE. The 
_RH_KABI_REPLACE(_orig, _new) macros perserve size alignment and kabi 
agreement between _orig and _new.Below is the definition of this macro:

# define _RH_KABI_REPLACE(_orig, _new)            \
     union {                        \
         _new;                    \
         struct {                \
             _orig;                \
         } __UNIQUE_ID(rh_kabi_hide);        \
         __RH_KABI_CHECK_SIZE_ALIGN(_orig, _new);    \
     }


__UNIQUE_ID uses the __COUNTER__ macro, and the __COUNTER__ macro is 
automatically incremented by 1 every time it is precompiled. Therefore, 
in different compilation units, the same structure has different 
names.Here is a concrete example:

struct acpi_dev_node {
     union {
         struct acpi_device *companion;
         struct {
             void *handle;
         } __UNIQUE_ID_rh_kabi_hide29;
         union {        };
     };
};
struct acpi_dev_node {
     union {
         struct acpi_device *companion;
         struct {
             void *handle;
         } __UNIQUE_ID_rh_kabi_hide31;
         union {        };
     };
};

Finally, it will cause the btf algorithm to de-duplication efficiency is 
not high, and time-consuming. For example, running ./pahole -J 
vmlinux-3.10.0-1160.el7.x86_64 without --kabi_prefix flag, the running 
time is:
                 real 8m28.912s
                 user 8m27.271s
                 sys 0m1.471s
And the size of the generated btf segment is 30678240 bytes.

After adding the patch, running ./pahole 
--kabi_prefix=__UNIQUE_ID_rh_kabi_hide -J 
vmlinux-3.10.0-1160.el7.x86_64. The running time of the command is:
                 real 0m19.634s
                 user 0m18.457s
                 sys 0m1.169s
And the size of the generated btf segment is 3117719 bytes.

---

v1:https://lore.kernel.org/dwarves/CAEf4Bzazh4RNCY3rGRRXfO2wJ7DSiMx8w+61B_hjhu9FrOffpQ@mail.gmail.com
v1->v2:
--Change btf_prefix to --kabi_prefix.
--Add man page.
--Add space after if and comma.

  man-pages/pahole.1 |  4 ++++
  pahole.c           | 10 ++++++++++
  pahole_strings.h   |  2 ++
  strings.c          |  9 ++++++++-
  4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index a10738f..2659fe6 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -340,6 +340,10 @@ Show a traditional string version, i.e.: "v1.18".
  Show a numeric only version, suitable for use in Makefiles and scripts 
where
  one wants to know what if the installed version has some feature, 
i.e.: 118 instead of "v1.18".

+.TP
+.B \-\-kabi_prefix=STRING
+When the prefix of the string is STRING, treat the string as STRING.
+
  .SH NOTES

  To enable the generation of debugging information in the Linux kernel 
build
diff --git a/pahole.c b/pahole.c
index dc40ccf..6a700d9 100644
--- a/pahole.c
+++ b/pahole.c
@@ -24,6 +24,7 @@
  #include "btf_encoder.h"
  #include "libbtf.h"
  #include "lib/bpf/src/libbpf.h"
+#include "pahole_strings.h"

  static bool btf_encode;
  static bool ctf_encode;
@@ -855,6 +856,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
  #define ARGP_btf_gen_floats	   322
  #define ARGP_btf_gen_all	   323
  #define ARGP_with_flexible_array   324
+#define ARGP_kabi_prefix   325

  static const struct argp_option pahole__options[] = {
  	{
@@ -1140,6 +1142,12 @@ static const struct argp_option pahole__options[] = {
  		.doc  = "Path to the base BTF file",
  	},
  	{
+		.name = "kabi_prefix",
+		.key = ARGP_kabi_prefix,
+		.arg = "STRING",
+		.doc = "When the prefix of the string is STRING, treat the string as 
STRING.",
+	},
+	{
  		.name = "btf_encode",
  		.key  = 'J',
  		.doc  = "Encode as BTF",
@@ -1297,6 +1305,8 @@ static error_t pahole__options_parser(int key, 
char *arg,
  		btf_encode_force = true;		break;
  	case ARGP_btf_base:
  		base_btf_file = arg;			break;
+	case ARGP_kabi_prefix:
+		kabi_prefix = arg;		break;
  	case ARGP_numeric_version:
  		print_numeric_version = true;		break;
  	case ARGP_btf_gen_floats:
diff --git a/pahole_strings.h b/pahole_strings.h
index 522fbf2..a836ba8 100644
--- a/pahole_strings.h
+++ b/pahole_strings.h
@@ -14,6 +14,8 @@ struct strings {
  	struct btf *btf;
  };

+extern const char *kabi_prefix;
+
  struct strings *strings__new(void);

  void strings__delete(struct strings *strings);
diff --git a/strings.c b/strings.c
index d37f49d..d1a54ec 100644
--- a/strings.c
+++ b/strings.c
@@ -17,6 +17,8 @@
  #include "dutil.h"
  #include "lib/bpf/src/libbpf.h"

+const char *kabi_prefix;
+
  struct strings *strings__new(void)
  {
  	struct strings *strs = malloc(sizeof(*strs));
@@ -48,7 +50,12 @@ strings_t strings__add(struct strings *strs, const 
char *str)
  	if (str == NULL)
  		return 0;

-	index = btf__add_str(strs->btf, str);
+	if (kabi_prefix &&
+		strncmp(str, kabi_prefix, strlen(kabi_prefix)) == 0)
+		index = btf__add_str(strs->btf, kabi_prefix);
+	else
+		index = btf__add_str(strs->btf, str);
+		
  	if (index < 0)
  		return 0;

-- 
1.8.3.1

