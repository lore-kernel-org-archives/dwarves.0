Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864B04A2A76
	for <dwarves@vger.kernel.org>; Wed,  2 Sep 2026 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355705; cv=none; b=RUXkC7MmeaCRYoRx1zgJhnHzcPlLWWy2/RVAfF015zz0lagVqsIEBmBac1SyP6akRT1ADFz3QueNTt9wSrjqlDj0UBa/gA5VKNKm1aRbG06EjP6YWPPy3ZYdOgj83UHlZu6bnZ7BOpNfoPqCt1P7S8Htbn4z6y7kHwmlWlQGyHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355705; c=relaxed/simple;
	bh=aXKjzWeXVX4lSWSC2X5DPfIPz0YyZ4p7h5bks27jJ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cYgsRuXtsE32asrtZ8pNKFwGuGE/LNWapyxTz4JliH1VTjMDg4BPbfASoessXKehzaaErBiAGyrCYnhiJfeLZh+ZGj/fc9iAyBsGHBLL/7YpM3BB75IIpLjCDo4gV+eLVRjIL1fpmqczP7OyZoyrENZiGOoN9Z51H03FG/Q5DsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FhjjWzAq; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FhjjWzAq"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682BlbKj3963545;
	Wed, 2 Sep 2026 13:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=T83+jwuo36jzOE6SS5JmU7fNRO5Fj
	ErHy7xJnOd3tlU=; b=FhjjWzAqtl3uX+e5dAEJQZ8g7J5V9+IfNPF7U6GUcgy3X
	YLfEXcSmK1JzbSwIaa/++gDMdxhqgXpTqxGdROy6rRLv9QLlRWgnAld727XKd1F3
	5ELD9zmf45sNcLoaDnyDB2hlbQHQ1uVVngPe631aWpbISQCE19n/GABYxaVH+0rN
	aaAhBG6lN/IrrRU9OgsE8Xcqpptf7W/uPKdOu34A7DD30wPa5JnAMaSj7jn6Qavh
	wfaJjdBx0RsIzsUiSc9Hv1YvtNsJfe3k991q4hpqeWLL8jeVoNAMIzCGVvEcVzv6
	zJ0MF/+BkBP4eys8xAdvGYMOp1ReDwnm81AbzsIXQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqyrxvq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Sep 2026 13:28:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 682DOuNV007323;
	Wed, 2 Sep 2026 13:28:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvfsr1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Sep 2026 13:28:20 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 682DPWZH010350;
	Wed, 2 Sep 2026 13:28:19 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-253.vpn.oracle.com [10.154.52.253])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4gbnvfsr0u-1;
	Wed, 02 Sep 2026 13:28:19 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 1/3] pfunct: Add support for split BTF
Date: Wed,  2 Sep 2026 14:28:16 +0100
Message-ID: <20260902132818.1361588-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609020119
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDExOSBTYWx0ZWRfXx+I6/4ZxrrTg
 tHkSqUF0EnP1a8WjX22IRyPQcuYX4t3HytvlZhQ8PDlqQFwci19zKZJc+iQbFt3SzsEIMzsaJbH
 D1fzvCbioSbTSAXX8FWYNgSLh9LRpPanNLaVyqWhh6eBihM7ukRi+a/xo/024wVxhe1/FkzmzmD
 /ZuqYhpBLUFPbbD38MXuzi3j70N8KK2TsgTTpOttIHYotbVQ4kMNnxmSb5+XEd9wd5ENa8rrc4+
 z1n6Hva/X+n0asywcxgfFQ1tj6ByLVH3g9o307R6PNXwB9xTRuc2JOGtIouYK9NszSTWbY0ODVI
 AMLu0BIa9fRnkwchn7N8Hjdm6WwitJ2mKMtNx+nziam7DCQ4P50WIJqc5SssQlezpI3xZPKGtOQ
 SmyTto+SRm8PFJuymeSa58Nfdkctb6brC80TggA69aF4+DXCUHpZJIO5WspKd0kWReUc8CVu93s
 JRNLpqpwI0/7jMesIJg==
X-Proofpoint-ORIG-GUID: LNOwjQ_jO3wfVEIAduSouGbuMPofJEAN
X-Authority-Analysis: v=2.4 cv=fbCdDUQF c=1 sm=1 tr=0 ts=6a982475 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=oLNE0wnYRv2StUuxmQ8A:9
X-Proofpoint-GUID: LNOwjQ_jO3wfVEIAduSouGbuMPofJEAN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDExOSBTYWx0ZWRfX5AO9av0HLYud
 pH/ZeKfLVEUmFmLD7wqkzO6839iJqGhtf7qSQvhJJgKQfwUAZ5Tn6zo0f4rgzGfVMB7gQNjiBie
 Ixv8wYsfImo8tjpw+xbP3Gp1WiEofgrJGa7PLzK8dn4oPjtMlo3H

pahole supports split BTF loading for the BTF loader; align
pfunct to do the same.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 pfunct.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/pfunct.c b/pfunct.c
index 015ff0a..1dc88a5 100644
--- a/pfunct.c
+++ b/pfunct.c
@@ -15,6 +15,8 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
 
 #include "dwarves.h"
 #include "dwarves_emit.h"
@@ -36,6 +38,7 @@ static struct type_emissions emissions;
 static uint64_t addr;
 static char *class_name;
 static char *function_name;
+static const char *base_btf_file;
 
 static struct conf_fprintf conf;
 
@@ -544,6 +547,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_no_parm_names	301
 #define ARGP_compile		302
 #define ARGP_devel_version	303
+#define ARGP_btf_base		304
 
 static const struct argp_option pfunct__options[] = {
 	{
@@ -585,6 +589,12 @@ static const struct argp_option pfunct__options[] = {
 		.arg  = "FORMAT_LIST",
 		.doc  = "List of debugging formats to try"
 	},
+	{
+		.name = "btf_base",
+		.key  = ARGP_btf_base,
+		.arg  = "PATH",
+		.doc  = "Path to the base BTF file for split BTF input",
+	},
 	{
 		.key  = 'g',
 		.name = "goto_labels",
@@ -727,6 +737,7 @@ static error_t pfunct__options_parser(int key, char *arg,
 		  conf_load.extra_dbg_info = true;
 		  conf_load.get_addr_info = true;	 break;
 	case ARGP_symtab: symtab_name = arg ?: ".symtab";  break;
+	case ARGP_btf_base: base_btf_file = arg;             break;
 	case ARGP_no_parm_names: conf.no_parm_names = 1; break;
 	case ARGP_compile:
 		  expand_types = true;
@@ -780,6 +791,29 @@ int main(int argc, char *argv[])
 
 	dwarves__resolve_cacheline_size(&conf_load, 0);
 
+	/* Kernel module BTF in sysfs is split against vmlinux BTF. */
+	if (base_btf_file == NULL) {
+		const char *filename = argv[remaining];
+
+		if (filename &&
+		    strstarts(filename, "/sys/kernel/btf/") &&
+		    strstr(filename, "/vmlinux") == NULL)
+			base_btf_file = vmlinux_path__btf_filename();
+	}
+
+	if (base_btf_file) {
+		conf_load.base_btf = btf__parse(base_btf_file, NULL);
+		if (libbpf_get_error(conf_load.base_btf)) {
+			fprintf(stderr, "pfunct: Failed to parse base BTF '%s': %ld\n",
+				base_btf_file, libbpf_get_error(conf_load.base_btf));
+			goto out_dwarves_exit;
+		}
+
+		/* A base BTF is meaningful only when loading BTF input. */
+		if (conf_load.format_path == NULL)
+			conf_load.format_path = "btf";
+	}
+
 	struct cus *cus = cus__new();
 	if (cus == NULL) {
 		fputs("pfunct: insufficient memory\n", stderr);
@@ -833,6 +867,8 @@ out_cus_delete:
 	cus__delete(cus);
 	fn_stats__delete_list();
 out_dwarves_exit:
+	btf__free(conf_load.base_btf);
+	conf_load.base_btf = NULL;
 	dwarves__exit();
 out:
 	return rc;
-- 
2.43.5

