Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA848255F33
	for <dwarves@vger.kernel.org>; Mon,  9 Jun 2025 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749471774; cv=fail; b=ptLBJZ7yRxsJln99wmHJv4t7Vw2EWY+TimvYRNXhjxVozD70rghJQ/ESvuL1a+bdfIzj6oHF6REQ9lW60VWn8mVCKa6Dh+FXRrdoX5tZGSnM5FwZLN1Xp5vjJ3uJlWaMG2l+f6ho0ox+Yqh7lnBTph3Vu2kcUN/V5RtxwL7e4iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749471774; c=relaxed/simple;
	bh=AFk0GjnUhGNtP5Q7v4I1lGDyrCPCJlbpN9kDILwz9MM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 Content-Type:MIME-Version; b=KorsKNtaRwulH5tsvC6kp3DMZXr464bayvVb3QkurUNhtvjNztoiFmsoIeCpoZJT5ul4X6xo+RqWyta3dInfsLLYHdULi+IR80dx5wVFeqank8IuZu9/6txh16QojxV/24NtRb0fRairtyZgeILAZUd26R+CLt7nFYVrW4p8H8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BS1WQGNW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HoD39sjv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BS1WQGNW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HoD39sjv"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5593fsWD008085;
	Mon, 9 Jun 2025 12:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=97IsHqUYV/TX4Jf+ga
	sY7UfEcJu+mIQoV4rGadrKDjU=; b=BS1WQGNWstL+4JiBp+2ZUl4iVMBqzlJwCA
	5VcZZxDWX7iLGyxYTdpFSax2kBVBhEfPl3ZcQwmh/0TM+LI6hikCWTDRhWJ3n6jb
	3pinsYxxcLji4ilQRYiIng/b4BPLKs9EqUoFP0UzbRePA2UJuCGkn/uWGdRl4hAE
	B9n0Y7yN17ZSAd570B5DFoLkuSW/ukAaPOZh6se5FO0vOxjmK647DWonKHMD7IBx
	l8HYo0++SYOQu3ZhTS2TgLbLUS/UGQqXxGr2nf8EVjYWizJftJ0iZxqHCjEQwRkQ
	GNKt4gQFd2a++cKTH0ceb9aHrwonsxjbNIcKLCcrCkry7aKvlyog==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14a19t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 12:22:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 559BseKs020433;
	Mon, 9 Jun 2025 12:22:40 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11012011.outbound.protection.outlook.com [40.93.200.11])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvdmdds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 12:22:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKWQ6Ew0Q/hPMnQv6TFL2TjtY9AosvuWwv/XDevRInJWDxhPCvryn+ozEZYPN9Tlj1RJWtJgQ+cNJ0PxKqtHKgy04bfEkJh/uytiSIR2+m9JSl2k1jw9oujCuheVDSFxQRSAYzHRdEEkYvwGubVtt+bOCYMZ2iUuEH4IvPNyOfmYNENoU5ecF7W9Yaby4LG4rLmt1QSuTW2vLjo/q7pXGXq+gxzPdeogBKba5U2qINRaAkpSc/l0uxi7fmtwwsulvDZsmBUUx4vFakJU0KqKIyp8sQ9i0tayd+s+6yMs9TXmTcMVvgRy+NZthxiAW3cF3BRJDuQ0gTbculBcFSafJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97IsHqUYV/TX4Jf+gasY7UfEcJu+mIQoV4rGadrKDjU=;
 b=APUEVc1vEr4sW63Z0LTW67En+tXInWU4rNiL7WaWl2yyixRnBxtwZW2nJBxPW6KWDcBAl9c9jK5od0+WCAEaY7eFa5+TXpziZFP1l6IhS3viB/D3txB7n23PUX6vshbtVI6X+rbFxe1sytczS0DuCdoAtwHcdfRmFwYbkZZfS8JEqpPA6zqM//u5t89jYlrnRXHmBmVE2FjC0vDHmd1RLyMW2zgYLeKCFhBFIbnU0IGRx0gG5/NvYtqg4fzCvNV/Dpc+CGzbz0uHT2EO8sfcjwsVtAu20VYC8bjJ7BO80vRpJ5/PVZ/mMds+RMInrFFJR+O9mhV0ianbZ6t381VVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97IsHqUYV/TX4Jf+gasY7UfEcJu+mIQoV4rGadrKDjU=;
 b=HoD39sjvW36juWKq5eJ5LjwpR/Wd4WoncHOH2IVl6hnm99B5tKCIEO6NSAToW0XgEjhfgMEMm/HZVRuEPEqj0AezD9UhNt21VrFkgHSkJ0ABPtF2O8i+lFbQcE/owDEXBTqvRp0R2FkaDipjIbM8lPkg0MCDnY+Of2tGSjDPD0E=
Received: from DS7PR10MB5037.namprd10.prod.outlook.com (2603:10b6:5:3a9::23)
 by SN7PR10MB6571.namprd10.prod.outlook.com (2603:10b6:806:2aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 12:22:36 +0000
Received: from DS7PR10MB5037.namprd10.prod.outlook.com
 ([fe80::824a:572e:d9d7:e9f1]) by DS7PR10MB5037.namprd10.prod.outlook.com
 ([fe80::824a:572e:d9d7:e9f1%6]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 12:22:36 +0000
From: Nick Alcock <nick.alcock@oracle.com>
To: Sam James <sam@gentoo.org>
Cc: <nick.alcock@oracle.com>, <acme@kernel.org>, <alan.maguire@oracle.com>,
        <andrii@kernel.org>, <ast@kernel.org>, <bruce.mcculloch@oracle.com>,
        <david.faust@oracle.com>, <dwarves@vger.kernel.org>,
        <elena.zannoni@oracle.com>, <jose.marchesi@oracle.com>,
        <stephen.brennan@oracle.com>
Subject: Re: Proof-of-concept GCC/GNU ld toolchain-driven BTF
 generation/deduplication
References: <874iwqvfeb.fsf@gentoo.org>
Emacs: Lovecraft was an optimist.
Date: Mon, 09 Jun 2025 13:22:31 +0100
In-Reply-To: <874iwqvfeb.fsf@gentoo.org> (Sam James's message of "Sun, 8 Jun
	2025 08:52:44 +0100")
Message-ID: <878qm1je9k.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0356.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::19) To DS7PR10MB5037.namprd10.prod.outlook.com
 (2603:10b6:5:3a9::23)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5037:EE_|SN7PR10MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e70c55c-f9b9-41c6-0c1a-08dda7505141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jkikwfNn6e3r4Oekhf38wtjjXh440M2kjdwCug2exX9kDXga/JO2sIEfi8xP?=
 =?us-ascii?Q?8FAOCeAuWDFTWV13wsKLYcSQ5BCt7AHGzfZ3o4ux3oKQCc/P7pyGIcuq6DDJ?=
 =?us-ascii?Q?H/XJgjZGCTSQmDMDBXI5uh6MwgltBe26ZOJiQ/kmdW2BFhO+FS6wbIy8W//q?=
 =?us-ascii?Q?SyFFW5GpRSzyvQkjVfQsJ0uy9q+dD/EInW94s4OBPqBVBdAi2fT1VQDrf1EC?=
 =?us-ascii?Q?AxNEu8CzC7q37niCRIIsiHqPIH3cY/mk262B6uOOVNzvV2bYuJt0nTlveFTh?=
 =?us-ascii?Q?chgjAen6fx5lPq9bbFNuEP0p4HWS9cj7q1maZ2WAU3jD+TpplKcgXEHRfDsY?=
 =?us-ascii?Q?qybXWHl+obyCIEH7roNA8A8JI2RoHA+reuuQfXzi71pSmgqjtqin8JhnGyTl?=
 =?us-ascii?Q?y8SfGLUc9mhXBSSzsDDpIo2YFWC2MEX4mzj4sda0A2xKi0qiK5vWx6bKzmzi?=
 =?us-ascii?Q?M8ttkJQWiv462bxhgN7AOhh3gBZdDJkC1yi1KIMXOKFXAvYyWnQKyRgzamnw?=
 =?us-ascii?Q?Vyibxh7KYSeCe21QwHYdED0S06F6si2CVWEOdfouamWOLavMren2dQn3sgcf?=
 =?us-ascii?Q?2rjCOMavCrrYkoFJpEVriJFXnW97ZELtCCA3VT1cFS4z+e46G65/t82IhYwn?=
 =?us-ascii?Q?RBHxIf8gejN5vJ28JxiG0eVkX0Dvt2FxjSl2UxKtke5eY3VqCqaCTeLHer4L?=
 =?us-ascii?Q?6N7Uqwa2bQpwL2gM326juD9ZDjTzURsZH3U/akubZsXk19KdxVnZSLsGOxFO?=
 =?us-ascii?Q?sjeVmcIFb2nZTu7+HAdqaV2mKLrcrQfnycS6i7YUdlQCQfJLyOVgVlo93zuZ?=
 =?us-ascii?Q?NsX/TVbjy+dUiE4h6srMxdOj3bwZd85EU3mdvktf4zQC8zJIrTuGSGOxUyRO?=
 =?us-ascii?Q?fBM6uwEPI8ccH9yD/36OUuG8SOj05rIKC2g8/PdZw/nCPNggH4R79Y4iVDRV?=
 =?us-ascii?Q?ZuCC1yda0fGGeRLIghblJZfrMbKbg5eEFbk+oRFb58LWIOhKtqH0YqRiStzE?=
 =?us-ascii?Q?6BmdgHB1CvyZkkrPQotUCJ9UcEUY4EpYEsNw11uY+/OntJQkr1x8RHyOrxi9?=
 =?us-ascii?Q?jnMMkdMq4yfLNgB3fYKhPBMoFGqYtjsBKIZmy8eEjlmBOj3cWsuGppyMQpqj?=
 =?us-ascii?Q?0H3AJw6XrKEM6dHFbodJ9qpXr0OHk4r6ZggyuSeroNq/xCx0JraLcN7l18LC?=
 =?us-ascii?Q?xmdXy5fX1Fsoj5+NNembe+D7j8UIa4DFMVvXHpa+dJmUz4utgtbB2lVvssTU?=
 =?us-ascii?Q?ChJv0iGg75LrfB0kL2i1uFBGQP1xcNx15VlcuLXhpo96cmO8N48rGAGAjPPp?=
 =?us-ascii?Q?nHpDQUign6FWIY6TD3S8QlwqCS+o+/YveFalcN5am8COlMjG8CMJUQQHQ5SU?=
 =?us-ascii?Q?ZRNPT9FLVmMbgQQR9Si85FL9c46y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5037.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zNeALz5qE7bkKwwQriHflSxoIAV4XN84bS4ofFGzxvD7a3fE3evOZXY0Aogn?=
 =?us-ascii?Q?zYz7n13UsZ4HPE/46MOYCdzcaXM6zi04959C4XjL0GgNt5NEJk5kpVq+ovu4?=
 =?us-ascii?Q?FpABbicqYATfIJcy+ZPTcRG0yXQPDq3LlmJimEMjgsAKU/vpc0UA7AZ6ton9?=
 =?us-ascii?Q?vlmKBlGwJFFkc6rQODAiR+9gSz2sabd9mMVrGT9JS5m8z4RZW7GoCh16VSGK?=
 =?us-ascii?Q?tejsiZbfBknzYwgaDN1Pe+0Hc/oaeHLXseO9CctP3Zqs43v8159oEz+aUWxZ?=
 =?us-ascii?Q?hsHzAzqqTsrvPPS+PMsBsZlKHRwbVAbihsUlyG7kYVRLdopcMSd5AZuK/oLx?=
 =?us-ascii?Q?Qr/1+/cSC99uEh6Shcfvu+gDg98Y+CZtp2ETT3rC4Zj6uypPXFi/B6uvIY3O?=
 =?us-ascii?Q?ogacQatD/+YfizYGMEYe8eYG8yWH2H9ASAz1hKByj3uFrVMYpAGB9oLKeOCg?=
 =?us-ascii?Q?ZjB/6xC0dFEXVb/YwNUlR2oRUGOOF8nt/Lb0J++yulQ2rljQDZverdEJPDd+?=
 =?us-ascii?Q?+X1GZJkjgLNLGs4dFPquUU2b6Ic84Naf+WaEqSozGcnuz5lpvDz/fpULZNeg?=
 =?us-ascii?Q?MTWoylh1BQW1ZiugZzC0l/RrqtLyW1SD8QOvOe+nDC29lIT2WMEvr2HuSdu6?=
 =?us-ascii?Q?PGBDFXyVwmuvsyqnNayrvhdSmh5d0anHih3C379TcL9XHFFhJqHv7N5ioi1n?=
 =?us-ascii?Q?X8JiJN264ylHFjwGsOaTsteG7nU+16uV9p2a6puH8TF6urv6Ua+jd7+z+dV1?=
 =?us-ascii?Q?EdkNLSCGr20HWOw4sA2AddOBfwIDIAGOjpg57mhLc0vr/X7cC3HdDEBiaE1K?=
 =?us-ascii?Q?+mBE0lRmB7o45VN/nTPZpdzOi9JK3j5AECrXqYFfz3S5Mmm9dxBRfwIU7l++?=
 =?us-ascii?Q?8rS7lvCsDUpyXB/8vuWd8o3GSKGJh+d3fhf0OvkcSuNnf1Zj9PHusRUnP56j?=
 =?us-ascii?Q?jsqVZWxjLm0yDqOyJUe3uSVI5Sp0916eP66kleD6RXEQ6YB0bectvmB1w6nu?=
 =?us-ascii?Q?NKjLxaeGVycqQBef9RPsm22Yjtoq6HpfIcTo2EpFOsUnTAl5muywniVglxvs?=
 =?us-ascii?Q?mafIZ7nitDKMflaCGprOotlFd04IuLXIcJronOnPWah2mTBuZ3yOjmW/v/Zy?=
 =?us-ascii?Q?/IVSEkvbsJdJiCbOMNvMV1lCFvxusrK5UyZQHb/FDaaCaICAqbsJoLl+ViQv?=
 =?us-ascii?Q?vcoklzz4MlMZpkd5n7C7GBd0eCO5oQHH5bRwa8kxSSsIc4HKfMi6K4dIpufr?=
 =?us-ascii?Q?xDRI1FQMKbx6d+as2VjyM6c1xeCUF3MXaxTbr02axUJ6rS7PPg07D8JG8B9s?=
 =?us-ascii?Q?ivGT1+MEirZTvsMfzHJfbUrUNvAGZqPgU5RP9O+aGMYpmHCfFyRQUFEKGIfY?=
 =?us-ascii?Q?W1Fu3Eydo3eDqQNaC6fCDxwUvmmx+aoRZcCL8pBQE5jYPD/kJAs7MCR8TPHg?=
 =?us-ascii?Q?wAh+1cm9EqEwq6V4jHUoJGQxLLo6CpNWsfcYCyMFwxayDVssRpf2GrZTA6qB?=
 =?us-ascii?Q?WrBZdlad9Z3x/drZjx4lriFIK83bi1KyF7OsfP5HdY43HzDSncb1XKVfxUj6?=
 =?us-ascii?Q?MdOO7Ik5AnzLXQk/KXUVYI0x5BtKEneYAFZ4Y2Q0wE2NWkACRv++/cyYaJ1G?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fzGXa+ewktyBYAL+tArTLhkF7QjhxbOAQLjMQhB0BBfyYeYLHS1aCEIEU6RIo1bfVBDXS8HSmlmviNmrIWYCLWO9R0OvmmuEOFA26zfW/cgIn9CehLVX9hQxKCywYJtNLag/BadUw0rVk+qc/TP4dStbYYleBdx42n2Vd5s4/VUsDiQSC+EUfS2lK1r8ZT/Ly9TXie89qG8kEMdGwx2QK0kmqrxFDiNo6YN6NiOGKSfxD5/hg1LVSRn3Ue1P2l4UnXf9FXhzLsiKZ0hucxASaHIEH2Wh4E58TP34FfUWKndwnPWl38PSn1Kcb/9rQixUH3RU5yriboDfCdZPmAfBoYsRyj4VinSN+6lDvibHV4CBzT4kCfebzO8044sT13qwZTK794b9YkOZc4f8Db/suRIr0T6AulRGE3vJrEEFSafYiefjgTDsQO5hrRkUZcw6kXtcGVu8IX8n+Q+XDiQUSNKw5yO+Vi+sL0G7JiqLhE9M5EGrKd9NTLhncEk5IqgY6jSyt+RohT28LkB8Fhv6oKumPJiBb+5gcBf/Kv5DRS54difYKs9uqC7a94J7vgcZM0GYqdswdJxngKzkFBy9iAOdV6SE5Dwt99VS+t3ymyU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e70c55c-f9b9-41c6-0c1a-08dda7505141
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5037.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 12:22:36.1170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JW64Dx5LlWD4zPsvqZkQvHo2VZreWJuxRdXIGVmJ5YLr6pEAZPCjSmBWxzxSzjch/PMeoVIXtqVJoFMP0DrxHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6571
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=950
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506090092
X-Proofpoint-GUID: 9y5_ZWocaHTxy4yqk00vRD5_OLw9tyS-
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=6846d212 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=CCpqsmhAAAAA:8 a=QAM83G0QAAAA:8 a=L79a9yAk0OFF_Jf525sA:9 a=ul9cdbp4aOFLsgKbc677:22 a=NLyg-29WhGNiqY41-mI0:22 cc=ntf awl=host:13207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA5MSBTYWx0ZWRfX3DBGcA5gKe5D Cis5gimYbM1IMgk86eJ9PETmmPbbMNqVcoMnob8wdiOahSfdem2tcZzWbMQp04mv1Es8bHzpPWq PBz/ibKsoewLCJPytiAf9bM51NvDdX0p3p+p5tGwHR3soqIRg7d9pYbnpl+bK0P3qFU2zBAc8GX
 1xToohWIHinZPKBKgsPZ5dZzvYLTptJG9KPBHU0a5dJVR1nO1vt0q72qqPHg7GGX13rpQELcTAJ JZ0mRphVBMvOfCbzdsm6ETJea9VF/gmLSwb2kA4GL7Dlole7iyXmoiaYqxP9WZWjUea40c25u1j E9veyk8OzwHWBawOVbInjY7XmqP1f2uPi7oLNrFZC4qOg4FIHnpexw3nkDO5X2hdTFARmNqL3fo
 EuJ1J7f57fzg640OhXh2CAMGt3PFY911JQ3PggPTgY11rS6SNk7gE1B5WRJ7DQ8kUYBno6Sc
X-Proofpoint-ORIG-GUID: 9y5_ZWocaHTxy4yqk00vRD5_OLw9tyS-

On 8 Jun 2025, Sam James outgrape:

> Thanks for this, I'm really excited to see it. The disk space (and time
> needed) for DWARF has been a problem for us especially as a source-based
> distribution because we can't assume all builds are done on some beefy
> centralised builder ;)

That probably affects userspace, mostly, since most packages are
userspace packages -- but then, almost all the remaining differences
between BTF and CTFv4 are driven by the needs of userspace
usage.

Ideally I want it to be fast enough that it can be used for real-time
ABI checking in places like ld.so (I have an improvement coming up
suggested by Dodji that might reduce the time needed for such checks of
public symbol type-compat to nearly unit time with minimal space
reqirements).

> Have you got a list of what's left to do and also what you need from the
> community? Or is this a preview of what you're working on and not
> expecting much discussion yet?

Oh, discussion is welcome! If this whole thing is a disaster that nobody
will ever accept, I want to know *now* before I spend more time on it.


My todo list before I try for upstreaming this immensity is here:
<https://sourceware.org/binutils/wiki/CTF/Todo/CTFv4>.  Most of the
really big stuff on that list is done, but there's some things that must
be done for robustness, some that are known regressions from CTFv3, one
that is critical for anything at all (back-compatibility reading) and
some things that we should do anyway as long as we're changing the
format and libctf API and ABI like this. The API breaks are small, but
they're there...

(None of these changes affect anything in the BTF subset, so all the
stuff the kernel build process needs should just keep working
unchanged.)

It's probably three weeks' to a month's work, I guess.

What I need from the community?

Once back-compat reading is in place and the libctf testsuite starts
working properly again, I'll have to start seeing about getting people
to review the libctf series before upstreaming into binutils, and that's
a big thing to ask of anyone. It's cut into smallish pieces but it's
still 12,000 lines or so... not quite ready for that yet though.

A smaller but perhaps harder and more important job: the public API as a
whole could do with review -- it's possible there are changes that don't
require existing users to make more than small mods, but that *also*
make it much simpler and/or more expressive... also, we've added a lot
of new functions in this series, and I'd like to make sure they make
some sort of coherent sense.  API review from unbiased external API
users (or want-to-be-users) is probably the most important thing people
could do to help here, really.  The public API of the new release is
here:

https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=include/ctf-api.h;;hb=refs/heads/users/nalcock/road-to-ctfv4

It's big, but much of the size is CTF/BTF dict creation or linking stuff
that can be ignored if you're only a consumer. However, the query side
is still quite big, and some of the function names around things like
symbol lookup are... not good (speaking as the guy who made them
up). Improved names and/or better ways to do this by combining some of
these functions into one would be nice :)

An .org file briefly listing all the changes is here:

https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=libctf/api.org;;hb=refs/heads/users/nalcock/road-to-ctfv4
