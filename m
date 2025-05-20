Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED00B158545
	for <dwarves@vger.kernel.org>; Tue, 20 May 2025 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754861; cv=fail; b=e/hp8q9qyVoU930NYWo9m3SK7vuxr2lF1nMI2mY5wJlJ+1vJeKpEXZMA9o4RVuF3PEhfyZ9pE96XG2y6zuiBDoaErge3dc43hVbm3547zkcp03vA2om+B2nSf6Lbaga/6AxBIEoP98ePGp+O5d9YF08kl29qQBGtHsKHlpguvPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754861; c=relaxed/simple;
	bh=gVJA5iCpwV7jciQFj56tUIQnfCBjyrRdtdIufQP5t84=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 Content-Type:MIME-Version; b=Wq1qoq1TAU/jIczG7lmbG7+kAXi672udquibmiCtxdnyTC1s9L5cW70+txF9v3gQRyR4wS+SUzUi4X0/347U5m4/SqpHEdaXZwfujl133lGSsSwYnMruK59/1OFV/ittv0lZifQ/vuLV94JuqiVv4sif0dC2dHTUYpHpbFcEQ5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QYeHO9sY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hbjVUJ/N; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QYeHO9sY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hbjVUJ/N"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KFCEt2027555;
	Tue, 20 May 2025 15:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=e9+34rqDINRNjZ6Ws/
	evMbJotcRNPg7Q7nwM50xxPF0=; b=QYeHO9sYOvfQg9/5Jc/wIns8OdP+8YwKdo
	lMcDycYKqi5SN60Vydq5sCBFvUODY8MYZloYcRDjtb+BeDMlTPMhKRza3cWcAjP9
	hq852l6cCrJ1m88P+UqJya8FL0IEan7tNIremO98+n/PkJ321J75U2jWCbTWh3Gg
	wwJF5p8PNWt16XOTVsPv14fEGSjSFmqDGOA0ZlNk4nFi7+0oyIwsidBTulgtwKJK
	w1z8vqvoZam1G4tY2PhFy4dv0nbWclh/KMcEiQ1g49KI5uGucaPIO2tv1+bW0iSZ
	CEAszTxG4xVSR3/hAQbkfyPCqFc9okAspwVGaOeH8kO049A3nwJg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rv5u81g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 15:27:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KED8kN002582;
	Tue, 20 May 2025 15:27:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7x9dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 15:27:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWDpsYN71hw1rg3aJVR7IPmmTLKgoPF4B3WKjaesOLnKqC6OVImIr8VTkY49evQq49RWNChf7vuginTwyukr6fCvqjT7VOm4VmiA428cUgwHXnEidT8fdVV1eUM8ElbDq0o63ezSY/Ng3IS6b2bo4sy8pERTmrzSL2dJOhja5NWmIxQ/DQlW4arD2/4GTyu754tiMU0a0uczgpTs8hadmE4iOLE3jEPzz3V61dv0NJfZCJXKjbuJhXPt3uYfqgYDYhgGFuS+Yu3vGGmZO4m9enYEl0bjIvNStAd24moKw8QrRLTsxZ9gRSA8OtvcbfFd2SfVFJGnpYLf0Q+j+Ja/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9+34rqDINRNjZ6Ws/evMbJotcRNPg7Q7nwM50xxPF0=;
 b=YiIvgIgLm9xSgYyXfCsRWalu6YpCn5O5KX/h7i05ACXp6ooZNtD7QN++UR/KoO3oaHucC/c8HuwdomkS4l5pY7wTdOSBwcEe66LPCQJGRuhs51K96XXlwEHC6Kv0ScDzKbSctojUbX4wkZJZLiykWAjwLxCCBsEoxurmLn7N6uwwAWUVcjA8zMun9EwNwJVcD+zTQmZIyKEwZsyhjlgxNl9wsP/KrJCvBOG9U2zjvtOa22D3OCwHxeI27b3UVwOZZOPkaLGTgqpL38y5KVJJWhMbt2LM7STYMzrs0cOeIThzPqY2btGaL4phlKwvMnUDDvvf+F+8fNuCfVCb43rqqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9+34rqDINRNjZ6Ws/evMbJotcRNPg7Q7nwM50xxPF0=;
 b=hbjVUJ/NVSL7h/EHV8un+jJG+Bly+YJM3EN+dV+fUV/d6k2RC2GHauQg5aCPygvlnTFAdzdqG3ZQjIh05OEGP9O/wEvtHmnq3nZiWk8+mmY8HHCpV4WOjzqAkrFuWiYRHmS4H8i0O6/GqwTIFEZYcaDiAhwGzgNkbRJBVS9Iwlg=
Received: from DS7PR10MB5037.namprd10.prod.outlook.com (2603:10b6:5:3a9::23)
 by IA1PR10MB7239.namprd10.prod.outlook.com (2603:10b6:208:3f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Tue, 20 May
 2025 15:27:32 +0000
Received: from DS7PR10MB5037.namprd10.prod.outlook.com
 ([fe80::824a:572e:d9d7:e9f1]) by DS7PR10MB5037.namprd10.prod.outlook.com
 ([fe80::824a:572e:d9d7:e9f1%6]) with mapi id 15.20.8722.031; Tue, 20 May 2025
 15:27:32 +0000
From: Nick Alcock <nick.alcock@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Bruce McCulloch <bruce.mcculloch@oracle.com>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>, dwarves@vger.kernel.org
Subject: Re: Pahole, BTF, and vector types
References: <b3948534-c567-4348-990c-28efe144906b@oracle.com>
	<f5ff6332-eb86-4c08-b4c4-9e7c9b8fb882@oracle.com>
Emacs: because editing your files should be a traumatic experience.
Date: Tue, 20 May 2025 16:27:29 +0100
In-Reply-To: <f5ff6332-eb86-4c08-b4c4-9e7c9b8fb882@oracle.com> (Alan Maguire's
	message of "Wed, 14 May 2025 16:22:23 +0100")
Message-ID: <878qmr5mla.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0668.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::14) To DS7PR10MB5037.namprd10.prod.outlook.com
 (2603:10b6:5:3a9::23)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5037:EE_|IA1PR10MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b2effb-afa1-4795-8d4b-08dd97b2d6fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ycrs7KWOYfLkjYABlB0xZKoCUJcC1hm8/qF4zqVAzfVFhgjzq0Jp9x1VVA3B?=
 =?us-ascii?Q?z0o3cNN+T7vgRax3sQ+rvNCXp1aeowpjLpOP5CHPtDXdg4eiCWd9NcyN2rB/?=
 =?us-ascii?Q?8KBZ2wxiMZcoUoAviUEpmOenM1yqwYEXXzDIFb0vvViiczsKn++iIqB7dyZe?=
 =?us-ascii?Q?YZcAh6CweCEG6DULitGhBAO9FrTMsxCwjfkPiBGNOkjgump2hmLNnWF0xIoP?=
 =?us-ascii?Q?NgZIE1NBE0IHwBA3R8JXLbELCN1GB8/81rQiBEAYIOJSkGdC/aOsuq4Eghsg?=
 =?us-ascii?Q?gtSttIQ1vmXkkaPb/uYqBnnSYK8siOIT93lDv+Q7vkr6Dd3r8OtiGVCQC2ib?=
 =?us-ascii?Q?zL2ac4NxvObpLibY3/DFKE9O0A2Hbi0SxakWCaG1EgwtCAn5cMXiUnslohaW?=
 =?us-ascii?Q?m2YRAbKPLU/uV5Y8KSeXBJghH71b/xCmec/1O5VM2j5HlDMWVEsFOY76lNSW?=
 =?us-ascii?Q?tvaQnhmlQoRNw8LpfPGYhcbmVvO1cPbISlbwV2i7fM4CvobgMueeMSksUekw?=
 =?us-ascii?Q?rOSOz+hVZnPnsPgmHvtrEknvlTF+69wy2WZ/JNK0PRNbS8BHkQSQa7yfqa4y?=
 =?us-ascii?Q?9TP4oYZgq8KDWVVE8JM8gY5VtMO3dHqKgXV0RxYgvelJNHd4UayrRuSK50oG?=
 =?us-ascii?Q?xSIU6aCPyUQ//UxvaAbxJhoO0grpsH1cYi2r3i/Wg5sQkqwPZX0OFIwI/GQM?=
 =?us-ascii?Q?3eJCFl3OsHuajpdsmNvqQp69Q7T7BxX25+rhAZSWB4fWhEe8OKzVDtNHU+Ns?=
 =?us-ascii?Q?sXJpNGJfHhNqzclIroE+RP/9IXiltaFpUEiWUxG3SKffxMLFFhycdqV7U1H+?=
 =?us-ascii?Q?EW1VEuDCYnSBNEH6K/m3H2uA/bEjLAoxjq10ZZ4qQ4euPaKPeUOb10Nt6Cln?=
 =?us-ascii?Q?DKz6+HKA3Le0R6MOSKYwAvWk1kino51xWlRWjhX6WTpcquP8bv95Jwn9wY3X?=
 =?us-ascii?Q?shY9Cxdk7LG+///2Erss1tSyPdKEr0T82g1kMPF4mK8nsIbg2UA/O/8apYZo?=
 =?us-ascii?Q?YoOrhmPdELRE/xjPlZmQPstg2MMQ51cwaU3+0tSmtqnJDVpVEumhtCh1rEQr?=
 =?us-ascii?Q?HyJiEt66waHCvhvPq4nBO/yiBMsRx+UhRNH+6Ae1LEx+Gpx9QnIYRnIlBqb3?=
 =?us-ascii?Q?15Sap/F9YkfMFRfjHDxpvOQrY+pY8l8GSu/q1Ub6xvQnZt1Y6XHzdvwj4Fd1?=
 =?us-ascii?Q?r13iZ/6zwtW8a+KTW3y0WQa3PbV810pKOImqnGDNydZE6mkM9Z/1QNLjz0Hi?=
 =?us-ascii?Q?nyUpmbobS49YZZ+yyPYZ+vBwPe398thpkqB5B3GmKKMNYPYJXqS7Ug9vse8B?=
 =?us-ascii?Q?9DdmkBhBIBvs3zlBryGszJ7JE5+SUc6CZKdSN2I2AsHKwIJA8YbnxJClE/WX?=
 =?us-ascii?Q?70LMoLM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5037.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ssQyvvfwvf/0Ou/0YR2vooV/eIRPtvLDogOuqCSkCiQnvuC+1COcscuQp0Sl?=
 =?us-ascii?Q?FmmqqmIR1Chymz1VUGqSNcPkr+KwruAej8wFB25VD1Xy0eBdxp90oJor1g+k?=
 =?us-ascii?Q?Y7xXZKK5jC2H4tyVrRcSQ8MFAIOva4G1mlxMsMyOcQrjhVRFgon3am+G6Fbb?=
 =?us-ascii?Q?UJlZngZWsmS4w1eDAMYt/GO6MEp01cK2MZltm+MkgMpx9kCYaH2yhhsgTiay?=
 =?us-ascii?Q?1jHHK66hOUDOOd6Ks8SJ0CJRiHwxD+xSs4FmGKRBgJXPFC6xdoaTAfX7HrqO?=
 =?us-ascii?Q?ND20UWdIynwceA6GQGl7aqXuerjG05NJnCq5war6WXKI2FRvuVOt5nUiQWBy?=
 =?us-ascii?Q?OojFyk5zHDzP4Tl797rah9ZOur1VOvZgd9R18cfeIMvuyVq7jjxs/CR7FP4v?=
 =?us-ascii?Q?eITm8Y8641d371RmEeM1Zjok+rlBnOZYwUzQedSynK5PP1aa/t0tw5VoB4OU?=
 =?us-ascii?Q?Td/HlqPDLUo18gO0fvXtf9oq5gvtEU3jv1F5kjeVgljg/cthCVekCHkeyoen?=
 =?us-ascii?Q?vrbEz7YpmsoqrhVuuNQD2nSQjD+2lxX5loHCmgZd7d8RnN8F2qOEApxwDPkr?=
 =?us-ascii?Q?9yTJCgQv0Nr1aWOiTw1QkqaJhLCNyLEXioJrnuVp2rDssyVE11N55AwunE6c?=
 =?us-ascii?Q?oaTMuvrFNySw+Y3LlFAIbcIXPDXelxPsOoZzO9eWd1MCzXZIg+zaPtGfOXzV?=
 =?us-ascii?Q?Rpy6i16aoNmucW/71/GeI2m11ZVqraE+szwjbFGciFWqp9dymUBLRuWXy1Yb?=
 =?us-ascii?Q?0f1jV+2SUNpLP/NYgdnD2fZImjcLKs2aN/WlBs58b/dEYv5YjohOirxNTdUY?=
 =?us-ascii?Q?zd50AA3YUcrE1uS8+fu1+c4FvVz48qXePJ1jrKSlVv3BeeeJHgQ7fRCuvE3F?=
 =?us-ascii?Q?RoZJv79AYqAP8p7jIMtkhRnHHUBYn/A9cC/TPUe3I7FN7Gw8d6X4vTRCNx+G?=
 =?us-ascii?Q?Xj3zIZqlcR5DHUiwqbZCQ9BnOAj8LcwyEzIgZPdzdHy1X4cm8NOvSECAeQX5?=
 =?us-ascii?Q?lZGsNSzbrjC+qk/pFYDcc1jtArWpguR1qiEW8I11ijHUYOWA/x3zaO0iLLQy?=
 =?us-ascii?Q?WJOh4VoUTxm/f2yD7aaipgAUQJBQ4MMESFe+xob8YwsrhqWUKoTjkOzMet5m?=
 =?us-ascii?Q?cXLpSiBq6aJb7bSs94bwXb2vaJapWjbeeLXk9JKq2w09BAri9LxoDFqTbr/O?=
 =?us-ascii?Q?HxqHVMflCrvO6SKFc4v1W8wdJx2ujDMm4Pw0UwzRfQyADugDkCHyF5c/Lnh/?=
 =?us-ascii?Q?YEw1HysssRl2Li4nvvyrRrBtJNahNHpzTb3TjmN/f7aZY+4Y+iE4YwgAVq/U?=
 =?us-ascii?Q?Tt2p17QQyS7p37e3r7/y8/Ry2uPPgvG2mMJn3jBtbjZ6+BGE76pr4ZfOfmPr?=
 =?us-ascii?Q?eaKyujuE16aA8KYhvYX70kabROO32GMoaMXGGqC7RjBmq0VxGo+3hcvmaEvq?=
 =?us-ascii?Q?fkAvUi1A6bBk5ETxhjbTvK9QahVDF2MzAFHQn1lWyisQ4ZKjRyFHSUaiNi9V?=
 =?us-ascii?Q?HvztgDCwHv6IksBj5BPkWr6OIguurWJLkqXATFMPLRrSGUrhxM667mocr0xD?=
 =?us-ascii?Q?mDzxudd5egYJkmRlcFYqPDz/H8ZI829SLF5MUxeK7lSfR/y1RGFVmWcqzcs+?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qOBxfYv6EyIWLrbrYyZ4MtbC+WPyzuivxpb1EVkZ7QH4LP0jiuYvB7B91q8g9nufQ4SggoOkjXv0RytHJax1RDKFWLV4jijl/3o8reaLNUWqhqA/fKsP0RKFfQyEuw+OgodRGe+8xa1PxwMDuIYCAN3kYByMONNIcEEFKdOE/xjUxpjr6sgq/w/9a33kbwccqNqXWFMlUClA3O9ziEv+e0yuigScQ7a8x+rYr8xhx5/HNINtTxrmXQnNliItvPnvGqoi90fEf+F//Axd25/jMru0cbD8p0WIMzv2yW/JEfMCPt0DdmuEjZkyj2Ch7HUtONxLm2BymfasXBsADiYuG0XyN5XZTU7HB7ojF9Os2tCGYFZXSqyIiE1Fj+AcsFT1HigZkeUDr5mNmOTRqcy8VQ1LRhZlpM1K8fgrhyCSA5fakDku1m4tHsYTVb2Ua4r+JyX8x/b40RQjbDx8DOK99O8xB0Cy7gZok64e15fqh2yGheYfNW5s1x9m/eORZsMxrOrpvyoV7KrfhQxii8Z1Z7X1ZPiatQ3VeaTZ5AR4rwULulrngX7JWbIIFaMK+4u114qHrY594sh6rWoIK0nOK2dMuonj5gobMhEIr/LQAkw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b2effb-afa1-4795-8d4b-08dd97b2d6fb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5037.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:27:32.6156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jh58EppHNuTSD6lK//HEX4zOj53+C1SkqVANEKsg0eWRzitxH7ZdyszC+/bLFsJSq32+YU9alMpKbPi17dHpTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505200125
X-Proofpoint-ORIG-GUID: ieCkydRbaz3yfZIMlSVOhO2wpQhh4EJ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyNiBTYWx0ZWRfX9e+bPWTM1paj +kY426OFPjzERW05HC+esDZ2206Cnoz+ciutk1AD2/OhgNiJRV3ixz6kYCc8/UwNn7Tx4/j69AG 3ec3gp8++lzC8u9SdNoFvKI2LQ27is1kkIdEXC7iyjHb+DXCTV1krpOBO4CoxPeGMgeyvKLEBB2
 Fm6gwhu/R6wsHBdNHTyXMIggsYKpfa5cgee72yz/k+eQtI5eXnxbMcV+HWn9CCA+I0pX9Qb5j9v 3rK2Nvj149N+Mzg0ZJUNvaMMwss7+rbBuI5tf1j4hEp9Pp59vU8XWL05WtiK9qxMwBd9cqwkHqh b07yVKdoevIsPzjQRTZpYl3Lbosz5OsWm8dB+YWD2oWC49GpdnXI4nx0Dj2Dae1j06RBMKdkRXv
 MnTxAEdfNmR2hKYsFesAc0yraaMFqSuuVTbU8icyUJuFdvp1uSeIjKSJxw8Kv5eG1sJ9bygD
X-Proofpoint-GUID: ieCkydRbaz3yfZIMlSVOhO2wpQhh4EJ_
X-Authority-Analysis: v=2.4 cv=Va/3PEp9 c=1 sm=1 tr=0 ts=682c9f68 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=p4yhxsxNAAAA:8 a=ALHzrhD1WqeLMmyw1pUA:9 a=yp-Zx5YoBjEA:10 a=4AvGVvso5qoc5vnZhopw:22

On 14 May 2025, Alan Maguire told this:

> On 13/05/2025 23:39, Bruce McCulloch wrote:
>> Hello Alan, Arnaldo, All,
>> 
>> Recently the Linux Toolchain team at oracle had reason to start emitting
>> types
>> with the vector_size() attribute as arrays when compiling with -gctf/-
>> gbtf. This
>> is a change from the previous behavior, which was to emit these as unknown
>> types. This emission as an array is consistent with BTF generated in
>> both clang
>> and pahole. We have some ideas on how to implement the change in GCC,
>> but were
>> wondering if anyone involved with dwarves had any insight into why
>> vectors are
>> emitted in this way. More specifically, there were concerns surrounding the
>> practical differences between vectors and arrays in the realm of memory
>> (e.g.
>> Vectors can be passed as args by value, while arrays cannot). More
>> information
>> about this can be found on the DWARF std issues list [1].
>> 
>> Any input on this subject would be much appreciated.
>> 
>> Bruce
>> 
>> [1] https://dwarfstd.org/issues/230413.1.html
>> 
>
>
> As far as I can see in dwarf_loader.c we do record that an array type is
> a vector, noting that struct array_type specifies true for its
> "is_vector" field if the DIE has a DW_AT_GNU_vector attribute, but this
> information is not used during BTF encoding; they are as you say just
> treated like normal arrays.
>
> So we do have the information available to potentially do something
> different for vectors at BTF encoding time. Did you have a specific
> representation in mind? Thanks!

We were thinking of simply turning on the kind_flag in the
BTF_KIND_ARRAY for such arrays-that-are-actually-vectors: it's not used
for anything else as yet, and that means we don't need to add something
to the vlen (which would of course be a compatibility break, though BTF
seems to care relatively little about such things). Adding a new meaning
for kind_flag 1 ("is a vector") is relatively compatibility-concern
free.

(I'm assuming that being a vector is a one-bit decision: vectors don't
seem to have any other properties beyond those arrays have in the DWARF
representation nor in GCC nor clang, that I can see.)

-- 
NULL && (void)
