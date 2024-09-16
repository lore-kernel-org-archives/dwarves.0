Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3C315534E
	for <dwarves@vger.kernel.org>; Mon, 16 Sep 2024 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726494606; cv=none; b=YE62rsn0OlrD+tI5imkL9/U5dzXNGR+KgeDNmXWS7+85EVoS7Pc0phh+xcvv5yRapVNkyRUsG5rCseqWvqL82acbP0QEPQlhMWyikEsm9pgemctOL6tm4It94BLsxGyVzugAGcD/ythkOqCZqzgMKJ90Y2PcBdthNfEZdsZjcgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726494606; c=relaxed/simple;
	bh=3Zx7OsNoz+o3l+eYn/59zPWmd9qhUKRs9lEtpVmFt84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+RVgaDojhZCuCaWETYVQ+M0WUa6ogAdpMsMyae0/+hREbFUw9YHWX1FCOdM79LAIEV2cjwM8PL11Irv9osxdQt9M5e16XBGBKDSFeyAq1AYj4SlVLD7B5WhOfVBENZcxL45F1aQjdUW+6UCw2XKP1p6nOvZ33qT6deXzG9wcGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y+NkfPJw; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y+NkfPJw"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GCC4Pi011574;
	Mon, 16 Sep 2024 13:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=2
	FF2hmqoBV2XcH1Iy5nWfb7e6CiJBPHpEWQGYiQRTR8=; b=Y+NkfPJwnweksaydP
	lqkXyDU8RBBGCfrjDmd4Y2ty7DybR9CSKwl7TcnI7/16lY8bwDUVEGkiArra+HVy
	7pc5KrRJ//D80IAdp8Z/+6V4hNfeHZxFEY+cWEiCCwdizBwPSwZYWqzmHCKBeas8
	b5x8UBzocoNvBuSw44pyNdVDhy6l1unrlAejCL9HraQ7fEbQYaVqquYxB1F+nGuB
	o2w+N9RHnWAOVtpw5VSlIDibx6Y4fijFoZ9YoIQkYp4xBrI8nzftGLc7IMIw7Av+
	TgIxQ1G/Uqom/J6CnS7m0kwMhdfOwtdF3wLgB3cFOFm9OyF/7P44Ikzt39xs5pmw
	UMs2w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3rjua74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 13:49:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48GDN9oN017899;
	Mon, 16 Sep 2024 13:49:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nycvcbhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 13:49:55 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48GDlw0s019465;
	Mon, 16 Sep 2024 13:49:55 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-208-154.vpn.oracle.com [10.175.208.154])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41nycvcbbr-3;
	Mon, 16 Sep 2024 13:49:55 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, eddyz87@gmail.com, olsajiri@gmail.com,
        shung-hsi.yu@suse.com, jirislaby@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 2/3] pfunct: show all functions that match filter criteria
Date: Mon, 16 Sep 2024 14:49:45 +0100
Message-ID: <20240916134946.3893204-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240916134946.3893204-1-alan.maguire@oracle.com>
References: <20240916134946.3893204-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_10,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409160088
X-Proofpoint-ORIG-GUID: e910xED0ZPvMxKjQ2YtGXrF-fKCzi1xR
X-Proofpoint-GUID: e910xED0ZPvMxKjQ2YtGXrF-fKCzi1xR

currently, "pfunct --function <name> vmlinux" will bail once it finds
an instance of a function; add an option

  -A, --all                  show all functions that match filter, or show all
                             function prototypes if no filter is specified

..that allows us to see all instances of a function.  It will be
useful in testing functions skipped by BTF encoding.

When --function is not specified, all prototypes are displayed but
we make use of the pfunct_stealer for this case as it massively
speeds up processing from ~6min to ~12sec.

It will be useful in tests to be able to collect prototypes quickly.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 pfunct.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/pfunct.c b/pfunct.c
index bc3026b..e6cb898 100644
--- a/pfunct.c
+++ b/pfunct.c
@@ -29,6 +29,7 @@ static int show_cc_inlined;
 static int show_cc_uninlined;
 static char *symtab_name;
 static bool show_prototypes;
+static bool show_all_matches;
 static bool expand_types;
 static bool compilable_output;
 static struct type_emissions emissions;
@@ -368,17 +369,19 @@ do_parameters:
 static void function__show(struct function *func, struct cu *cu)
 {
 	struct tag *tag = function__tag(func);
+	struct fn_stats *fstats = NULL;
 
 	if (func->abstract_origin || func->declaration)
 		return;
 
-	struct fn_stats *fstats = fn_stats__find(func->name);
+	if (!show_all_matches) {
+		fstats = fn_stats__find(func->name);
 
-	if (fstats && fstats->printed)
-		return;
-
-	if (expand_types)
-		function__emit_type_definitions(func, cu, stdout);
+		if (fstats && fstats->printed)
+			return;
+		if (expand_types)
+			function__emit_type_definitions(func, cu, stdout);
+	}
 	tag__fprintf(tag, cu, &conf, stdout);
 	if (compilable_output) {
 		struct tag *type = cu__type(cu, func->proto.tag.type);
@@ -399,6 +402,8 @@ static void function__show(struct function *func, struct cu *cu)
 		fprintf(stdout, "\n}\n");
 	}
 	putchar('\n');
+	if (show_all_matches)
+		return;
 	if (show_variables || show_inline_expansions)
 		function__fprintf_stats(tag, cu, &conf, stdout);
 
@@ -417,8 +422,6 @@ static int cu_function_iterator(struct cu *cu, void *cookie)
 		if (cookie && strcmp(function__name(function), cookie) != 0)
 			continue;
 		function__show(function, cu);
-		if (!expand_types)
-			return 1;
 	}
 	return 0;
 }
@@ -514,12 +517,19 @@ static enum load_steal_kind pfunct_stealer(struct cu *cu,
 
 		if (tag) {
 			function__show(tag__function(tag), cu);
-			return LSK__STOP_LOADING;
+			return show_all_matches ? LSK__DELETE : LSK__STOP_LOADING;
 		}
 	} else if (class_name) {
 		cu_class_iterator(cu, class_name);
+	} else if (show_all_matches) {
+		struct function *pos;
+		uint32_t id;
+
+		cu__for_each_function(cu, id, pos)
+			function__show(pos, cu);
 	}
 
+
 	return LSK__DELETE;
 }
 
@@ -537,6 +547,11 @@ static const struct argp_option pfunct__options[] = {
 		.arg  = "ADDR",
 		.doc  = "show just the function that where ADDR is",
 	},
+	{
+		.key  = 'A',
+		.name = "all",
+		.doc  = "show all functions that match filter, or show all function prototypes if no filter is specified",
+	},
 	{
 		.key  = 'b',
 		.name = "expand_types",
@@ -672,6 +687,7 @@ static error_t pfunct__options_parser(int key, char *arg,
 		break;
 	case 'a': addr = strtoull(arg, NULL, 0);
 		  conf_load.get_addr_info = true;	 break;
+	case 'A': show_all_matches = true;		 break;
 	case 'b': expand_types = true;
 		  type_emissions__init(&emissions, &conf);	 break;
 	case 'c': class_name = arg;			 break;
@@ -751,7 +767,7 @@ int main(int argc, char *argv[])
 		goto out_dwarves_exit;
 	}
 
-	if (function_name || class_name)
+	if (function_name || (!function_name && show_all_matches) || class_name)
 		conf_load.steal = pfunct_stealer;
 
 try_sole_arg_as_function_name:
-- 
2.43.5

