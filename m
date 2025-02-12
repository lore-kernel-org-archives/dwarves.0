Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9873511CA9;
	Wed, 12 Feb 2025 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739321421; cv=fail; b=iHr5HaQTby5WsMkVeXDS6xLxVsz4xOaqmZURViiTuy3uzWoCHYROnYx/2DJCtx5LDnEMmR11h/O3uo4stcvCEHoKpreZeYiSkOzK4ZlQqIH1qxGn4BmhO0xeu/aEbehT7ZlfLFWrG91kUHShv/HZdt/QtlQnZNZbua735A946x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739321421; c=relaxed/simple;
	bh=q8wn9Foycas/9RRNjIv15vrhU0iGmODjdybTdgBXCtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aDu55bOLhEsThgDNDBRfHhgeThmF/oJfRkJ6x1pOf23x+mQf9YLVWutjC2I23e65wJOjbdGMZNjVfsRtw29RrGd7dVvHIDbiRwt2YcBFyM4C+uKGRvfG/AB2WLrNZa8MVhdBi2d5AnVqLtF7S8MCvx87bxLQY2Dfx2EN1oTA4TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RqdLQf0r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I61LFiS1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RqdLQf0r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I61LFiS1"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BLffuH013206;
	Wed, 12 Feb 2025 00:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RQjV+mF0LX/T0n6XVcQMhU8gk1BAPgJmeB1cUtGgQ5g=; b=
	RqdLQf0rIEU4H7kNXwAdelLXHC5NW3t5FSEsCnkbhEHL1uRzTTZmPoYUiLrW+3l5
	nddhsf2foRJKo5m4PrXuQQnJTS1sDQ88T7d/J/+Q0wOdR0L2VT/xmhCDKvS5sqTi
	X8Mo2kexxuDXCnSM6DsW8quguXLNbRgfX8KFqili60C5iZd2sMdGTJivTMsCYLvF
	XzPVYfNcON+EjUEEtU9h/D+xBwacZPWvVY88iGNABLsvFZCqdRLSSiyPUun9RQiD
	+lzUA0ILQSnNof+aChuGpaVbjlzL6A+hl6a38/HXhJXv022k7+tVQO6tSGL5ofaT
	7cl79s2Y4Vldgf10JByM/A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tn6cbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 00:50:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51BMTL4w012615;
	Wed, 12 Feb 2025 00:50:13 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwq9j7pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 00:50:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8QIhnjLhfkcG9sSxLgYYuq676qIgX+2BVIMyaP2EoU2gu3JerBeCjwmldiGpRY8BUZrK+Uh39+nz4a4CVHajpdkraYhOuxpfYZOZ1GNGFtAqZMYg2E6zT0BvVRX2YGsgf1qz/Izx10spt2bnuITfMViJO3+nz5y88V07+KHn3jE8+HnRToBZeJi5k+3/2Z7BCxlMPiKtuuI4B9YSPx/kD9mv/bZGLD77TmUHg8U1bcihN2sVC/EZAy3abaXpatiCD9ceKjlnQl43ArkkCyxyWnih2VyA1FzOUiVW8zm8BOGp9oomd7x4v5ifrit3cCbS+9TXitL6ygkFpNLP6F2Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQjV+mF0LX/T0n6XVcQMhU8gk1BAPgJmeB1cUtGgQ5g=;
 b=PzOKK1+QNjVyVNNon902AFs13Gr965cUawkL2jCBirSfP6qXgjLNgGZyiENnsFaQdTpEwdgyboCHUFUOFBW7DWT4q6N9m/wVg7ceVHl0LR/wsxSZtqNhodJWUG4XT29dH+SvlG7qtNTsZg59xvN9xgbIshOhpIgMO3eToCuvnMJ6Ds6t07Omet7O3a5t6E0GRbZJj2ddScU+XCeYrT6LoCcxerwWeQycwPWNxs8cG5pFVTh8/TpU4sSeT8YI8NNWLVr4+2dtZeBxOZrDvdk7XDbzAs1U344eMV7jxcqDVbjiK5hDNF7kod/ltersuewK3ZISs8f9A9WbxyIrERjs4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQjV+mF0LX/T0n6XVcQMhU8gk1BAPgJmeB1cUtGgQ5g=;
 b=I61LFiS1eRb0cowveMaa3i0bIAEsuNAl1+/DU3HBjwl0lnYqw0ju0TD8RSGTBgyHldBO9cEl0TYrv3F7YAvzX/2aXAtDoG/a6XdJa79HIvC/vyjRkRvsnEgMOSdzj89enERVPMRPHUEcXIFUsTOteouvJUUHHdqBEbJ+KY8h7XQ=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by MN0PR10MB6008.namprd10.prod.outlook.com (2603:10b6:208:3c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 00:50:11 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 00:50:11 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH 2/3] btf_encoder: postpone VARs until encoding DATASEC
Date: Tue, 11 Feb 2025 16:49:57 -0800
Message-ID: <20250212005003.1413091-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250212005003.1413091-1-stephen.s.brennan@oracle.com>
References: <20250212005003.1413091-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:208:c0::46) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|MN0PR10MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e165294-a112-4990-80c0-08dd4aff3421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gcaIal0wYkEOyTvy4KVvcUC0WZpN2UW28Gkr/1cXylTgUt5QFOnzRNga242o?=
 =?us-ascii?Q?J/o3E8+o8MzDykQ+127l+jYgMjB8YcMejsSBO3TVPCWDDnyabg6sK9JdhyyS?=
 =?us-ascii?Q?vSSumIoRzsw2pVlq+sGcqcU3MdrczXWGtSPmleV7KL5QPqjKOHpwSW1OreSv?=
 =?us-ascii?Q?Uu8sB+Q9pD2V47B9zAcrBtZcDc4zTt09lJHlAXRw+sTtNexlpnK/vJ6yHXo8?=
 =?us-ascii?Q?LniCJOb2VR3jhISubQWNV45xeuCDhLgwdK+auS73bBIz3qmNc1VeXMbjQRNb?=
 =?us-ascii?Q?bZzr84YHG5UqleJN/NceVKLSVqhd8SRageYxO7OG5sURHzDTuhgNoRSKfoiV?=
 =?us-ascii?Q?hKeGqZCNC9rFqflTwcjlSK0INFgM9un5AwJnNEKHrZiS8N1CbUUrQOYhsrHM?=
 =?us-ascii?Q?Pve+rn3GkwoqJInKENAkTv7uo4ETB5NA3XZO/VKZMTjGaztVhQewOix1kQRY?=
 =?us-ascii?Q?RE9mCfHFIp4mbML1oIVCjTCZFjbXRJ6p0c8RgqEW3f+H0mfz5fkKE5JpHSmG?=
 =?us-ascii?Q?ka7V9mIVHVLhJk0sOCzWLjjJJCKHLWCdP5m6XwjOsYjwWfQFp/Qmd5GZN0ib?=
 =?us-ascii?Q?djhLiPTNZrkwCTcxDw07bgXgOq7z17Zcqrc6qKZqsS2cgsziH/7R99JNHEU5?=
 =?us-ascii?Q?Fiu8IDLft+n9RTraBSOvkbPk2fEZGCVXuldEysR+wFs+irPo7Gt6ylukjy9P?=
 =?us-ascii?Q?yX28S8UNQ+4QHh4nGV2aWTAR4DJdJmsz9GNsCnJ6qDK4gjh/xUA/pMwsYlIt?=
 =?us-ascii?Q?aWbKanmOUks39VNTK+089uK8kulh4bnWFtLlJ5h4CIVwZ5dXQFezqczQlDx/?=
 =?us-ascii?Q?aRlcnKuPnVD2+kjQSawyFqAhxB7Xsjyfcp2SxnQ+vvjdxRT0duM5C5ZP13O4?=
 =?us-ascii?Q?Avpn1f6tirPf/sVm1RjypRaR8EQk0Z8WFwAmAOh99xEo2dSneuH/IQsSZRcr?=
 =?us-ascii?Q?COzk819gplnYgbVbrn/VRlzd9gI+2jal4VAklt09CugD/5s8IckFjDNMCc8N?=
 =?us-ascii?Q?kH10RBL5FRy+RfNVgnNlpTAHBRhlQLTI0XrmS90YZp1kLBSdCeil5ZWViq9W?=
 =?us-ascii?Q?pLvbPRU0n+OcjxEZKFvD+R9vIiGzE96q/TWjFF1SVfduOYXvmjzq06daVkAb?=
 =?us-ascii?Q?th/vrbQ7qenJL5EFZi2KwFWNmzW0D1VYowuPTZppwqpcoajmTM9q0fTVKmVV?=
 =?us-ascii?Q?KTVO2CYfzONS/NzvEK6f8WTW+PHxSyCvqnWUc4kTJUNbQOzddXFuXkAfopcT?=
 =?us-ascii?Q?dgBJuH/4IrtxoaTkzJehkkoBQBgV6RjCLxTnSB1gLqBh9DFAOgvPT0n5uHoc?=
 =?us-ascii?Q?2ojvO5n8HhYDeonbzjxfvYx8EY9iIIyU1eF1e+7nEXD2MGBKcWpk1mJxdptQ?=
 =?us-ascii?Q?NxEb+7UO023vYJUgJLryJX6RtpEp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6weAmb+D5tUTQv3JCPlm0ZZ2/OjbPzI8DuuYQ3Edjhl/CAkEYJvhx/EKU3JV?=
 =?us-ascii?Q?fkA4UVp17ZoJ13oyfdG2qYJUtnbjjGx32GMWRNAVU7KBOyDvjEBi0lsGE4qT?=
 =?us-ascii?Q?+xvbuZboDNcOEb+AmdKq1MJOVvT4jC0pqI+LX60cwxNzEn8UoJZUrjezWMZh?=
 =?us-ascii?Q?txt1YLlbqwzdYH6T3/AKqxTAZJGZ/3bhN2Vluf8ZP4jYU8eMzdGRGZe3D2Ki?=
 =?us-ascii?Q?6uybTHUSW9VjhCHX3lmbYWJEzK4stg/yyAqo8lpK8d5fK3HT4r7jfnN6rhWk?=
 =?us-ascii?Q?LTo5yiWpnlpPfi5zjvl/Z0gcN//xaYac/luXdVqZyIA9oGyM8cOSwPVzDbd9?=
 =?us-ascii?Q?NwrvxsCb+lb6T7PmUfgUjcQ77JdEoQuO8aNzNWonQwkao5qwQ1FlaQzZB/gV?=
 =?us-ascii?Q?68+4wFiEKgoRI0TmTXLbrLOCbXlsgaj/ZGO4fBhLfmXH7O4MzkxFaY/OEuGo?=
 =?us-ascii?Q?yIFgGCJyCTdhKevXTQWVEJ1m2mXZT3grL9gLopdJKMK05STSO2wFmDTJue7u?=
 =?us-ascii?Q?P4SoH1SHiIXm6qpJdzvZ3IYdjPVYn9R8GNIWFPBAMjGnHVXdNTZqJ2+Sixtf?=
 =?us-ascii?Q?rINxIzhkM3Dzbqrs5/8iQVUu8jABF1ee2pSHYAD19kq5DvY1JIHAhHQF6RxA?=
 =?us-ascii?Q?GEazHtbFKQjR8V6qEUPSshKcr21kn/hWJRttVZjY8C+24AF/lDm4QqCPrUDY?=
 =?us-ascii?Q?NCrc5rkKW+W7Edp95DAfVTmObyIOuibDRTI0c4Mh0uQYnYV6IuXv8w1ZHgLn?=
 =?us-ascii?Q?6MzjKA4J7UxBbNZIC42hnygTMM3HqN9hidtOZGBo/a+n8r8qCo6t8GYaImeU?=
 =?us-ascii?Q?KshXnY0TERli3UuT7EDfXDQZoLVFQQ7H/1q9LwwWt4BS8hio60PMk48jsyIE?=
 =?us-ascii?Q?tH7WPTidHuR8hBOKnn0pb1C4wPsNqKZpIYqStrrfutMD3aWW52vLLGsRGOaW?=
 =?us-ascii?Q?8SIL8q0bQptYDDw/zdyWDijl0x/L1yjtTUF7IvkPafla2G0LT7FQOffiV0JD?=
 =?us-ascii?Q?acuL5GG731D5HHtkarIGe7XwLf//mhPJQumsQqS5hyF0O90BqRLTLuyJyrRH?=
 =?us-ascii?Q?A55hQe1YWzElmm7b3YQWRWksift2bQ8JhgGVADrLJYc6ZF7BtbF1g3ckRHQW?=
 =?us-ascii?Q?oD1AxLvtRO9S9vigtJQl3IcSd3Fv+t9K89XCD9ybPJNNe7irEpcG0QR3EA3m?=
 =?us-ascii?Q?p1PZauL7hUxKu9k0A+1cxmXWuoQdrMOXRd8gjf7C9mkrjKwfoyxcnnB+MVD5?=
 =?us-ascii?Q?3NkXp1mCVzna8WHGBwka/j+uZ/95mt8Nts5KPyuL2i5S6WpQgXye+gFKFrEM?=
 =?us-ascii?Q?Wfc63KdFK2UwtX5ycCfaNgkNN/wEHoL6fnK2b31IGEDFbSGomsy4y/odH86y?=
 =?us-ascii?Q?JxM56+eTiltf0VeYQvUvtNFcbEavOV60tv0eYPccFXOGxPEK0Nr7ZorhDIGi?=
 =?us-ascii?Q?09wweBYhe7U0pFfj6VGjpLcWEyM+BrqQeUTctpsnlnEy2lOensubobqxY6yi?=
 =?us-ascii?Q?JENZlbCDuiZgoqkeupt8kMvDa7fIWE9yJvq29jPwWhwEztxnuTJDhWsms7ts?=
 =?us-ascii?Q?N9BfGBRwNqjKfuCXaJBamRs6OEQ/d9fl/RvJW6jEbHG53zy8VGyiy9VoiALJ?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KUueo4kcaeZCsGKqaTPlDmogw/Gh9NZQVJTwap3lcUNGSzwAjawhyzC4EDGcwaVok4v1KoM/UTo01rTyakBofrWvoW9ZPn59kbf0wX4xPGRvni+YK4YZ0Nb54S5R4CKLu/cH8gJsgxUVCuOMF3EottCj4Mz2sgbWlraIvGnS6Rs6pjjUEUqCroveCSTRSp2dctG9BfhAEfca4g7JObKFhPyljSkIkpexkFBqLCdBwVEyUA4nzmvMhu2bmew6N8CZf85OjT06/QoVGPGHPC3CfA5J9/5tfwOX1lA4lXAJyGty2L3NAnKyf6qwdZksOhLko4GEb9lnTP2pJ8TG9w0E9vl2BQtlBlvKP4C02Lmdrlwf75HNwMFDCsF/4tH4/g6E1/VEWcgHTzAwMiww918MirPqza0cDtaBSyHdxAAem+GCt+kUCQqzlYNDUfCQvAt4cKmiX4H6uGSmMaVlkIdDahySJm34MZxWG3TrzBEAmIuhXDL3EHRQM/S+CDzq6PSktJhYNhG8Dx9sLl88r4XLniYKAoPck7j2fokRPUUhub/ySQIM6H61FaIu6qzyT9HvbFE2BBhUJftW3Q9jz5XG6jQjZALdzq4hF4uWPbY8398=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e165294-a112-4990-80c0-08dd4aff3421
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 00:50:11.0051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3Qnj2BtS54DRM4lrb4j3iocI/cGuRcgFwQtMfQ6+J1cNcsgIBP31JEAcQinRipvfnLUy7qYYEP9povm0F0zf2hhJiN0XUCGG8JINIn5ASs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502120005
X-Proofpoint-GUID: 8H89yj8--E_2YiPrAm7LGgy0PUgM_JTQ
X-Proofpoint-ORIG-GUID: 8H89yj8--E_2YiPrAm7LGgy0PUgM_JTQ

In order to handle duplicate variables in a data section, we'll need to
compare variables against the others in their data section. To do this,
we'll need to postpone adding the variables until they have all been
identified and collected.  Store all the necessary data to encode the
VARs (and their DECL_TAGs) and then encode them just before the DATASEC
containing them. No meaningful change in the output is intended, though
the ordering of type IDs generated will likely differ.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 btf_encoder.c | 163 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 118 insertions(+), 45 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 6a1f5c2..d989fbd 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -97,7 +97,7 @@ struct elf_secinfo {
 	uint64_t    sz;
 	uint32_t    type;
 	bool        include;
-	struct gobuffer secinfo;
+	struct gobuffer vars;
 };
 
 struct elf_functions {
@@ -109,6 +109,20 @@ struct elf_functions {
 	int suffix_cnt; /* number of .isra, .part etc */
 };
 
+struct saved_annot {
+	const char *value;
+	int component_idx;
+};
+
+struct saved_var {
+	const char *name;
+	uint32_t type;
+	struct saved_annot *annots;
+	uint32_t linkage;
+	uint32_t offset;
+	uint32_t size;
+};
+
 /*
  * cu: cu being processed.
  */
@@ -243,12 +257,15 @@ static struct elf_functions *elf_functions__find(const Elf *elf, const struct li
 #define elf_error(fmt, ...) \
 	fprintf(stderr, "%s: " fmt ": %s.\n", __func__, ##__VA_ARGS__, elf_errmsg(-1))
 
-static int btf_var_secinfo_cmp(const void *a, const void *b)
+static int saved_var_cmp(const void *a, const void *b)
 {
-	const struct btf_var_secinfo *av = a;
-	const struct btf_var_secinfo *bv = b;
+	const struct saved_var *av = a;
+	const struct saved_var *bv = b;
 
-	return av->offset - bv->offset;
+	if (av->offset != bv->offset)
+		return av->offset - bv->offset;
+	else
+		return strcmp(av->name, bv->name);
 }
 
 #define BITS_PER_BYTE 8
@@ -848,55 +865,102 @@ static int32_t btf_encoder__add_decl_tag(struct btf_encoder *encoder, const char
 	return id;
 }
 
-static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, size_t shndx,
-					    uint32_t type, uint32_t offset, uint32_t size)
+static int32_t btf_encoder__encode_stored_vars(struct btf_encoder *encoder,
+					       struct saved_var *var, uint16_t nr)
 {
-	struct btf_var_secinfo si = {
+	int i, id, annot_idx;
+
+	for (i = 0; i < nr; i++) {
+		id = btf_encoder__add_var(encoder, var[i].type,
+					  var[i].name, var[i].linkage);
+		if (id < 0) {
+			fprintf(stderr, "error: failed to encode variable '%s' at offset 0x%x\n",
+				var[i].name, var[i].offset);
+			return -1;
+		}
+
+		annot_idx = 0;
+		while (var->annots && var->annots[annot_idx].value) {
+			struct saved_annot *annot = &var->annots[annot_idx++];
+			int tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value,
+								    id, annot->component_idx);
+			if (tag_type_id < 0) {
+				fprintf(stderr,
+					"error: failed to encode tag '%s' to variable '%s' with component_idx %d\n",
+					annot->value, var[i].name, annot->component_idx);
+				return -1;
+			}
+		}
+		free(var->annots);
+		var->annots = NULL;
+
+		var[i].type = id;
+	}
+	return 0;
+}
+
+static int32_t btf_encoder__store_var(struct btf_encoder *encoder, size_t shndx,
+				      const char *name, uint32_t type, uint32_t linkage,
+				      uint32_t offset, uint32_t size, struct saved_annot *annots)
+{
+	struct saved_var var = {
+		.name = name,
 		.type = type,
+		.linkage = linkage,
+		.annots = annots,
 		.offset = offset,
 		.size = size,
 	};
-	return gobuffer__add(&encoder->secinfo[shndx].secinfo, &si, sizeof(si));
+	return gobuffer__add(&encoder->secinfo[shndx].vars, &var, sizeof(var));
 }
 
 static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, size_t shndx)
 {
-	struct gobuffer *var_secinfo_buf = &encoder->secinfo[shndx].secinfo;
+	struct gobuffer *saved_var_buf = &encoder->secinfo[shndx].vars;
 	const char *section_name = encoder->secinfo[shndx].name;
 	struct btf *btf = encoder->btf;
-	size_t sz = gobuffer__size(var_secinfo_buf);
-	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
-	struct btf_var_secinfo *last_vsi, *vsi;
+	size_t sz = gobuffer__size(saved_var_buf);
+	uint16_t nr_saved_var = sz / sizeof(struct saved_var);
+	struct saved_var *last_sv, *sv;
 	const struct btf_type *t;
 	uint32_t datasec_sz;
 	int32_t err, id, i;
 
-	qsort(var_secinfo_buf->entries, nr_var_secinfo,
-	      sizeof(struct btf_var_secinfo), btf_var_secinfo_cmp);
+	qsort(saved_var_buf->entries, nr_saved_var,
+	      sizeof(struct saved_var), saved_var_cmp);
 
-	last_vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + nr_var_secinfo - 1;
-	datasec_sz = last_vsi->offset + last_vsi->size;
+	err = btf_encoder__encode_stored_vars(encoder,
+					      (struct saved_var *)saved_var_buf->entries,
+					      nr_saved_var);
+	if (err < 0)
+		return -1;
+
+	last_sv = (struct saved_var *)saved_var_buf->entries + nr_saved_var - 1;
+	datasec_sz = last_sv->offset + last_sv->size;
 
 	id = btf__add_datasec(btf, section_name, datasec_sz);
 	if (id < 0) {
 		btf__log_err(btf, BTF_KIND_DATASEC, section_name, true, id,
 			     "size=%u vlen=%u Error emitting BTF type",
-			     datasec_sz, nr_var_secinfo);
+			     datasec_sz, nr_saved_var);
 	} else {
 		t = btf__type_by_id(btf, id);
-		btf_encoder__log_type(encoder, t, false, true, "size=%u vlen=%u", t->size, nr_var_secinfo);
+		btf_encoder__log_type(encoder, t, false, true, "size=%u vlen=%u",
+				      t->size, nr_saved_var);
 	}
 
-	for (i = 0; i < nr_var_secinfo; i++) {
-		vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
-		err = btf__add_datasec_var_info(btf, vsi->type, vsi->offset, vsi->size);
+	for (i = 0; i < nr_saved_var; i++) {
+		sv = (struct saved_var *)saved_var_buf->entries + i;
+		if (sv->type == 0)
+			continue;
+		err = btf__add_datasec_var_info(btf, sv->type, sv->offset, sv->size);
 		if (!err) {
 			if (encoder->verbose)
 				printf("\ttype=%u offset=%u size=%u\n",
-				       vsi->type, vsi->offset, vsi->size);
+				       sv->type, sv->offset, sv->size);
 		} else {
 			fprintf(stderr, "\ttype=%u offset=%u size=%u Error emitting BTF datasec var info\n",
-				       vsi->type, vsi->offset, vsi->size);
+				       sv->type, sv->offset, sv->size);
 			return -1;
 		}
 	}
@@ -2091,9 +2155,13 @@ int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
 	if (err < 0)
 		return err;
 
-	for (shndx = 1; shndx < encoder->seccnt; shndx++)
-		if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
-			btf_encoder__add_datasec(encoder, shndx);
+	for (shndx = 1; shndx < encoder->seccnt; shndx++) {
+		if (gobuffer__size(&encoder->secinfo[shndx].vars)) {
+			err = btf_encoder__add_datasec(encoder, shndx);
+			if (err < 0)
+				return -1;
+		}
+	}
 
 	/* Empty file, nothing to do, so... done! */
 	if (btf__type_cnt(encoder->btf) == 1)
@@ -2266,10 +2334,11 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		uint32_t type, linkage;
 		const char *name;
 		struct llvm_annotation *annot;
+		int annot_count;
+		struct saved_annot *annots;
 		const struct tag *tag;
 		size_t shndx, size;
 		uint64_t addr;
-		int id;
 
 		/* Skip incomplete (non-defining) declarations */
 		if (var->declaration && !var->spec)
@@ -2359,30 +2428,34 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 			       name, cu->name, addr);
 		}
 
-		/* add a BTF_KIND_VAR in encoder->types */
-		id = btf_encoder__add_var(encoder, type, name, linkage);
-		if (id < 0) {
-			fprintf(stderr, "error: failed to encode variable '%s' at addr 0x%" PRIx64 "\n",
-			        name, addr);
-			goto out;
+		/* Save the annotations */
+		annot_count = 0;
+		annots = NULL;
+		list_for_each_entry(annot, &var->annots, node) {
+			annot_count += 1;
 		}
+		if (annot_count) {
+			int idx = 0;
 
-		list_for_each_entry(annot, &var->annots, node) {
-			int tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, id, annot->component_idx);
-			if (tag_type_id < 0) {
-				fprintf(stderr, "error: failed to encode tag '%s' to variable '%s' with component_idx %d\n",
-					annot->value, name, annot->component_idx);
+			annots = calloc(annot_count + 1, sizeof(*annots));
+			if (!annots) {
+				fprintf(stderr, "error: allocation failure\n");
+				err = -ENOMEM;
 				goto out;
 			}
+			list_for_each_entry(annot, &var->annots, node) {
+				annots[idx].value = annot->value;
+				annots[idx].component_idx = annot->component_idx;
+			}
 		}
 
 		/*
-		 * Add the variable to the secinfo for the section it appears in.
-		 * Later we will generate a BTF_VAR_DATASEC for all any section with
-		 * an encoded variable.
+		 * Store all the collected information for the variable. Later,
+		 * we will deduplicate and output all.
 		 */
-		id = btf_encoder__add_var_secinfo(encoder, shndx, id, (uint32_t)addr, (uint32_t)size);
-		if (id < 0) {
+		err = btf_encoder__store_var(encoder, shndx, name, type, linkage,
+					    (uint32_t)addr, (uint32_t)size, annots);
+		if (err < 0) {
 			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%" PRIx64 "\n",
 				name, addr);
 			goto out;
@@ -2515,7 +2588,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 		return;
 
 	for (shndx = 0; shndx < encoder->seccnt; shndx++)
-		__gobuffer__delete(&encoder->secinfo[shndx].secinfo);
+		__gobuffer__delete(&encoder->secinfo[shndx].vars);
 	free(encoder->secinfo);
 	zfree(&encoder->filename);
 	zfree(&encoder->source_filename);
-- 
2.43.5

