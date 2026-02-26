Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33FE428820;
	Thu, 26 Feb 2026 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124000; cv=fail; b=NkynVwkIfQv+zYUxDbHZbiQLhhDozoeZ1T5+XWKSqti+PdNBRn4qArcBNqoGCe1eyrFeSROVXeXqesKUlnnrEatGwNDupqE1wzPOnuya9Q7uoxioz5RZ2fNsO0BvDw9Jr4tsfY2MxFTKDmBotaShVMUwP7batxNwW+PYnE1efc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124000; c=relaxed/simple;
	bh=l8AZkw2+R/lN0jqa+ns9R/RLwjZ/9tc7w8YqnoZ+nl4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p6m8jEx56GRymvhfuG+0JvJCERTFQcrPQDBPm6Re8wlgCjg9LT12c+EHcEAMSm/zZSdIVgLiB0LDXIridhvxgygFin2Px/pPczGnftoVaWm1X3sSCsi/oTO3pkf7OuV4V46aquLrtuSyOx7Jii5ZQpODMySrNtnfoA6LBns7Jic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nkkEBWz6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lhr2Q04q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nkkEBWz6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lhr2Q04q"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QDN9QU669781;
	Thu, 26 Feb 2026 16:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Juzp9v1h+aFrRFX8Pjig6ZIo/TvnTioJHBbvGdcAnYI=; b=
	nkkEBWz6mSygY2VGc0eldsHoPUnCvTnLkgV3LMywDrPetKXOLmlHObI9/IntsECT
	w1ZIWrNRQQqy5actAYfNliItom07K7tT/QhH/nRhexhQ1ZBim9SpOMGjuAWDc3aR
	NiY8AjYVpzeIjyQ8Y2M7SX1EVvZcXC118bt7qXzILQhR7UhcFQn0osVdABduHbDr
	7Oz6PpEkl9vQ8flvkzKUlys6YRVBjZONLHl122a76iTkvIfNXv9qUhI/dT7QNPyy
	FWYHc4uGixjmaXObarMFXcCC0MX5lAfW+82KaDCgnqIyq6smpaCK5WP2MUKK71e+
	/oqerqnpFfMbfSG1J6gGXg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3m80nqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 16:39:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61QGFYrm038503;
	Thu, 26 Feb 2026 16:39:24 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35pxy12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 16:39:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azeJcDhFl96or02xPbmNLL/IlLBcE+BJynxsLANxryyogQh9NSrshOB8RrqN9ICuazgnX+ymuhBbicnAPCEMRSZijPLICGODV2lzIsnhrkdZgIOgl7RLYfDQIybT+paIbuM3C7scL8HbjiWoloGRRB3wznel0R0nu3d8yHiRAZ0A+zx2sJICYbiYoGwVclQp2HGUh27UyhIAgWBPqPPsGZbjrPqbl0ocr5nFbofP4F1QazeKuZ1MKXOoPbhi/MREOHscn9ht9psMD4xTyiio39V+xKacdcMAW07ZmJAb4I9yPDLTfWS0ykqoqnKzoO+PDJyhXRCZSCi3+4TkYABVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Juzp9v1h+aFrRFX8Pjig6ZIo/TvnTioJHBbvGdcAnYI=;
 b=g3jGTegQh4WeR47N3zTfmBz87NPOAMvWjWYL7dpZaywjQeZvPe9QzJCkmq4sHACp0oiSrri03msIz8Ym0hdSVHD01TARLIGcRWVAvmtmGMKaPMoCa+6+CWCQnw7lJuMGY8G3AcStgJ0nRql0nxYjq9nDSYKpp0yzNlrZKzx3/GPRKi/ERAmsxv6eokasfrPqmJnPC//9kXGIJHrvxQCVNMmTUtUxtzUvdKLmm827O/rO38/Ixmifv6thT8yVSk+Tc4YWW2HdtV2muAZSyYQJaN5NWy0/3/lnQ3c6/l/QEafK8epKrSfYvA1hgm/qRWETulS/P6e3Jv9fOLTuQ1cmmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Juzp9v1h+aFrRFX8Pjig6ZIo/TvnTioJHBbvGdcAnYI=;
 b=Lhr2Q04q6Rtm6wfdZ7xZ4SJAYJH/WHQwRtH1kakRy0geeFg//blvqmvbjcXvFw8XPgM//EvUb1kMVuHtrxri612hKCN2eZLaG0D1zbEpbpDh2wz0W8CR5uZUhTYW2PXZE6guUvtPX+ls/K5O4YmoDOzWZVmT4oaD57EQu2gGGVg=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 PH0PR10MB5871.namprd10.prod.outlook.com (2603:10b6:510:149::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.14; Thu, 26 Feb 2026 16:39:15 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 16:39:15 +0000
Message-ID: <b6f2967d-4d8e-4898-8aa6-e1fc5e59deb7@oracle.com>
Date: Thu, 26 Feb 2026 16:39:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 bpf-next 06/10] btf: support kernel parsing of BTF with
 layout info
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bot+bpf-ci@kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <qmo@kernel.org>,
        Ihor Solodrai <ihor.solodrai@linux.dev>,
        Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
        dwarves <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>
References: <20260226085624.1909682-7-alan.maguire@oracle.com>
 <dc1d9fb29ac2eba86b21fb85ad1bac9d096f0e9680ef87b42a86200120b5e7a1@mail.kernel.org>
 <de9dbe59-7adc-4e00-a0eb-7f5b3cb88ae9@oracle.com>
 <CAADnVQJOv7aayd1Awsfhwmiotkex_-ie+_H2agx55Ka954rbqA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQJOv7aayd1Awsfhwmiotkex_-ie+_H2agx55Ka954rbqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0588.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::18) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|PH0PR10MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d2a3d5-c2b4-4884-a73c-08de75559432
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
 vDrWEuG05TYH5syl7LS8XVbCHWbjmofJZwaw8AQsHTT7SrYDNNiByF7gLeLxFyvC2Fex75Jj+y8j3cL6g/Ku9KmK1m4mI3bk4dLjmqntr9GCjT/OQfAMkZE6d03JYHuuT7r1e+OxUo7LSfhsZoGsH9dTHq3jZg8fTEBJTMJs6YSwh/wK9/277yyEaZZH7i9juE8/vrYcAXk/Bh5yGfTytqleidPdOXihWtQrN9oboUdzoHOmmN4/EGsvpZyL3gqcNJIEjH31uB9f/k4bc9dvOzvEMjSnmGtbCLzf6xfWgFuYnmSDpUUllkKm5r4SIEgtP42/jdsJz5UEl/IZ+RqS2hB6zQF5+qkCoyuaA3i3VA0azgirJO6ragyDji1njzw3tLkh1Z/hQOjrFvAR8G9zg8oOOSKS7hsGMWHH0KtM6/FWYRtOJLivHlF0BpgZNA8C04zwerMZHPMkujY5D3+0xGXFgPgr/QizRtl0byXKXqJSXdKWaD7M4Y3K14mqjFSqLh1PgMmJ3uYFIP7u1Zo0rSKd+CvLi/vm/vATs5K+ITCpLYlZeSLLnhsgyGdh3TlnKP9zNpCkkshJnlfuVpTmMlwtNHd8EE1zS9eaBeVoEKFsH9Ucg74KoQfEMEmuxMuwWBohhGwEpCooK1fGvsGjv494F4nAM56FJ/hBTdgs2Rnkp2jhfGfrCmFcoUxhQbvGhNw/d/5LGBNgZLCLaP5z+3h1ekVEwtOONaJb50d7ks0=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ME05NFFYZXB5aWdHeW9ldDdES2wrRU5xeEFMeVZnTzNlSVhnWjErRElOR09M?=
 =?utf-8?B?YXBHK1pnUVFEUVgvM2hHMHpTV3NVQ042ckpvQzNNY25vQXMxNUFJOFltSHVD?=
 =?utf-8?B?MjRUMjRTZ1h5b2dmTWs4V0lvME84a3ZnZ0xsb3AwN3RVS2lKVnUwaDBTMlNS?=
 =?utf-8?B?Ykd4WmNwUE9FdW50OG80b2I3QmpDV1BlL014UGpESUlmaGxFUmJDSzRxZG1D?=
 =?utf-8?B?STJTTStJTm9IZmxsaGRXdHlQTzNLMXJoeUVjZFFEUFdMNEpmMjVMZStRY3hE?=
 =?utf-8?B?aUtVQU5pSTJLNlo1MjZhUlJRTk1pbUVPSm9qYk1TcTVaYWtBRGJ6eE9CWXRr?=
 =?utf-8?B?ckxpQmRKTDZpS3BsWG5IUFBNSTl4NVFQcWc1OExWcFhlNkR4N0xRRWN5b0JX?=
 =?utf-8?B?a2luZkRBVm5oeDJrTm1IMHFTa3FMaE9UOERGY0lWY1RKV05nTUxGbVdzQjIx?=
 =?utf-8?B?dFRaQTZBU3dIaU1keTIwRkJON3lYY0lZaFFoMFFuZDhrekxYV1Jya216SjIx?=
 =?utf-8?B?TkN2K1Y5bm9rK1lkT1ppNThtdElZUUw0L2tBR3pvRXdCaTVHNFBUd1ppbzJj?=
 =?utf-8?B?MThrU2dXVHF4d2N0TWpZYk1QNktTaGt3Smw4VXZNcFZJUU9JWTk4Mnd2NXY3?=
 =?utf-8?B?bEh2aGIyOGJ5bXRrbUlzd24vdWF4Y0pYRisrZzVRdmMvWnhuRC9Fc1FWUWk5?=
 =?utf-8?B?WGpyYnRYc0Q5OGN5RzVSd1BYVmhrbFNEUUtNdnAycTNLS0d0UndiTkRwdHpn?=
 =?utf-8?B?RlpMWkYxWU5XaHBISk0rb25LMEtuRFFuUGtLdzM2SW5xM3hQUk9PdGl6SlVw?=
 =?utf-8?B?ZjVzbVFKczllWklXZGk3emh0VDYwem9FeDBOVzd1bUsxeEV2RmlMQmErdDd0?=
 =?utf-8?B?OE0zdHFHR2t3SEZNTVYwOWJaNmFGcVIyOEt2aTluUFhuSmpRL2tWcGpwS1Fo?=
 =?utf-8?B?emcrcEVGb0F4VzFBa0RuRDVkNHJyWGlmaEJ1cTh5QW5UME1yWFBSV1NvWkZJ?=
 =?utf-8?B?ZVVOaE5OUTkwQjdKek40RnNSK2NERmZwNVlWTGs3eXFpSzdzTytFbWZUUkNn?=
 =?utf-8?B?dUFESUtid1F2VTBHY0Z3WmNITnV3VGlyQWI0SjQ4b1RESHZLakZKZzc5T0h6?=
 =?utf-8?B?MWhzZEpMZ2hRNFczQmlOSWgyNVVGL003Mlo5Q0JRZzE1aE0ydWtBb3YwZkpS?=
 =?utf-8?B?bzBncE9lb2Nidm9oa0NmcVorWVZxZEFDazUyNWFTR0dqdktZVTdQbG9xVXRa?=
 =?utf-8?B?UjAwb2hWUlZTYmxyVkJlemE2c1NiQUVBdjVoQXpEaWhybUlRRTZWT0xrTXhn?=
 =?utf-8?B?UlJYOXRaZVRwV0VXd1ZPQ3U4cktyL2tBVEVua0U3S0dqdTF1MW4rU3lxRVY2?=
 =?utf-8?B?NTVBem9IanR1ZUhESGJHY0NWWVpVRzZwZWttVU1aeXcyU2ViRVgrVlk4ME1s?=
 =?utf-8?B?UHVUdWhRais4cHZyMlJnRXE0TXRKMDVUTm1MaC9DZzRxay9MK2pCR1JmbmY5?=
 =?utf-8?B?QVRGblhYYzM3L0dPNDRqQXB6TW0wbTVQbDdyY0NCZ1orZFlEc2FsM25GUjlB?=
 =?utf-8?B?a2R3YjlhWnBQeUx1amJVVHNKeHRDTmJBckFaU1NHQ2hMZFg1QVdJOXRmdWQ1?=
 =?utf-8?B?d2pXUEFUQmtrVEtLVUtzTStTQjdYY1UxQ0FaSjF1c2FiU0tWSlZ1b3l2VWZs?=
 =?utf-8?B?a2NUVFZxeVVXK1hhNlMyR3BSQW4ydWNnbWtrNEU4VGtIMzVLblViN29CYTFw?=
 =?utf-8?B?emMvN1k4RWR4SmhNZFpmNXEyMzBRdHJ4Z0tPZkxUT1dCNXExMXExcG41VnRM?=
 =?utf-8?B?NGFRRFhHUEt5TFplSjFscHZrUlkxcmNLeWFzRGsweElOUHR3ZkZoZ3NjbUlO?=
 =?utf-8?B?T1hRR0trd3V1c3drd3EzT3IzK3ZybUw4YnRnVGQ3Z3phQzdqMHdQbVRHZnpo?=
 =?utf-8?B?a2lZYUFxV2ZXSCt2SWhFaFBya0lJRG91SktxM1IzRWloMXA0MnpYdXpJUk8z?=
 =?utf-8?B?bE1Kd0JzNWhwb2JIbEQvOVpNUlovZmlWMWUxejZSWjVjYURZRHJSVGJpMyth?=
 =?utf-8?B?MTVmKzg2cXViMUdqSHRId2pPOVl0anR6aUxEVWk3dENuQ1pIdVF1RUNTQkt5?=
 =?utf-8?B?emtnejVXZnFscXAxR0pxQlA3aFFSVnVZVExRS1R4ek9ZRjJ0anRtcmFCNUVI?=
 =?utf-8?B?OHZLdW9VLyt0NzgrZUN4cVhHREM5R09VS1ZRMHVNM0tHS1NDTmMzMnltNVBU?=
 =?utf-8?B?eE02S01TR1d4eEUyNEcvUTdOMGNaRWZoOXg3SjJhd3R3UjY5VnNuakd2SGZQ?=
 =?utf-8?B?czI4elBJQVRMUlg5SG9IOW9iSDNjdjBjbG15UTFSSHZxQ3FrNG1wbDdTdnJ4?=
 =?utf-8?Q?FDIAdOMc4DW67Ptw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NpzTL+Sx23WU3QD0BLe9b6J3yVYqvtLIl5lSNrVodm0xCKR5xrsd6xmqYbXZiT6nETWskoGIPMZDoXIVF6Sk+vB4w7L6vLEoiUP1Ewg8njyxqNmnooT1tFfY0w/8VVht6yK5cofyJT08P/rZThM0ulfeKWkGn9q1U69tqwH1fLliq7EXZHwSs5iEQLtri9i4Iq8na6PYkKR0zYwPJy2/fn9CpE3uunlGVU5kqAosYWXnF1doEhBUewSOEUEu7bOxNfRi6fjLtCuod2ju0lHn0/JkRV85UmzYYhCvn89bN+Ycm3f49Yx0iXgkjauaAw1FKAT2BLhnbIN6FtHhXi2dCJGKGEkySSBRa6QTYIu8+IegwnidNkyGetCHRgp9FS+igz8NDnTHVR/rrujBi6uNJdRAAuqttvAtAT0Wsj9NBQOL7+dKBeQ/JITHSLEk4VU2QEvOlBiH3BKTcZgPoFbHStNwoGrPPelYCTsN+A/R2d6Z8AFxnaOk73cRajzHSXyEBNoZOQTjgc2Y7wJvnztK/2IqOB6CzNNcDh4//WDV2++uicDlkkKDO+RFqpPe3pZoWGjn3Kee/oHvS8RnynFjrZUHkwaJt5kfzV7zqGqQTAA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d2a3d5-c2b4-4884-a73c-08de75559432
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:39:15.4368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVeZHUXxM+aTinOHjCEq6iuwEkEVJghUXEzWr6vYMUmoQUl0Kd92VD8e1kZUmcp2Ym5ht/Z1WskV50tAltbSEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602260150
X-Authority-Analysis: v=2.4 cv=O5U0fR9W c=1 sm=1 tr=0 ts=69a0773d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=VwQbUJbxAAAA:8 a=0Owg1qiiTDAqgaX5aJAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12261
X-Proofpoint-GUID: JqEEfwKgr_g8NYSBx4ZiVeh7UX1Cevvr
X-Proofpoint-ORIG-GUID: JqEEfwKgr_g8NYSBx4ZiVeh7UX1Cevvr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE1MCBTYWx0ZWRfX322jQNz3+FVQ
 IJ03EmXOpgyG5rxnve0rsQyX9fJBnALYuWF41Eo11G0imf9AUQdzR6noiLW/xMyMXq3njxb0fJJ
 AIqKmhKK/X484U5DdlDLoE7YOnCN4lhSZQ+8mk3acDDGLkGiVjSgZNSnL/plindRRuH0f7Htjar
 9i8rkNDVSAXmfaWG/FLaXJlxnRfxjkF4UmXMASEosL5kyK+yQFg6jcujHzWavvumLeV3z1Ol1/b
 kV5GQytFXnm1MshqArk5uMnN72XFhAnhoMJepEavugmQU/egA82/dAS3uzInHVZqkTvti1TKG9z
 LXJjeKZbDXvplrEOTy8FcSoyNx2P2wq2WoDbsI7u6oWTCXj4BD2K+2OgYtibiPhmAI3aC8K46W6
 hxxCn5HjnDjw6lfsLqg+QxqkzA1bPL5nB+cVwHMj3GBsFIEo1rRvvh1I7qWmum0w7ZyX/IyskFO
 q46W1HAjgnEQqiNi0YTywG31OsscAE7aA0dHrKMM=

On 26/02/2026 16:34, Alexei Starovoitov wrote:
> On Thu, Feb 26, 2026 at 8:26 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 26/02/2026 10:05, bot+bpf-ci@kernel.org wrote:
>>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>>> --- a/kernel/bpf/btf.c
>>>> +++ b/kernel/bpf/btf.c
>>>
>>> [ ... ]
>>>
>>>> @@ -5327,23 +5328,36 @@ static s32 btf_check_meta(struct btf_verifier_env *env,
>>>>              return -EINVAL;
>>>>      }
>>>>
>>>> +    if (!btf_name_offset_valid(env->btf, t->name_off)) {
>>>> +            btf_verifier_log(env, "[%u] Invalid name_offset:%u",
>>>> +                             env->log_type_id, t->name_off);
>>>> +            return -EINVAL;
>>>> +    }
>>>> +
>>>> +    if (BTF_INFO_KIND(t->info) == BTF_KIND_UNKN) {
>>>>              btf_verifier_log(env, "[%u] Invalid kind:%u",
>>>>                               env->log_type_id, BTF_INFO_KIND(t->info));
>>>>              return -EINVAL;
>>>>      }
>>>>
>>>> +    if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX && env->btf->layout &&
>>>> +        ((BTF_INFO_KIND(t->info) + 1) * sizeof(struct btf_layout)) <
>>>> +         env->btf->hdr.layout_len) {
>>>                                        ^
>>>
>>> Should this be <= instead of < ?  If the layout section has exactly
>>> N entries, layout_len is N * sizeof(struct btf_layout).  For the
>>> last covered kind (K = N - 1), this computes:
>>>
>>>     (K + 1) * sizeof(struct btf_layout) == layout_len
>>>
>>> With < that evaluates to false, so the last kind covered by the
>>> layout section falls through to the else branch and gets logged as
>>> "Invalid kind" instead of "unknown but required kind".
>>>
>>> The libbpf equivalent in btf_type_size_unknown() uses:
>>>
>>>     __u32 layout_kinds = btf->hdr.layout_len / sizeof(struct btf_layout);
>>>     if (!l || kind >= layout_kinds) {
>>>
>>> which accepts the last entry.  Using <= here would match that
>>> behavior.
>>>
>>
>> looking at this again, is it worth making the distinction between a kind
>> that's in the BTF layout but unknown to the kernel versus one that is
>> not in the BTF layout and unknown to the kernel? In both cases we reject
>> the BTF, and given that the kernel cannot be in the business of trusting
>> the layout provided with that BTF it seems like it's a distinction without
>> a practical difference.
> 
> "unknown but required kind" means that the kernel doesn't understand
> the kind, but its layout is described in BTF?
> If so the sentence is odd, since presence in kind_layout doesn't mean
> it's actually used. Here the check is when the kind is parsed.
> So the kernel should reject it with existing "invalid kind" message and
> that's it. It doesn't matter whether the unknown kind was described
> in the layout.
>

yeah, looking at this again it's leftovers from the flags stuff which makes
it confusing. I'll revert to original error messaging since it's irrelevant
to the kernel if the kind is in the layout if the kernel doesn't know about
that kind - we can't blindly trust the layout data.

 
> But at the same time if the kind layout describes some unknown kinds
> it's not an error. I think it's fine to load such BTF since all used
> kinds are known.

Right; we'll allow layout to describe additional kinds not known to the
kernel, but won't trust that info for parsing BTF in-kernel.
