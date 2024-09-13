Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D369E63C;
	Fri, 13 Sep 2024 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247232; cv=fail; b=RC5h9pFrZ1x8fQG+oEYJuUZMSgF00le9sB7JaWLojN4z+FV59jNTynqN69oIiM3JztoE12y/MkPLLlYwTP/fsBQveOWUsF/b+75JMwSqu5ixvfzatBGG1bGv+LfewJBOemtpb+KpLdLjJetDjgdtQSczmNBESQomHT9hypf2Dv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247232; c=relaxed/simple;
	bh=9Y5AipIGF0USsjtvBh/wJFJS5O7QG0apA6NQE1FZaB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=RSYi5QSBwO04dP12dfpnwI7e/MXcqOn3xiNTnSSlXlK/6JowUxEHCOapi0Q4X84VHhp6i77PXLZMNnJTrlvqXJG+Etlzaj4NO3OlNjMYGWe1DpT5UsF065N4GAAwL4kd2OBPwLH1zKqbyuIBPwkoWXamHaJG6DFBlH+Ey5iWSak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e8BxJ85Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=utbgUiPm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e8BxJ85Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="utbgUiPm"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DGo5LE020212;
	Fri, 13 Sep 2024 17:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=FOoBSUHneXjS7/
	Rv2RriGZ+TqkTm6Ka9lD4RSitaVXk=; b=e8BxJ85Qfkhppdco3uD1lDvyKPLDA/
	SHe//KFnkoL9xmeLW3VNEHAgeb2XaCeVcCFrT1XDxU7BZAnZTha270M1QdhEzc2d
	wGwDM56xSXmXNIVPxavolsIHhKFxYmYfonMT2Jdt8X1xVaJILtzEpm8Bp7FlvyGz
	fi572F4ou1KziLevOVbu3M4QTverBABHDAsXZ8uKRaJAwQVjZZvURRMcoj627X7m
	y2azmAYvixK/qU2KS+WnIPV3BWODu33aWKWg8Gfl5E1XdKjtgCN3+1eRr2sNeuHR
	VyviwUs4KI8H0Ni1ku+9gd72ikWY/DWdm3yY+tidmZK3oPIB+JAfRTEw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gevcx7tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 17:07:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DFb5Pg031587;
	Fri, 13 Sep 2024 17:07:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9dcx1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 17:07:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZDvKB/MJL10Bah8eQSm0Uh2NUOiIySsWnKTLtiQedbPyJBYQep/fWpCOsg0HOjnjJDUzvdMPvYsR3wxYWKbUrk3mGkRJ6zOemPj2i9b1XiuiEDw2LI4CYOgTt/7GKGWubr/1aBVbGt9g9DH8fKrrBsh6WIwIaVfYgt3nvnb81Ts8Hp5P27vWWy7JZf1+RMcyHYf8kNAcXWSni77Nw0cI1i6g7zkTTAP89pe3Qj06W8t0KyDLRXhxjSgtBwlX40CQiYIBY8joyQKFva6iPFatLB2Vd5SWQwzYqPs+MR4eGoV7E5LDKTYqYBMiJ2gpIxxG3FPi0tMHhVgr6CaDQNXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOoBSUHneXjS7/Rv2RriGZ+TqkTm6Ka9lD4RSitaVXk=;
 b=BPYEr/BJysSWVfNOuRyn581iBbZf5PNojv9VoZjq4aGnPcpFlZD4QPSIhTVtxFB4F78rWesS9ZqyWp28Cm7WFwSRik2MTCqeUxtwk5RcNG2j2AxoiMHqHVBWspj03rpN/dQcTFwP/PzgvJ1LGqM7WNtHSJRgWTjErJl4+GdR0QDK/kQbPek1F14+f5ivujSV7Axm6tXLkei99fS61lM+J/zix7sxoAb7fTGZMPHvYW9NSLAjmM+FJ+WvzW0SGTWeehRf7k8P6EyrDmpWFzt9wUVt5daMzaAv/sykHAsqD4RXVEtdG68TWDvn6mNCtJDa7ZUnLO2sShjipxMJ+vPFnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOoBSUHneXjS7/Rv2RriGZ+TqkTm6Ka9lD4RSitaVXk=;
 b=utbgUiPmLhZb1AILkt/7prFZZJdVwhRsiHdYvn2jbme0JcWSJ5UcvpD0O2jeCiuL8mIgk8aDmobWCmcDtQmMy9/6H3f7WlIuXBXohhdTHcCIbXZiYyf5tpoLvR3aWlS+r29+aGHwYO/oWgVA6/GsTe+OSBkToHVMqUVObA8/Yec=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by IA1PR10MB6784.namprd10.prod.outlook.com (2603:10b6:208:428::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 17:06:57 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7982.008; Fri, 13 Sep 2024
 17:06:56 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org
Subject: Re: [PATCH dwarves 1/4] dutil: return ELF section name when looked
 up by index
In-Reply-To: <004e691b-440d-4594-bdd8-cfc0cae90e2b@oracle.com>
References: <20240912190827.230176-1-stephen.s.brennan@oracle.com>
 <20240912190827.230176-2-stephen.s.brennan@oracle.com>
 <004e691b-440d-4594-bdd8-cfc0cae90e2b@oracle.com>
Date: Fri, 13 Sep 2024 10:06:55 -0700
Message-ID: <87ttejmqj4.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::25) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|IA1PR10MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2a5c35-62ea-4092-24fe-08dcd416790e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KQc5w1zPu4r7CFu2gQlqPLcp6uLsCq/KfULLVAyPvV1Y3RdG8v59n8AZlmFk?=
 =?us-ascii?Q?cc1/MWqNKVmqlNwutUCKWgtr/8jkP4bgfOdjgv9ad+EA+J9Twx0jSxvDXzsW?=
 =?us-ascii?Q?BLgpNh8fhyCUrtGN4yCir+aQ/ROTejdVR2VT6GPrwU4/z7/ewXe46Nyadvt+?=
 =?us-ascii?Q?E4W6mQ3JsDMfYRXindaXTV91yu8w0NBFxkD69hxcR6Tz5aZqKXwjJEJtWGAR?=
 =?us-ascii?Q?lGT2tRXX4QDwy8ulHHPDGEF2AO2ERiezke+lxm+KIr0p/dgW83lWQKABC9+m?=
 =?us-ascii?Q?VQ6elGTu0nkVMyRln6yATIS2F0nQrx4giqXF98Fal2Fu/wkfBV5mE74ru0KW?=
 =?us-ascii?Q?Q3AdduzrH4gIOFted3yiepOQqYdc1Li7SpKAigHRo/wpOU7IC9xYiUJkPKcs?=
 =?us-ascii?Q?z4+3RYvVW78usRCE+GclPKauIINHU8Qr87iBP/XY2rssCMLCRBig65Tj0kSp?=
 =?us-ascii?Q?WyeoSk0YZ9K1ajD4+0jPnNjqzdP/+ggceYiGOzb4lK4BEAEMmUwZAhIQw2zC?=
 =?us-ascii?Q?uJvMhZRuJtsOzX05gNRoeNlbQ60VSd4yoSqVB+c3kqIkpPpNf/Yd2wbS4Dck?=
 =?us-ascii?Q?Bm+ZhcVR5duwVkiQ6H9ahi92tYt12p8t06KOJBtVBK4lNLPue8ka8fOyhzMh?=
 =?us-ascii?Q?oL4n+0LKnreZmwo7A3HkginR4HroojeKvKp8ar9lzDKV8wwokG8wBouEUho3?=
 =?us-ascii?Q?aFuWy1y8tJCpmCtaU+IPOXd33c7Vz0FmRrjuYbQfhovhlB+NJ6ZY+R2X0P9X?=
 =?us-ascii?Q?Y3TR+MoirU3z/Co8cLjg1SosoQ8vzfZws6u5q7R7kxSjfxdKSvihNxCNr4Om?=
 =?us-ascii?Q?Zgm60P9LTFlYPu8y8VSVIKiQ55alufhCk3Ev1SKRy06PKd8xDOWqinnzIQA+?=
 =?us-ascii?Q?UKzypN8xgf49t6YG+6enoVFxDHsLWOFU6+DArdcssMxAwHvVbAkF4xXeyF3x?=
 =?us-ascii?Q?Oh0blIKNiGynrVfp1mA/xp7d5AlwFDMxbL4BLLgyn68OPgT44hID4dLZ5e5A?=
 =?us-ascii?Q?wg2vcsYtPHUZmnUN8RvZTH5dXGSB+8jMfQJYebSYriuhq9vbJvQ/cKC86Ke0?=
 =?us-ascii?Q?cslA2s2nGwyUANealRasiJIoBJ3qxUqQBesuz3o4gSsf/4XNXD69f8bl2Vv1?=
 =?us-ascii?Q?sxEcOYZxlPIgczSyjKHCzpGsXnSt4zf31reTHh/dFSQsEKiFES/ML+oFVjvA?=
 =?us-ascii?Q?H66aOw0T77FMiN2LUOrKAjFkw5etWDzjxkQZlEHuCOlNgkUSTuTk2t3hECZY?=
 =?us-ascii?Q?GOEsHNJxmxvl0UroMkpuKI8X9uo+b+GbrIGan07sHnlTH8HdFzojfEwfes1n?=
 =?us-ascii?Q?NPCa6g3dSjSBU39cCEtD/+cgLB3Ty+wQT4U0BKX45XUP0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FFWBsZktdu1XoZNYHOjfwyjwoPN1Dlv8H8mJHuaZTVA55rSVnCjqerLi8jQ7?=
 =?us-ascii?Q?8tRZeb2PeTX4XvKaIGmxcnHfdkkn1vPtFdoaqxlvm4NgON409foL258p6oEl?=
 =?us-ascii?Q?5gevUHEyxoJDMnUAagtLBUQT6/IHtsO4dnSZ07AjXAXGPuh2dTbCF2NOHpWq?=
 =?us-ascii?Q?NA4Z76dFJQS7V6/X69vIxHIWfCHQ1IPk3fzZtjZKD5CeRjek4oQAnQCbcTRH?=
 =?us-ascii?Q?9GAq7u/eSJ48+JT3fJm97efuf/XM5fbfZozPJ+NGkfFBOHkFKs07xwyFDwr7?=
 =?us-ascii?Q?V1g5jU7j1DHO5wkS2NUsGpxcaRvxwdVCDE4YzMRCKK8C5/Zf1drfz8sr45HA?=
 =?us-ascii?Q?OVZaxoQfqtjNrrZpyiJdEL9JWN6CuWQgK/r/EzAMMIKPJ3OPEJC/ayGp+X+q?=
 =?us-ascii?Q?3AFy9G1EZ7I3uQDs/zQSiVeKBudy28itUK6ul8GMKGnnSKP9WbxcU8nT4t+i?=
 =?us-ascii?Q?je5FrV94Pt3PRqfiPQHvCKkSaOP4t3j6eTo0nRpYFdHUy5pVaIx61XiYGQA7?=
 =?us-ascii?Q?2t35j1Z5euowL6sjBsxrtvPseBfmqPaDQQe9VHkHaiHXuforf6d5qn69NBv0?=
 =?us-ascii?Q?3G9uUdiBPHkQDVEPR/9VvGJ1HfQbuQwMP8U3HdNzlKswvlEXX1p0gqy1DhdF?=
 =?us-ascii?Q?5IL3yQj7Iaqj5/jLhLkk6BzOdsayJuAmdI/wTIPpqWxkCRQpNHZK/1vBWkNJ?=
 =?us-ascii?Q?PdgT/3dki8gieunFIpgr00Hz8h4oan0qkiufLpeCPoMBaUV2v4JNkbVxyeqM?=
 =?us-ascii?Q?kPIRuOiR4BX335mlQiTADfLjNFrk2CQnnZOrqUzK+tEOstPb1h/MEdhYEsW4?=
 =?us-ascii?Q?vMan4Gq3YNZ9ohrh/kAMQb1SQsZPPQ590vHIKUKQQDguLGUI6yY7OHszG+hg?=
 =?us-ascii?Q?K3IzX4WAu9mq5a0vOF+LWQ2OiQaoXFutb6X3Sc8ejiWtJkSg29CzwkoRMTPy?=
 =?us-ascii?Q?BYnOMdbJIBkmLLsNY3Tg0SUFYWyWWnq/HByGXgoXbehgZLj/uygctX0/23Sm?=
 =?us-ascii?Q?0u4Cl5Mn1Q26Wm1gP2wVAPQ/W8e0QdvrOyw3hF5cFmIiQhN3aVn7tMSEWZJE?=
 =?us-ascii?Q?DQVeWkPcfyhiiDvgzKndTlQUivhMWXUeat1+hh6V1IJOVsO7T6duUzhbfGwK?=
 =?us-ascii?Q?+MQ+/Nox3qWqD7h2vhIYIF719hA7ZoOLtGNpjQGdi37qiTfNzwHlVGGHgm1n?=
 =?us-ascii?Q?3Uy0muaOeXCI993fu4wxkYsd+ZyD5OVIgXp64dAynpGJSHbhCpQt+Ngj2fT6?=
 =?us-ascii?Q?WzgikugR+jdkh2Le7TOTdWyaGfQLBzYLFzKhUxHLkWZnpa5d/q7IlhdfHWyq?=
 =?us-ascii?Q?mCH0FGPMFpPT30No1qw6Fm+jWrC2o1UaWp2/7e5Vzz8aUczyIg4bGsr8P5fX?=
 =?us-ascii?Q?8JJXtwcwh41IkK10Zi1enLHe7iNBc9x3A27Yr8tUmEkX4QpkCAKO0772N/Uk?=
 =?us-ascii?Q?iwHthJ2m426qEgHi3x83RGG6MfbCd9eHnRQQ5VLPENi7/ftq1Otj0DsHSirg?=
 =?us-ascii?Q?SN5IPL1xHv19EM1mrDKQicUGGCSjMzh0XiK60Qrhf00DDgAn89/mQP1WzTuJ?=
 =?us-ascii?Q?U/wWakVUf2FA7/WNKvz4iFAF7M91/nsF03LjFSyy5garTPeTxgtft8tEcU9C?=
 =?us-ascii?Q?QTRo8aOErquFHpmLgbAXYadQQBvL1aLCRufMWjUZb6EKAcHbJaQsHIMXFanF?=
 =?us-ascii?Q?AZBVQw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ol4mM4A5IWZ9vPp13GWwP1FDUNI2zzKi2lCEC/f7gQHAmZznEncsjs3YhRL+3zPA6ABlhR1mzSyooZDa5S9aQzOSoNArmRr8JcZ/BOsIBUqBLfdlpvkBmGLF91vcVod52J4X51GsQ0M9nbeVH9lR0aMrTpr30/apHi6UMO060XIRZjwspGyRQRfRvdyUdOms3rNbnxUAr+MJEStUrdY4GXbJbTcNikefF8+8SsoeBIndEIRCpQGraa1jZtkgVWh8oLvEC3bW1L+UhFczyop2nTB2LgT3YcIBd0SmDdzdpOWe4s64f9rLP16vg7EtmZQfAeI4ZDvrviYF4o5aq5904R2xDt49zwKvOoMb3D4cG4CL5OGQ16AWRdKndjB9eZVWnttkWKuNncg9hu05qia7cpZ/+RF1zP3m/TRCVY0662+EbI/oL3mHWI/h/+qj1SGj96U0zZUhi4YSsy6iXUUBqPLbifSAoDmX4Vhl+oek45/7D3oqiQ+2XQtzcVl2VFJW2pGlu/xQ2BOpmEZmZttNpNtZ0kf6lOjqEE950uCVEs7SXbftS2sOrBDxdm8Pz9BSlUhRuOu4mjUAqnAmMqw7cOTO8FoHPuiaxdIRLqmK4Lk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2a5c35-62ea-4092-24fe-08dcd416790e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 17:06:56.6342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIeNHC9kNdkC8+p5Z19ppHqZw5Pb29GXv2/lw2p+MJAFvtOp0Cig2vUpDFEhDzPrEAIMrdEhXh4y/gmDfrTR128MMT/xuf7IET9WA+D3NAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6784
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409130121
X-Proofpoint-ORIG-GUID: ZRZHakLtZpm8cj8wobj9pEv5aQFe3Utj
X-Proofpoint-GUID: ZRZHakLtZpm8cj8wobj9pEv5aQFe3Utj

Alan Maguire <alan.maguire@oracle.com> writes:

> On 12/09/2024 20:08, Stephen Brennan wrote:
>
> nit; needs a commit message, e.g. ELF section names will be used in
> DATASEC encoding; as well as getting the section, optionally retrieve
> the name.
>
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>
> I think one small thing needs fixing below, but
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  dutil.c | 9 ++++++++-
>>  dutil.h | 2 +-
>>  2 files changed, 9 insertions(+), 2 deletions(-)
>> 
>> diff --git a/dutil.c b/dutil.c
>> index 97c4474..4e83d59 100644
>> --- a/dutil.c
>> +++ b/dutil.c
>> @@ -207,13 +207,20 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Shdr *shp, const char *name, size_t
>>  	return sec;
>>  }
>>  
>> -Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx)
>> +Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx, const char **name_out)
>>  {
>>  	Elf_Scn *sec;
>> +	size_t str_idx;
>>  
>>  	sec = elf_getscn(elf, idx);
>>  	if (sec)
>>  		gelf_getshdr(sec, shp);
>> +
>> +	if (name_out) {
>
> nit; before we were directly returning sec, so if it was NULL that was
> for the caller to deal with; now though we're driving on assuming it was
> non-NULL here. So I'd suggest changing the above to be something like
>
> 	sec = elf_getscn(elf, idx);
> 	if (!sec)
> 		return NULL;
> 	if (!gelf_getshhdr(sec, shp))
> 		return NULL;
> 	if (name_out) {
>

D'oh! You're exactly right. Thanks!

>> +		if (elf_getshdrstrndx(elf, &str_idx))
>> +			return NULL;
>> +		*name_out = elf_strptr(elf, str_idx, shp->sh_name);
>> +	}
>>  	return sec;
>>  }
>>  
>> diff --git a/dutil.h b/dutil.h
>> index 335a17c..ff78aa6 100644
>> --- a/dutil.h
>> +++ b/dutil.h
>> @@ -328,7 +328,7 @@ void *zalloc(const size_t size);
>>  
>>  Elf_Scn *elf_section_by_name(Elf *elf, GElf_Shdr *shp, const char *name, size_t *index);
>>  
>> -Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx);
>> +Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx, const char **name_out);
>>  
>>  #ifndef SHT_GNU_ATTRIBUTES
>>  /* Just a way to check if we're using an old elfutils version */
