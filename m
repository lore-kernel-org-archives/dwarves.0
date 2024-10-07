Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477B31DE4DC
	for <dwarves@vger.kernel.org>; Mon,  7 Oct 2024 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332754; cv=none; b=FIxhrJGSKqPmCQdgoR1q8uNtczIfWi+rv57eGtcYTWVfUPw3UxsZ6yqNYNr0i7szzZoQXuyNHRogOoQxowHeKgetZAneCpxelGeXv9zuvt12JfmAVjJWv3yyVwmYQjV9OtPKE2TuEtmW4IvCDPK7qfdmFGwvSA2c+oXfLJMHZ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332754; c=relaxed/simple;
	bh=sTLCrxEJkzwt1o/+fm3mAT2MtHKzdkcWxSPsZGJVVH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/t0Y6geveq4PCUWkcaN3FsgwEIcWvogRktWaKsLdnNUgJs854UZHUEsri3MzxRYKHI8Wv3lnrcebBdD09nF15bUXk8QYnO7j23kJVHLyDBIOGHw5/zw8aShAFZwPBUFovvCNF3+Sd/wlNRjmtF7ljzff0XP67/+fvzqZfwVVEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gq5iN2DG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gq5iN2DG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46486C4CEC7;
	Mon,  7 Oct 2024 20:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728332753;
	bh=sTLCrxEJkzwt1o/+fm3mAT2MtHKzdkcWxSPsZGJVVH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gq5iN2DG4UAfoocSlsM/r2n+BCT44UeBqEtH+/1x7eEPO9AHjhHlgvKPdw1gpIbCG
	 fGuzfEqTtCilwAIrrVzBLcLjOAEDMiehIjHKXCUCTjduZqn4KqjwzNoMhRXj2CnNtz
	 GvtEk5h3LNSFbLeY7LXna+Y28RwxOsO0ReJLCpOUYa0X2WbOSrLfdj/alBgkcg2OBy
	 Do8MhGxdnhTKBNEU1McTEhpoyrIxfJ9VvK2zSddO8MYHYjEjy/hUuw0BfLwoWO8lX3
	 hhEA6n6w0LTV0Xso3OoMDjkii6hpoFDWzcU4IxaBzH1WUv9xmspAm2t9tA+JqLw/2P
	 yRzFKQDcaPEaQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 5/5] pahole: Introduce --with_embedded_flexible_array
Date: Mon,  7 Oct 2024 17:25:31 -0300
Message-ID: <20241007202531.942648-6-acme@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007202531.942648-1-acme@kernel.org>
References: <20241007202531.942648-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To print structs that have as one of its members a struct with a
flexible array, i.e. the outer script has a flexible array in its
middle, which is dangerous.

One example should illustrate this nicely:

  ⬢[acme@toolbox pahole]$ pahole --with_embedded_flexible_array --sizes | wc -l
  103
  ⬢[acme@toolbox pahole]$ pahole --with_embedded_flexible_array --sizes | tail
  acpi_nhlt_format_config	44	0
  xts_request_ctx	168	0
  dbc_port	512	1
  ethtool_link_usettings	96	0
  pci_setup_rom	64	1
  lirc_fh	112	1
  lrw_request_ctx	96	0
  xt_standard_target	40	0
  xt_error_target	64	0
  bpf_ctx_convert	7280	0
  ⬢[acme@toolbox pahole]$ pahole lirc_fh
  struct lirc_fh {
  	struct list_head           list;                 /*     0    16 */
  	struct rc_dev *            rc;                   /*    16     8 */
  	int                        carrier_low;          /*    24     4 */

  	/* XXX 4 bytes hole, try to pack */

  	struct {
  		union {
  			struct __kfifo kfifo;            /*    32    24 */
  			unsigned int * type;             /*    32     8 */
  			const unsigned int  * const_type; /*    32     8 */
  			char *     rectype;              /*    32     8 */
  			unsigned int * ptr;              /*    32     8 */
  			const unsigned int  * ptr_const; /*    32     8 */
  		};                                       /*    32    24 */
  		unsigned int       buf[];                /*    56     0 */
  	} rawir;                                         /*    32    24 */
  	struct {
  		union {
  			struct __kfifo kfifo;            /*    56    24 */
  			struct lirc_scancode * type;     /*    56     8 */
  			const struct lirc_scancode  * const_type; /*    56     8 */
  			char *     rectype;              /*    56     8 */
  			struct lirc_scancode * ptr;      /*    56     8 */
  			const struct lirc_scancode  * ptr_const; /*    56     8 */
  		};                                       /*    56    24 */
  		/* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
  		struct lirc_scancode buf[];              /*    80     0 */
  	} scancodes;                                     /*    56    24 */
  	wait_queue_head_t          wait_poll;            /*    80    24 */
  	u8                         send_mode;            /*   104     1 */
  	u8                         rec_mode;             /*   105     1 */

  	/* size: 112, cachelines: 2, members: 8 */
  	/* sum members: 102, holes: 1, sum holes: 4 */
  	/* padding: 6 */
  	/* last cacheline: 48 bytes */
  };

  ⬢[acme@toolbox pahole]$

Another case:

  ⬢[acme@toolbox pahole]$ pahole -E ethtool_link_usettings
  struct ethtool_link_usettings {
  	struct ethtool_link_settings {
  		/* typedef __u32 */ unsigned int       cmd;                              /*     0     4 */
  		/* typedef __u32 */ unsigned int       speed;                            /*     4     4 */
  		/* typedef __u8 */ unsigned char      duplex;                            /*     8     1 */
  		/* typedef __u8 */ unsigned char      port;                              /*     9     1 */
  		/* typedef __u8 */ unsigned char      phy_address;                       /*    10     1 */
  		/* typedef __u8 */ unsigned char      autoneg;                           /*    11     1 */
  		/* typedef __u8 */ unsigned char      mdio_support;                      /*    12     1 */
  		/* typedef __u8 */ unsigned char      eth_tp_mdix;                       /*    13     1 */
  		/* typedef __u8 */ unsigned char      eth_tp_mdix_ctrl;                  /*    14     1 */
  		/* typedef __s8 */ signed char        link_mode_masks_nwords;            /*    15     1 */
  		/* typedef __u8 */ unsigned char      transceiver;                       /*    16     1 */
  		/* typedef __u8 */ unsigned char      master_slave_cfg;                  /*    17     1 */
  		/* typedef __u8 */ unsigned char      master_slave_state;                /*    18     1 */
  		/* typedef __u8 */ unsigned char      rate_matching;                     /*    19     1 */
  		/* typedef __u32 */ unsigned int       reserved[7];                      /*    20    28 */
  		/* typedef __u32 */ unsigned int       link_mode_masks[];                /*    48     0 */
  	} base; /*     0    48 */
  	struct {
  		/* typedef __u32 */ unsigned int       supported[4];                     /*    48    16 */
  		/* --- cacheline 1 boundary (64 bytes) --- */
  		/* typedef __u32 */ unsigned int       advertising[4];                   /*    64    16 */
  		/* typedef __u32 */ unsigned int       lp_advertising[4];                /*    80    16 */
  	} link_modes;                                                                    /*    48    48 */

  	/* size: 96, cachelines: 2, members: 2 */
  	/* last cacheline: 32 bytes */
  };

  ⬢[acme@toolbox pahole]$

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 man-pages/pahole.1 |  4 ++++
 pahole.c           | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 7c1a69ad23690c75..19dfe676c9e30509 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -397,6 +397,10 @@ for instance when using the \fB\-\-reorganize\fR option.
 .B \-P, \-\-with_flexible_array
 Show only structs that have a flexible array.
 
+.TP
+.B \-P, \-\-with_embedded_flexible_array
+Show only structs that have an embedded flexible array, i.e. a contained struct that has flexible arrays, a flexible array "in the middle".
+
 .TP
 .B \-q, \-\-quiet
 Be quieter.
diff --git a/pahole.c b/pahole.c
index 8bdfaf3e84c407d7..b9e97ef15e6c732e 100644
--- a/pahole.c
+++ b/pahole.c
@@ -66,6 +66,7 @@ static uint16_t nr_bit_holes;
 static uint16_t hole_size_ge;
 static uint8_t show_packable;
 static bool show_with_flexible_array;
+static bool show_with_embedded_flexible_array;
 static uint8_t global_verbose;
 static uint8_t recursive;
 static size_t cacheline_size;
@@ -825,6 +826,9 @@ static struct class *class__filter(struct class *class, struct cu *cu,
 	if (show_with_flexible_array && !class__has_flexible_array(class, cu))
 		return NULL;
 
+	if (show_with_embedded_flexible_array && !class__has_embedded_flexible_array(class, cu))
+		return NULL;
+
 	return class;
 }
 
@@ -1226,6 +1230,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_running_kernel_vmlinux 346
 #define ARG_padding_ge		   347
 #define ARG_padding		   348
+#define ARGP_with_embedded_flexible_array 349
 
 /* --btf_features=feature1[,feature2,..] allows us to specify
  * a list of requested BTF features or "default" to enable all default
@@ -1505,6 +1510,11 @@ static const struct argp_option pahole__options[] = {
 		.key  = ARGP_with_flexible_array,
 		.doc  = "show only structs with a flexible array",
 	},
+	{
+		.name = "with_embedded_flexible_array",
+		.key  = ARGP_with_embedded_flexible_array,
+		.doc  = "show only structs with an embedded flexible array (contaning a struct that has a flexible array)",
+	},
 	{
 		.name = "expand_types",
 		.key  = 'E',
@@ -2006,6 +2016,9 @@ static error_t pahole__options_parser(int key, char *arg,
 		parse_btf_features("all", false);	break;
 	case ARGP_with_flexible_array:
 		show_with_flexible_array = true;	break;
+	case ARGP_with_embedded_flexible_array:
+		just_structs = true;
+		show_with_embedded_flexible_array = true; break;
 	case ARGP_prettify_input_filename:
 		prettify_input_filename = arg;		break;
 	case ARGP_sort_output:
-- 
2.46.2

