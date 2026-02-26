Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4883B396B85;
	Thu, 26 Feb 2026 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096248; cv=none; b=bCta5M/776LyYxf1QNrMOhmXY0+0woX4KAKciyXViU8qnlWYX6U5MuqglthZz6/F+AKQn+idMn1X+l39jdtn0t3hGraFlBwP4ovUSgoWhUL2twlHWRGPkOW1OPbvRkh0BjGj8xNTQWL7MBbs+uA7VQmRbobAByLivskLZ4L4DmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096248; c=relaxed/simple;
	bh=q7mS7GBHpJJzzsO5abaO+o/rmaOgHQFdIH/Er0fq3ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNudQ921GH1v5b7MOx1QGEOBThjTjzP3HAvb2u7DKR6aoTTVjyFG0Gd22tQbqUACR50Jn073DQ0pYqDrY2V7RRMO5Ufzq1vEjFlZ8p+Mb4RNUQptNQIMGsurFTs3r9wVJmvyJrqSQv0s1xTy4QaJMrvJuLfHDDBW/To7A2CM3Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L5PQbCzg; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L5PQbCzg"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PNvrOm3277797;
	Thu, 26 Feb 2026 08:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=NhCxW
	kthcRapVhBF+9X4FDof++R/nlRzRCsLPVilZEU=; b=L5PQbCzg/mPqTpP3lRfl2
	6GPOt2lwVJ42KIFzgsWXA0H9dMbd0ZARLV0Myxl4bCkRk2ZEZT1urBVgUmj0xdY2
	B/TWWTboM6XDIm780XO0n8qCHmMSoNeAeDHG3ikkaAmFahCtLJeeW7wrvQ04XLzZ
	oog2qzkjKXgps9LZFrwU7RG/cMX8WvKo4apqy576Tjsn2i7BXcfp+bQb/2Duu3T6
	K61T6QWjwpshzjwJN3gkxW3xCJmdaqyPzqSxmYkkxYJGFzur+TCFPP3qqpDNX/xR
	pKvvnPqrlilr9HtzsJo+fOovfB/h9p6GQ95e7e/8YD07T6sHqKq8+Puoi7p3JcL0
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k5ytf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:57:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q7G5Ad028662;
	Thu, 26 Feb 2026 08:57:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35c75kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:57:05 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61Q8uYag038952;
	Thu, 26 Feb 2026 08:57:04 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-58-146.vpn.oracle.com [10.154.58.146])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35c759a-9;
	Thu, 26 Feb 2026 08:57:04 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v9 bpf-next 08/10] bpftool: add BTF dump "format meta" to dump header/metadata
Date: Thu, 26 Feb 2026 08:56:22 +0000
Message-ID: <20260226085624.1909682-9-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260226085624.1909682-1-alan.maguire@oracle.com>
References: <20260226085624.1909682-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602260079
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA3OSBTYWx0ZWRfX4vHoRhO6T2eZ
 x2ThNdmasFET31mTTpV+wq36S/p1v4cM49H6P6lOPp95ZFYBA8cmMUHrN9nPEQqxHTaZWPU5bqK
 Gn+wGCSidQc+b9FlqEWjb8USO3NcR/aabiHcT41CpFvS5FmnszMiEX91PScetWO4HWzVC7+oWOg
 fLnNlTXjBWKVdzG3kR+yT5ADOcExz/EUK0UDy2rzO9iK6nZSv6z1cTWzTFmDYPJmwWwrhmybwxf
 Q+gTtU+Pnj3MuJzN+d+Ta1XMSrghG/WFdAaLbiItHKpqcka8aLRkVjDLPRVD3jakoiJJREEgAcU
 b+SXA5z/rfnjGxluxByPELJXdNztcyPLQCiayPBlBATTi5+D67IV/4QjAUoRPXGBWguIyUXrrVc
 gdpkzMiEz+unY3JXl6yqNMvFzYMyiFm2RtagSI/wud3wSDZ2xjbJL+eSmKNIU7FDQqsNEUW1Hff
 1x5mXg7x3u72PBFpMcg==
X-Proofpoint-GUID: OPpHZ7xzMuFQes3cN1mPKRZpgcWB0yPN
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=69a00ae1 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=wuTlCl8tugMN2R7urv8A:9
X-Proofpoint-ORIG-GUID: OPpHZ7xzMuFQes3cN1mPKRZpgcWB0yPN

Provide a way to dump BTF metadata info via bpftool; this
consists of BTF size, header fields and layout info
(if available); for example

$ bpftool btf dump file vmlinux format meta
size 6516862
magic 0xeb9f
version 1
flags 0x0
hdr_len 32
type_len 3929096
type_off 0
str_len 2587654
str_off 3929176
layout_len 80
layout_off 3929096
kind 0    UNKNOWN    info_sz 0    elem_sz 0    flags 0
kind 1    INT        info_sz 4    elem_sz 0    flags 0
kind 2    PTR        info_sz 0    elem_sz 0    flags 0
kind 3    ARRAY      info_sz 12   elem_sz 0    flags 0
kind 4    STRUCT     info_sz 0    elem_sz 12   flags 0
kind 5    UNION      info_sz 0    elem_sz 12   flags 0
kind 6    ENUM       info_sz 0    elem_sz 8    flags 0
kind 7    FWD        info_sz 0    elem_sz 0    flags 0
kind 8    TYPEDEF    info_sz 0    elem_sz 0    flags 0
kind 9    VOLATILE   info_sz 0    elem_sz 0    flags 0
kind 10   CONST      info_sz 0    elem_sz 0    flags 0
kind 11   RESTRICT   info_sz 0    elem_sz 0    flags 0
kind 12   FUNC       info_sz 0    elem_sz 0    flags 0
kind 13   FUNC_PROTO info_sz 0    elem_sz 8    flags 0
kind 14   VAR        info_sz 4    elem_sz 0    flags 0
kind 15   DATASEC    info_sz 0    elem_sz 12   flags 0
kind 16   FLOAT      info_sz 0    elem_sz 0    flags 0
kind 17   DECL_TAG   info_sz 4    elem_sz 0    flags 0
kind 18   TYPE_TAG   info_sz 0    elem_sz 0    flags 0
kind 19   ENUM64     info_sz 0    elem_sz 12   flags 0

JSON output is also supported:

$ bpftool -p btf dump file /var/tmp/vmlinux.kind_layout format meta
{
    "size": 6516862,
    "header": {
        "magic": 60319,
        "version": 1,
        "flags": 0,
        "hdr_len": 32,
        "type_len": 3929096,
        "type_off": 0,
        "str_len": 2587654,
        "str_off": 3929176,
        "layout_len": 80,
        "layout_offset": 3929096
    },
    "layouts": [{
            "kind": 0,
            "name": "UNKNOWN",
            "info_sz": 0,
            "elem_sz": 0,
            "flags": 0
        },{
            "kind": 1,
            "name": "INT",
            "info_sz": 4,
            "elem_sz": 0,
            "flags": 0
        },{
            "kind": 2,
            "name": "PTR",
            "info_sz": 0,
            "elem_sz": 0,
            "flags": 0
        },{
...

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/bash-completion/bpftool |  2 +-
 tools/bpf/bpftool/btf.c                   | 94 ++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index a28f0cc522e4..d49d6a70cb74 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -950,7 +950,7 @@ _bpftool()
                             return 0
                             ;;
                         format)
-                            COMPREPLY=( $( compgen -W "c raw" -- "$cur" ) )
+                            COMPREPLY=( $( compgen -W "c raw meta" -- "$cur" ) )
                             ;;
                         root_id)
                             return 0;
diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 946612029dee..02f6ca4b3a51 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -835,6 +835,90 @@ static int dump_btf_c(const struct btf *btf,
 	return err;
 }
 
+static int dump_btf_meta(const struct btf *btf)
+{
+	__u32 data_sz, i, nr_kinds = 0;
+	const struct btf_header *hdr;
+	const struct btf_layout *l;
+	const void *data;
+
+	data = btf__raw_data(btf, &data_sz);
+	if (!data)
+		return -ENOMEM;
+	hdr = data;
+	if (json_output) {
+		jsonw_start_object(json_wtr);		/* metadata object */
+		jsonw_uint_field(json_wtr, "size", data_sz);
+		jsonw_name(json_wtr, "header");
+		jsonw_start_object(json_wtr);		/* header object */
+		jsonw_uint_field(json_wtr, "magic", hdr->magic);
+		jsonw_uint_field(json_wtr, "version", hdr->version);
+		jsonw_uint_field(json_wtr, "flags", hdr->flags);
+		jsonw_uint_field(json_wtr, "hdr_len", hdr->hdr_len);
+		jsonw_uint_field(json_wtr, "type_len", hdr->type_len);
+		jsonw_uint_field(json_wtr, "type_off", hdr->type_off);
+		jsonw_uint_field(json_wtr, "str_len", hdr->str_len);
+		jsonw_uint_field(json_wtr, "str_off", hdr->str_off);
+	} else {
+		printf("size %-10u\n", data_sz);
+		printf("magic 0x%-10x\nversion %-10d\nflags 0x%-10x\nhdr_len %-10u\n",
+		       hdr->magic, hdr->version, hdr->flags, hdr->hdr_len);
+		printf("type_len %-10u\ntype_off %-10u\n", hdr->type_len, hdr->type_off);
+		printf("str_len %-10u\nstr_off %-10u\n", hdr->str_len, hdr->str_off);
+	}
+
+	if (hdr->hdr_len < sizeof(struct btf_header) || data_sz <= hdr->hdr_len) {
+		if (json_output) {
+			jsonw_end_object(json_wtr);	/* end header object */
+			jsonw_end_object(json_wtr);	/* end metadata object */
+		}
+		return 0;
+	}
+
+	data_sz -= hdr->hdr_len;
+
+	if (hdr->layout_len > 0 && hdr->layout_off > 0) {
+		if ((long long)hdr->layout_off + hdr->layout_len <= data_sz) {
+			l = (void *)hdr + hdr->hdr_len + hdr->layout_off;
+			nr_kinds = hdr->layout_len / sizeof(*l);
+		}
+	}
+	if (json_output) {
+		jsonw_uint_field(json_wtr, "layout_len", hdr->layout_len);
+		jsonw_uint_field(json_wtr, "layout_offset", hdr->layout_off);
+		jsonw_end_object(json_wtr);		/* end header object */
+
+		if (nr_kinds > 0) {
+			jsonw_name(json_wtr, "layouts");
+			jsonw_start_array(json_wtr);
+			for (i = 0; i < nr_kinds; i++) {
+				jsonw_start_object(json_wtr);
+				jsonw_uint_field(json_wtr, "kind", i);
+				if (i < NR_BTF_KINDS)
+					jsonw_string_field(json_wtr, "name", btf_kind_str[i]);
+				else
+					jsonw_null_field(json_wtr, "name");
+				jsonw_uint_field(json_wtr, "info_sz", l[i].info_sz);
+				jsonw_uint_field(json_wtr, "elem_sz", l[i].elem_sz);
+				jsonw_uint_field(json_wtr, "flags", l[i].flags);
+				jsonw_end_object(json_wtr);
+			}
+			jsonw_end_array(json_wtr);
+		}
+		jsonw_end_object(json_wtr);		/* end metadata object */
+	} else {
+		printf("layout_len %-10u\nlayout_off %-10u\n",
+		       hdr->layout_len, hdr->layout_off);
+		for (i = 0; i < nr_kinds; i++) {
+			printf("kind %-4u %-10s info_sz %-4d elem_sz %-4d flags %-4d\n",
+			       i, i < NR_BTF_KINDS ? btf_kind_str[i] : "?",
+			       l[i].info_sz, l[i].elem_sz, l[i].flags);
+		}
+	}
+
+	return 0;
+}
+
 static const char sysfs_vmlinux[] = "/sys/kernel/btf/vmlinux";
 
 static struct btf *get_vmlinux_btf_from_sysfs(void)
@@ -880,7 +964,7 @@ static bool btf_is_kernel_module(__u32 btf_id)
 
 static int do_dump(int argc, char **argv)
 {
-	bool dump_c = false, sort_dump_c = true;
+	bool dump_c = false, sort_dump_c = true, dump_meta = false;
 	struct btf *btf = NULL, *base = NULL;
 	__u32 root_type_ids[MAX_ROOT_IDS];
 	bool have_id_filtering;
@@ -990,10 +1074,12 @@ static int do_dump(int argc, char **argv)
 			}
 			if (strcmp(*argv, "c") == 0) {
 				dump_c = true;
+			} else if (is_prefix(*argv, "meta")) {
+				dump_meta = true;
 			} else if (strcmp(*argv, "raw") == 0) {
 				dump_c = false;
 			} else {
-				p_err("unrecognized format specifier: '%s', possible values: raw, c",
+				p_err("unrecognized format specifier: '%s', possible values: raw, c, meta",
 				      *argv);
 				err = -EINVAL;
 				goto done;
@@ -1072,6 +1158,8 @@ static int do_dump(int argc, char **argv)
 			goto done;
 		}
 		err = dump_btf_c(btf, root_type_ids, root_type_cnt, sort_dump_c);
+	} else if (dump_meta) {
+		err = dump_btf_meta(btf);
 	} else {
 		err = dump_btf_raw(btf, root_type_ids, root_type_cnt);
 	}
@@ -1446,7 +1534,7 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s help\n"
 		"\n"
 		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"
-		"       FORMAT  := { raw | c [unsorted] }\n"
+		"       FORMAT  := { raw | c [unsorted] | meta }\n"
 		"       " HELP_SPEC_MAP "\n"
 		"       " HELP_SPEC_PROGRAM "\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
-- 
2.39.3

