Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7556F1C172D;
	Thu, 12 Sep 2024 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168123; cv=fail; b=GNT2vkwkTmlP/0ZNw88OIHUxETgI8XU7BVK00uixv5k7qzX3Vh2CixFcZJ/OvC53dUOm5WsVzBPrp/FMnMyVjYaS9lelXV+uoyX6XLonWUsCNUnBuV3RewHoes8Y/mSKAV1OsvZCNGqL4TL/NF0ztFkge433wlML/xfeRpGMIdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168123; c=relaxed/simple;
	bh=/XFBFb6iCta68lNLQWGPLJu3TgTRBqgyGckHhMP/C98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EnzBZq/EFJHQDYC9k0UX5PxdsKTh/J+BIgm2C8m/vZ1nII8VIv+AuMTVeTLMC7+Cf8uSUJcYkbJ+Fg4BsZCEhGNK06L288ZDQlNrQ035qcGHLhJcqDMfxG9EsH7nroA9KD9teuv0S/Ejw5CuAyKSAK4uUUWNNJ3XafKi92msDw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KgzXlQeQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yvytOkan; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KgzXlQeQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yvytOkan"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CIfXft024332;
	Thu, 12 Sep 2024 19:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=FLZOzXlupacxSUtr/Q1FAGn2eNl8XNf4sntMflNWJdY=; b=
	KgzXlQeQkny+UBCC9lTmZgRm1LTEiZXuvTP0rT0WTag08HGu+1JFDCfgmFNQdfQK
	T9GSUuN8wuwAUy+ofjlZZo5By11W7OnbQ9JZxmmVUvIL7Qyorx8VYuR7Lbqsf52z
	3DiQf3ikt77M1u/5UwUtUah7nmiefcq8fWTr93BHo5rz8+jLXp0ejdcshR7uy8jV
	hx+vnTugELxBvDbMP2npRv+OZgXPNphf4ZFAcv5G+sKC9WXnK2uD8Dv1mlQ/c86j
	Vg/qMX3hSOOb3H9wgvRn8LEFm4h+JqEMUa5rV4dLpgCJ+m9QBzCgu0dPXFCEqzLv
	gvAI2JR06XdPpSowVKtaYw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdm2usj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 19:08:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48CIC8KL032414;
	Thu, 12 Sep 2024 19:08:36 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9j1gpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 19:08:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giIK7tZHj9XasWx5EUYRAiqdKx/gsAG0ByA63LSBxIciqTNyj10xnF4GwceDtNy3mInyWY2Sb+pgB9/AQr+KrVLaRITQpmuHE3NHxCe/CYUN+2pRtt3JnqPBQ7WPRgH8Ssg4+wzXVfH1ZL7OSF8nimW65Qys6kX0gVwcuYbWfEx6Sekk3MCsYBEaC49VfAUioM31XtoBsuoB4+iw+AywHpXYFMmxs8Zz1pVQDpkw0XnNTchop1iobmUor6IqMqtRIBJUoW02v4iwUYR7uueACWppNM3iqqFD5ua7v1Xcu2EkK2FijCC8anKYgQIp8xYd+r3YjkfJR9p8wVjKAz7X4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLZOzXlupacxSUtr/Q1FAGn2eNl8XNf4sntMflNWJdY=;
 b=FzBPTk8fze1kOCIlL3SoLrlDbaM7sRripaKX30Rpth50nT6V6ympBvir0gxcyjtQAklvtPFk2nEEycsQjon7aWHgeIpFyXvqOZsaebHnpJuGTnL3pkWDBqMsQkXzuNhe0A94DPp707erSteDRYNk+apZ0E8XGOiU8j8S2nkMSRKXgAVxHDI2T+Ua6edkeZMm6D53c3EsV8PdrP7zeBP5Ech7oqvtnC4QflZ0hm2sfoNUPGCn6FSQeMin5EcCGeF8oRyBNRlvuMf36q/P7dD0tLpISgFO7i4++Kp4LWExIlE0NyJVgZZ/Htxx47Ns0tK/M1zdgW1J+BitDV5/vy9Bsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLZOzXlupacxSUtr/Q1FAGn2eNl8XNf4sntMflNWJdY=;
 b=yvytOkanA5Zp6e7RPuXkInYwaAHmgAym7W/3WdufmesHZPKgw1g2xHYzo9sJF7BHLieiLiVVigrznxKFYflaxaD0dTfAzG3RR7dSzl/xs8uHWBracfsE+Cp3dksD8MaG6Znn6LXTooLSQ4SubqfmK4/DtTkID0Dw8XZXOTMeBZU=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by LV8PR10MB7992.namprd10.prod.outlook.com (2603:10b6:408:1fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Thu, 12 Sep
 2024 19:08:33 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7939.007; Thu, 12 Sep 2024
 19:08:32 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 1/4] dutil: return ELF section name when looked up by index
Date: Thu, 12 Sep 2024 12:08:20 -0700
Message-ID: <20240912190827.230176-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240912190827.230176-1-stephen.s.brennan@oracle.com>
References: <20240912190827.230176-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0429.namprd03.prod.outlook.com
 (2603:10b6:408:113::14) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|LV8PR10MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ed31d2-42ae-43bc-3b25-08dcd35e4b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+j7lz8Py3DTZTnDg0aLrvpNaQj9fe3S8jh/Um7eyzat/RaRLj/f8ZLFit9c6?=
 =?us-ascii?Q?eqB/7BjSMFrhpQkz/2R8LegJ11tRZQEOD7p4JTRjmpb40wEt+NbbdX9yxl2O?=
 =?us-ascii?Q?FQ5NBopws2VA5S+ewaxssZXj3k4n8TV/gvYEJ7v+j9xWhn1Uxayl2Q8pC2Td?=
 =?us-ascii?Q?90gV+teA/l/dATeaAHn4CP6eFby8uqtBx0vmJh5ZexOpKgeVWy8kZSwN2LKg?=
 =?us-ascii?Q?fhdKdPz0M7seGdLXY6z7enlmmFL2L85JkR1zyLKtBNAHfP+KzGJz6ys1KGIB?=
 =?us-ascii?Q?+gWo/O18kWFQ4OBr3Sr3wZcW1WOVxjqOwqO8NRKpQT+XxtINy+p31iVmjwyx?=
 =?us-ascii?Q?i+ajDXVgqo/VvD+XDiT/BhDc7OmP8XaBQpBvShdvlOml4422bDauQtuvq+BP?=
 =?us-ascii?Q?qCuRLcj3sLyaz9OweW3b8WhZcc7uScEC/oJ1n1Ez/XNZ+yvKxy0MSQf6PAMw?=
 =?us-ascii?Q?CY6UMQVlVD41j/TVaDKG1IWPcK5Dx9+Y3aMWojN6l9OdL/ZneGio9KyG0bqI?=
 =?us-ascii?Q?5LGXJTEAgO/OeTbTRNefEOKaKYr/OgVmMRGqvIIqAjtfjqDt8T6nxZceSnL2?=
 =?us-ascii?Q?KEJHpbiuL+ex3gLOcBc0d34aTwRTtzUFTMowxJxypjwHX0zg3ttR5G3KDrbL?=
 =?us-ascii?Q?rZUGm2QWS6H3aBu+UKXgChsvGz9j+/7ij65NvEJsV63OEoV1LVrF8ZBVNHaL?=
 =?us-ascii?Q?slza2K4CU/KP7Y+QojgU+VIpmDgKC7rvidWuY/qXUUnjLzAi8iQ4FWKSTAmq?=
 =?us-ascii?Q?x1LP6zQ1y/oZh4WPFoqR/Xc85tXV84PnMGuejJsQLE/w2amj9ZoosnZbKJxY?=
 =?us-ascii?Q?BMNIgrptPWsnQhXXHBhfVSQfr5JUIiSQFncy0P3pn097lBJETbXvT7nmdY7h?=
 =?us-ascii?Q?kP1NaVSXTjRwJnRghZrMlaQDN95t03ub12Jy060V3vPYUWvb179MUiR+VHpU?=
 =?us-ascii?Q?gNJ8BGETx8u51YnNMqOGwq50Dpo2zIlXvBdcnJfzZF+2BGQq3Z0bm+a8aeri?=
 =?us-ascii?Q?nm8LEMUi2rxoNLWutpglHKNHwJmrYtBd7GC5w6TIY2VcHIPA7ED00sFe1kEP?=
 =?us-ascii?Q?vWeVgos/AnN2mq0BmVP0u9NjFbDb/+hleLSkEE7FqnTUm0LVhNpqnqR7H6kW?=
 =?us-ascii?Q?s3n/FA7qGLRkTe9oBwpSDz14nWjUAmmD6Exoj5ejFP6Aq1ZEYkr41kJ4Tqhm?=
 =?us-ascii?Q?7IifwQgeexlKZmZUX7p/6s4FuS3BdFA+1ZregEV3Ru4oxmKfFoOytagtRcMt?=
 =?us-ascii?Q?x/NGqC6pAgi5YwVVYx/ODWcJloK115/wYBLjtLnFOq/6bYClTpQGw3mx+DrB?=
 =?us-ascii?Q?e2Dc5g+ohoHhPbrJolVUDBcn+nm7GxOxcosqrJ7v1VYBaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pwTG+eEfaWMbvKzYTmGhz9Q8wIC2w9lD0gmZHlnsCbMVmaN4CgYNSZzgfqor?=
 =?us-ascii?Q?6JVU7b+CLurzJy7GI4bUjZGkIgMq8Ll4xjtUc/c7nb4WEmjFgfYSrDbkRTWF?=
 =?us-ascii?Q?3VnhVngC0vt+LATF+beWhwJBziNMRSo0+p8XZoT0jMAzcv2i0itgFt8HR2ZR?=
 =?us-ascii?Q?55LrFmMYEQuVG7vggmoYwZXm/y177krKmmAWT6whr9A/oaTFjEmK9xCOI405?=
 =?us-ascii?Q?LBh9Qox7PmEzVb1UlGF3RCV5cqJcWoYWiDmusvNPbf5vaOp8gpSdKKwOZd/P?=
 =?us-ascii?Q?qgL7SeiPkVtBXKIXmKFEvov+P+8GiTcZB3nMii0wKwgPfnbFMMb4kgF77jjD?=
 =?us-ascii?Q?R3W3mFRn2P9/9aepo09N31FVWj5KGewvk++fnv+cTMd3UItabEJdsjji7Jhm?=
 =?us-ascii?Q?dZUe+mU17qSAUMezgUoG+iKYe2p3C1Ai/LInWKo9iBdD5Zd4rheMZeRDpRDw?=
 =?us-ascii?Q?1EjhfnDL9e8xauQ17eFeZGB5ms1XA9AlFR06o1JbhZciUTPXFeL0zqRHsTnL?=
 =?us-ascii?Q?n3Jjc/PgL+v3rYu9v0O3JqelIM5fITiMCPghpbHa+6iDCjQeaWGsPXNwoo79?=
 =?us-ascii?Q?aTZoZENgBLwRJ549qwU4iqVJn4L7E0C26MYEqeLyYykRLyzSo0xe4qJgrITA?=
 =?us-ascii?Q?g396FU5fmgVvG80ChIUwS++dOz6XScEMCAIhUwxFt0ZDPmpJQAG7n3jbY6GG?=
 =?us-ascii?Q?LEc2H5TGT3Gb6/Tb5s3yC4tS5slxSBcM8GqLPYgMnRgOEEEMSeC6uUW/uwPP?=
 =?us-ascii?Q?fK2CE0tbQLJKiDc0VZm6i6vpPjm+/L6qLh0nyO4Xb0NSoaB+3MfD5BQya2lh?=
 =?us-ascii?Q?vjKhh54b4vNjEXJp0MhRwgJEjg7O6PYSxVApRs4FEuOWJuBdAj/MYqf4kcSK?=
 =?us-ascii?Q?hegeGKQqMKIM83/IUFGWZ9Xks0QD1R2tL3sBueZ0whLQDXBrJZprlC9gTnRl?=
 =?us-ascii?Q?gJjo/E2sz4ouAFqs8Mf66oHXZC7BQ4xlw6jQePvUVxrzQsifLP0luA5+zuEK?=
 =?us-ascii?Q?EtU1Wf83q0eX8HwuCX83BFbIg/HcpA5yH6TaCsicFSH5hSSjkK+FqVsDD4EN?=
 =?us-ascii?Q?EcQ9sLZmnvqk1p/H62DsQN82cLWZiU7sbx4VkL3ah1sjQgsJI5GW6b5P3Mw1?=
 =?us-ascii?Q?zGUCuMyOuP/C8s7A0M6d3Hq7s9A9I/mF4uK+eQ8wnm9w9VAU+mWXB8blGbtl?=
 =?us-ascii?Q?Gvsx6nTy57/ci3VWZE+zGZchLGYM41aJIHmdShuOJV1dC/i519HZ+LUURY9l?=
 =?us-ascii?Q?pnWZcrD5+ngGjkyNnrZz2TjIciYUYldURuTs2u3XCmuyqiihuBLKhl+3lmG2?=
 =?us-ascii?Q?a6PSUn+8MV2n0h9YgNU5oy39PkuDYq1LGMPeGV2at3WasL/3fchaxuOfVnUv?=
 =?us-ascii?Q?o65ElpE/uvNFG6OFugI6uqVBQuSQyJkbpODpfUdmrFivo7hPxZI1qkU5UTgg?=
 =?us-ascii?Q?bqk7LXeCYzlNwNfXw0LTgK1v/JwrCipNSeGWjIF9KLAu0lTfE6aOXXTxIoTp?=
 =?us-ascii?Q?sF+3w3ome4W0xLGoNhoY5uxrnNohK5FCDf7WsACV1Z5xtpUFBbxWIAq0HPeZ?=
 =?us-ascii?Q?NfY/ZKXRMspQjt5US3Mp3h5zKUVrt/8vd2rUfPjreeGtgIso6x3+C6ETYfTl?=
 =?us-ascii?Q?nHNnXVbP1CkQ38riCQdZaNg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MOSyxuQW5L0AVwZ54goxPbr94s0moHWY8wkGnj+RPfiyPecZKQYmEBbF3/+vMqzYR33z0/W/GxQmOT4zd2e+6TL6+zJLRZsn1Qpz5v8DzKhb+3HNh1/Fd0an7P1Ejj72Jxk9gNgOTjEVJE6GTYBVsKYBB3t4SmlSsg1UEitlv9PWngtCRoGJQWbIIxp2Jk30IG40BNlVD81jWGzEw5xVfT+AVcQ0qFSuNY2B+P1SQ3Dwttx3guwLO8df0QftZUQbujVK0bFZl727p6iZXB1d9/N9QNU0a1s3sfXdSx9FiGb+XTHgkwZ1GE8rYk1qopGDHuYm0slwyatfNBgHcOMl2MCw1KqYibdS/G8fnP1nAy/EbGRv5FalXRsZGND4AM0Mtls/UwZk3J7XfkxWnDp4HEbohWI4qs6RV91+8LDYqvnCaWELZU7O0GOQ2vCxJXYcNaH9glW8wUqzW+Yj4QvdVaAtYjwEcwFh6sEB6KkkbrfoX6PYmdF992zfZd/1sCqGiPWopOwjsInJg0lzCD9yqj74/NbKwo/Q4NLX89nXMhmBLFpOFj7fC+WQ/xB6510GMMy0wRlp2K+59yAi4o5jS0a9ze39I7dAbxhVsGX6Ulo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ed31d2-42ae-43bc-3b25-08dcd35e4b8c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:08:32.9152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vLfxdMfzh8iLET/JAXyS3KB9IgiCMJoA0BXX0ui5i6GaHN5ShraMAxIcHE+CTst3+p2cdM3If/k/fPx1Eh5jSyMMX/waw8uizHznZRT3oM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7992
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_07,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409120141
X-Proofpoint-GUID: 6FAw7CfPCcyheIfejXZwZ38c0ybll2_2
X-Proofpoint-ORIG-GUID: 6FAw7CfPCcyheIfejXZwZ38c0ybll2_2

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 dutil.c | 9 ++++++++-
 dutil.h | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/dutil.c b/dutil.c
index 97c4474..4e83d59 100644
--- a/dutil.c
+++ b/dutil.c
@@ -207,13 +207,20 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Shdr *shp, const char *name, size_t
 	return sec;
 }
 
-Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx)
+Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx, const char **name_out)
 {
 	Elf_Scn *sec;
+	size_t str_idx;
 
 	sec = elf_getscn(elf, idx);
 	if (sec)
 		gelf_getshdr(sec, shp);
+
+	if (name_out) {
+		if (elf_getshdrstrndx(elf, &str_idx))
+			return NULL;
+		*name_out = elf_strptr(elf, str_idx, shp->sh_name);
+	}
 	return sec;
 }
 
diff --git a/dutil.h b/dutil.h
index 335a17c..ff78aa6 100644
--- a/dutil.h
+++ b/dutil.h
@@ -328,7 +328,7 @@ void *zalloc(const size_t size);
 
 Elf_Scn *elf_section_by_name(Elf *elf, GElf_Shdr *shp, const char *name, size_t *index);
 
-Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx);
+Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx, const char **name_out);
 
 #ifndef SHT_GNU_ATTRIBUTES
 /* Just a way to check if we're using an old elfutils version */
-- 
2.43.5

