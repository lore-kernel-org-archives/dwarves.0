Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795381624;
	b=rEEyLQ2a811TwFOpTtsKk8nW87oMsZ44wjbLFQ9JE1VLk6b2UNb1beYsgWDcX235+vP5
	 SYDZ6IvnsaZivrI1ZrkVsS+f19mifPMLvJrh/CqPUO6aFK6Rw7oGibgl+QX/SmVXcDSkp
	 f7MRovP85rqFBW29IBFJj1ZIutOCZqZl7HTyljggrUVa0yzLkb7M8uUskrGfobMwY5wTU
	 CeRMqJll/yFncTzbpKfoK4e2v3xjqWV8hExQmch1rpHLHkEHeZHNlgoxz55S6fAbYG2hI
	 2qRf9oH9ifhPsWgkVMGoG91bx2MswoftfdD00vzSo3RlGcV28BK7kfr3vQHV9+IFqCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795381624;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cDNSMIAGGrIyWYfZGmuyvN/hS0mdCJmGKMSgafgjFrI=;
	b=fjaf7x8WcNTwMvjUt+cT3Z29+xycJ6hWRQCnycMuLC1G5+qP4V0XsQ6RDp4gIcNM2+/p
	 oVhmHToTS4MwGiA4ntEN8A+Nszmq94JwIA6yZ8Qso4AHz0b9XvAkk4FDwaxNZrkArGG+n
	 VhHlfpVAD7JkjFgEcThMz5sI9GEGQwRAWg7vKvLh/RKcmZbe3pvJsHLUtkKFhOPLo8TCi
	 6cq3WOtWXMHKXm3qfbq8y8szeivMg/rN4E2nFH1CmZdl7+u8x+59POh2Y47GOah5qkUpP
	 Vaumt1Ct89vQU7ofYw4ze7SNom5cmClfZBB+liDH/dHP3B5eNhl8MEO21ei/fZCtoHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mGKex5XL;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ABB606A31D;
	Sun, 22 Nov 2026 21:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9ABB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mGKex5XL
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AMKZ3YK1515474;
	Sun, 22 Nov 2026 21:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cDNSMIAGGrIyWYfZGmuyvN/hS0mdCJmGKMSgafgjF
	rI=; b=mGKex5XLkkeaauZqeBAHiyGMWRDAWe4lWcdB7recPJ27WgxgMlgU6GWvG
	GUPJOCEbTFZBVU1CudTEqrILpKKfi7RW4JDBW32PcZUK08vbJf5UB+YkfvxusYqB
	zp0WQZOuJ/8KjZcfSF1LRVrYvyOqSaK3tgs1P7Snp4vvsJXW3tvjL44sqpxv/c0R
	cG0yfUNbcjyi3G0KrQbSzKeHhbptiO7YS0XB9K0PmRayAH8CMcfav5rxYLkZDM4i
	2ixg6m12skvNJ/rng/34YH5jbYgHbHLmGfZaL4LXHiW+uMK9VxoHyAXCfdpWNdO0
	Sg5NlZgIOa/6mGhWH9qvZr74XWTJg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gv043a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 21:06:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AMKJJlV1924101;
	Sun, 22 Nov 2026 21:06:39 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4h41g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 21:06:39 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AML6dIr22348456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Nov 2026 21:06:39 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A48258062;
	Sun, 22 Nov 2026 21:06:39 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 140B25805A;
	Sun, 22 Nov 2026 21:06:37 +0000 (GMT)
Received: from thinkpad-p1.fritz.box (unknown [9.111.52.78])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 22 Nov 2026 21:06:36 +0000 (GMT)
From: Maxim Khmelevskii <max@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH dwarves v1 0/2] Support in-memory return values for s390
Date: Sun, 22 Nov 2026 22:06:18 +0100
Message-ID: <20261122210636.2896891-4-max@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Post: <mailto:dwarves@vger.kernel.org>
List-Help: <mailto:dwarves+help@vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dwarves+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b035960 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Ld0tnAMJVGhTLNDUD6kA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDA4NCBTYWx0ZWRfX2w7wR9jmQHeX
 LqUh6hID4HkUSmkccgb/U+xoG+kWz/sr8A4Ax+ACwcRQ7PTTFyXemQ3owM4LyoonPOg3H6Rw/xw
 F+lRprUxM2xzE7w+uKHIgDLPFFhun88=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDA4NCBTYWx0ZWRfX4uUJS1DAWR9y
 S+2JF38affWKLv+vIAPS1O/wZNXZemR9ki0WkYHz76WojhRBID2uJQN+i/+de5LchP4AfKPnF5L
 uuTgInOl9YIcPWym874osNE1mSwDhH1+Wjbe2LRrPaiIuVSbtmkM72aD6PDZNYSkf/cGffOCl/T
 QXJcEVu5+fLkYNGWKmG6x5QwKk8qqzOyMKMuelHqzt3oUydXoxqk56WgArpYPKi64Z9XOH3XjMz
 HZu3ZmCO12w5/4xfWpY98LDC1IxXWEhdBi1PgT76J08orI+uVlUJ8xL28b27mDLOTVqpOU0rnMU
 jyFor9IBqBr8lJa5LiAbSF1lufePAfvDZOk1+uNacK6UG65QAwOTHxE4B9Q6NQ128LuI0uoXGgb
 sIx0UnhMGwf8rNK7rxTCf32sXxSyyQcVJdq4HnntFgdIGcJI5QfiMgS/8dUUWDtQ3n5ib7I8Uvp
 5ThqhPhQNC9jCwBZBCA==
X-Proofpoint-ORIG-GUID: _C7eP2tGnYjF92f9QUGR1W7l39fEqARd
X-Proofpoint-GUID: _C7eP2tGnYjF92f9QUGR1W7l39fEqARd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_05,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611220084

The s390 ABI returns any aggregate and scalars larger than 8 bytes, such
as __int128, in a return value buffer allocated by the caller.
This buffer's address is treated like a "hidden argument" and passed
by the caller in %r2. The function's first parameter is passed in %r3.

Without this change pahole skips such functions and with "--verbose"
prints a message like this:

<function> : skipping BTF encoding of function due to unexpected register usage for parameter

Set the first parameter register index (reg_idx) to the proper value.
Move function's return type resolution before parameters
are analyzed, because the analysis depends on the return type.

Although param_loc_supported is not set for s390, calculate
the reg_idx in function__match_clang_parameter_locations in case
the flag is enabled in the future.

Add test for in-memory return values.

The change affects only s390.

Maxim Khmelevskii (2):
  dwarf_loader: Support in-memory return values for s390
  tests: Add test for in-memory return values

 dwarf_loader.c         |  84 +++++++++++++++++++++++-------
 dwarves.h              |   1 +
 tests/ret_in_memory.sh | 113 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+), 18 deletions(-)
 create mode 100755 tests/ret_in_memory.sh

-- 
2.56.0

