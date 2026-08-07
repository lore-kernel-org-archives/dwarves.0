Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022109.outbound.protection.outlook.com [52.101.101.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD591412C16;
	Fri,  7 Aug 2026 19:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786130806; cv=fail; b=qQrJ+2k3QeerJbhN0QRAqDnxtJHI55STE61PlY5/0VWTzrNXDAlA3MdJ0yfxEGpJg70YPNf4gdWL925dU+oMgvSTOeR/+udkah6uK87oKBA8OZRrczSoN5Cxq/fvhdUzehusIZUzAtM7zbeDBBi17oLlfEyPF3QGbQipJT+804E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786130806; c=relaxed/simple;
	bh=6KESSRaATfmm/0AX60aAPydurmDjmLEn6FD3vr4IwVs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=nfYjlyjzwUkctO6OgLT4ZxsPe/g5tabMpN0LjcniQoXejJla1p4xMEr5jRgFMlQJzqbyFKhn6nrcEfykKXlMedz04zE63Yd3XCdSi0uoJAL4L57UTUC5MbS4LsGKTCgEKdKZvYfaVVsstBqFt3T/ouQRzKqNhykobBH5nxNzqGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=PBJznzYo; arc=fail smtp.client-ip=52.101.101.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="PBJznzYo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/s6Q6TZoubXrt7doIUI1wbQ0zIWSX6k+QEbJQUOLkxGrqe3stq8tS0q0GagHhnoFNQLz/CST7RKkmSVBzgAtIwBVBtvB/Y70CuOVGc+aybPhcdEuONS78yFYGdRlwgjl2a8Z6e/MWi9oex4BD/cfapgF6EKvsXWRy92EnG4Ue7XPM+qab5qmNrviOIUGTODi/FX6Suufm7l7ER5XP9vqteaCnch6W6SBk5yzXJVLSUrpMoSKF3cgxAELeomszTlIyFxbt0FuABN0Y2I4JsLO2o6cMvKonc1ljyij4e/VmPtjUXMBA0hOXH1U6SFdVX0RGXAc8UjS9xZ2/kbb4BbQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLrGo82GLxMxGedF7duTzSxaUnP4wgw9TPv0QQQdBW4=;
 b=qwE5jQReNtwMc6BAXw0SWhNT6EgHcMeHEUvxT7oosa3DYPZWHSJxgdMnvk0vQdWonVJkkf5fpy2y3O/P0ieUXsK9m5pDTPLdsh2INm2Yi4VJZBNA9gnZji5tJaHfl4dgRS9NoFo8OiEdlXR7i7y0fCjZCeklsB0wx+Lv6Vj9WHgvb+LuYVSeZ7cL3UI9ywhZxxZntz4Sp+AFOQHlKHNH3dyX5F6HQP3mnXUG9tc9NY54o2SAWHLp0TNer/B5ph6SgXYl3VEC85Gfa5Aa6oB5X+bs2i9LRy8/AeN1MTn9Ud7BwSV1y8KN3/wXYLnh7yjZR8W1YmuAdhDRlO/iRAaBgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLrGo82GLxMxGedF7duTzSxaUnP4wgw9TPv0QQQdBW4=;
 b=PBJznzYo+0NdWtekmEUoWxWqX+WyZzo9S4L1p90YXgmGxX4WDv6ZqelrtVifzVEFQaoBKhowlYuVAxZwmmeVUAJ8BLlPg6teeDCxTV6OWccw9Rz2y8EkWsHR7V7BFXnR55AJsr3myTKStu/SXXbJMtpOw3pD5++xu9+K9c3O/j0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO9P265MB7875.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 19:26:32 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 19:26:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Aug 2026 20:26:32 +0100
Message-Id: <DKIYIU7OWN77.C8J7HYHYOP4Z@garyguo.net>
Cc: "Alan Maguire" <alan.maguire@oracle.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Clark Williams" <williams@redhat.com>,
 <dwarves@vger.kernel.org>, <bpf@vger.kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Mark
 Wieelard" <mjw@redhat.com>, "rust-for-linux"
 <rust-for-linux@vger.kernel.org>, "Gary Guo" <gary@garyguo.net>
Subject: Re: [PATCHES 00/12] pahole: Support more rust tags and references
 to dwz alternate debug files
From: "Gary Guo" <gary@garyguo.net>
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260731193102.110693-1-acme@kernel.org>
 <18b557a8-e1ca-46cf-b03f-5e68490c9229@oracle.com> <anXTAComw6XAvnXU@x1>
 <CANiq72nHWY638h4mxJCfh_HFtzhwFEPyo6a-7k_3CxZsRV+Jiw@mail.gmail.com>
 <anYpwcDBtkzE3WIt@x1>
In-Reply-To: <anYpwcDBtkzE3WIt@x1>
X-ClientProxiedBy: LO4P265CA0227.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::13) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO9P265MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f9f5ce2-dbef-400d-718b-08def4b9c9d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|23010399003|10070799003|18002099003|22082099003|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	adH7t42WjbW3mahAmHY3iZYHQeOZUluyB0SNAF+gGxq2EB6WwnBtDL9qln37JuSVkfKh5O6jof6KduJgNHn88xb0U7BZBEtJ71LQ0GVxKLJOhtUS1pD7Uw+IsqXN77IVFQWeamOxbFc8q/FEGF3dn2GAR2FcV15nF6KXs/elpfrZW+heBlHHURL1PkTviZwhGpnBFmoOhJv/5hdrfbI1ujXf5U9dKW3l7mrIQLOQdFJ3o/hZ1NGRiOVaRl1CemgVdDKjqGjBAShEDsmbfTPWUfZGxaRvbOA4aKrSeW7hJeDK9+6mBAbjRLHRinJrfJY0OqAvddwZ8VQ20VsLWqIAvX2wLbb8onvQGeHazv5wwZKY3znqcqkmlOc49ILBXKO2XDVXyTdkvknCUCVO+05WjFTIAMd4Uzomfw25QjMKYRz54gh9q7/0+xl3M1oGAXTV53NnYDtsAD0P+ViO3eVpRIIB6Ob9BwIsc0c4dSLvWXwWAW+Kx+qXooLBTsauKOfJiINqr6/jMhRwUmgWvGkB8sY2RQVtaSVPjE4soseNX3gZlKD1auLFTOQj0/Gp3dPNRFINmZAWINrbnGh9QjKCQaZt4ANXV7pftuqx6pkpa8K60tr/brDKWy6B2SBCwsDSw7jq8RJb8d//nl5fq45CGSX0Tp18umDg7HIEMd7VoSM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(10070799003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmFDNFNUVGtMY1RhQ21oRHhFTkduYzd3eEFScnVIS2FDRHErdWlHYWdaV1oy?=
 =?utf-8?B?bUhyS3dKQU1RRVd2RkU2MU0rMDJzL0pmOHVLYXpMUjdTcTNtVHBjam9Kdzl2?=
 =?utf-8?B?cXJQeHNvYytRTnNubnhGZEVRa25wZ0MyVDkvaGtlTGpPMk81bnhQRk9LZUx5?=
 =?utf-8?B?UW5ZTDY3Q25tMEVJQk0vdVVKMFc4azF2MWlzUk8vTVdmNU9NQVk0MWd1Vjl5?=
 =?utf-8?B?MzlrWjdKYnVER1lid0hoRnd2REQvOEJ3RzBJQ1Rad2JGTEpoa0pjdFBVNXR1?=
 =?utf-8?B?b2ZrVWFJb0JHY2krOHB0WTZuVWdJM2JudGs0dzhNNHh2WnJDM1BCdFVWK24z?=
 =?utf-8?B?czg2OVoxY0N2MU9CRXF6L3R0dEEybit6Y3hnMjZWVVFtOGVQVVE4LzY0ZjJ4?=
 =?utf-8?B?enZXbVc0c01yQ3piWXdlTU9rdk5DbGUyR2tPWnF1bDNrUFdxWHVSY3NHUXZw?=
 =?utf-8?B?TTZvR2hTeHdBbHR2N2xacGpFcHBmSnJDYUh4RGpSd2R4bTk0VGF4aXJhcitw?=
 =?utf-8?B?ZFFTemlEWHFQNTlMa3QxR0cxRStUUFV0TVdpYWJTR0E1UE1uZHN2SSt1MTNW?=
 =?utf-8?B?ekdRWGs5U1pzV1VzZExPTVVXdUtXTlZ6cXVqMkhOTDBId1Y3TldENUFkUysy?=
 =?utf-8?B?STRNOE5NQUNneEZwU1ZZMEhpVVRXdFJTNGlkY1lmTHJ4ZUtKYmVXeGkxSEN2?=
 =?utf-8?B?Vm10TU1YKzVQOHVEeWlpcS92MTc4T0VsM0h4c09VVGZkbUgxYjNuV2xCZ2NG?=
 =?utf-8?B?NGNHQjFRbkRBblBZY3F1L3c3akhtdkZLN04wYitORHM4RjdTZXRodXZwYVB1?=
 =?utf-8?B?aHJhMUgwRURoc2ZrMVVrZW1FYVdncHJkcTlFSG1zZGV1M1JDVDJFZm5HNmVL?=
 =?utf-8?B?S2pVdHJsdEU0SkFvN3RvaUxRMkdhUDcvQnMrR1pNZnd4WFFaZ3c2c1JUU3ky?=
 =?utf-8?B?UWxrN1k3aXVRYmhJSEVkRGhzVFZHUG9OTWxTdXFEV0pmZXhubTVGTXlub3VZ?=
 =?utf-8?B?N1RveGJYc0tMUU5HK2lwUDZBd0tKNnhsSk8rTDVGd1FQaXlYenJ4N0prMlN4?=
 =?utf-8?B?UTQxOUFUaGpJZ292cGp4Yy9BMjM2RWFrRHc1U29KQTlNenJQWHBNd0hnV0lv?=
 =?utf-8?B?ejJoNzVvdFMxMEdKcWFQM0diTXBKNU54V0lrYW9vTHdWV0FaOVV5RElvNkR5?=
 =?utf-8?B?TkpwWjRVNExrOXg0OTZaZDc5NnRPQWloKzQwWXRDMVQwOWJNYWw1c1pYZEhH?=
 =?utf-8?B?Q2VPYk1XSGJuaW1jWXVVcU45bXBkOVFybndFT1ZObXV1ekduWTkzSXBBVmhN?=
 =?utf-8?B?aFJKZ1czUXVZT1k3QnJFYmY0cGd3c1ZtUlNPaUFSb2tpQnhSM0FCRGF1aHIw?=
 =?utf-8?B?cW41dE9ialhsRDRZY3FvNUliYnNpQyt2YzZBTERvRXhjOUNhUnZTOHRwVnJF?=
 =?utf-8?B?QTgyTGlmU2hEYWVrbnRtenlrenpwWDBhVE9vZE9XWUFjTFNVam1GY0ZtSzlI?=
 =?utf-8?B?Sy9ObGtyWCtZU3huWE4vK3NNSGRTKytwaTR4WUQxWm1saXg5SGVoRGo2Q0Yx?=
 =?utf-8?B?UEFROWR2SW00SmMzVTVaMkdDYVRneStRWDZPMlV4bElwWDRzS1JGYWVqenR6?=
 =?utf-8?B?SStzQjlhV0tJeGJranZVMGxEY3dPbkJSNkVCZWo3Y0lOYmtXb2JQMzhCelVv?=
 =?utf-8?B?a0tyeXU2NHFnbEJHdk9QWnY3QUlYY09oTzRLZUdVRnhHekxOSXZyVnRDZWZB?=
 =?utf-8?B?Y0UrZGlRaE53V0dxRHJ5eVA1MW42YmlWYUpna1pyRGw4RWVvOWRPS0ZxNEtp?=
 =?utf-8?B?TTgxdkpDVXZrS1Y3OHNFbC84QWFhbStOcGIrNm5mbFB3UG5wS2N1aFpST2dN?=
 =?utf-8?B?S1MxZFM0ajh5SHd6Q0Z2Y2Jtc2FMeEhVT1dKWmc2TW1UMmNHamNZWDlQbUU2?=
 =?utf-8?B?Z28yS2dLdXNzeEgzWm5WQnB3VHczV1NDb2F0SkFUandLMGdnWE0zQkI2Nm1u?=
 =?utf-8?B?M3pLTHgyeHloakV3S2ROTzE1eHNpazUwUG5ONnVtbVFyRVdzelNTbWtPV3JU?=
 =?utf-8?B?cHZTSzQ0blkycVBmbm9MM09yM2prMlF2Y2ZrN012cW9pWW1HWGFVemNlay8v?=
 =?utf-8?B?UHhNMDhWRkFwbStzcS85cUhxU1pxMExKMlZZSmtHUkxNaTkyblo5dysvQkVr?=
 =?utf-8?B?UWQ3WkxDM2hiU2k0RFB5VTdBVks2Y3dlVmZpRm5GN0hhMmZ6ZTlHaDFFeW9x?=
 =?utf-8?B?YmtMYWh1VTZpdVVOVkpZeFZYU1RKZHovSE93ZUJObjc4M05LVkc3MWoxSC9S?=
 =?utf-8?B?SFFzM201TnBMcWVZa2N5d1lqTmZpeTBjMTZDclBONjh5eEtucmxHQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9f5ce2-dbef-400d-718b-08def4b9c9d0
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 19:26:32.5850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZAwMT7Zcz4Pt5S8XDOmMIlMMb4FsGNOQAVK+JAxvpp9uph3NbFvKwuGNaaN7NZJtAgfzMOQRMHKtMoUD+M0gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7875

On Fri Aug 7, 2026 at 7:53 PM BST, Arnaldo Carvalho de Melo wrote:
> On Fri, Aug 07, 2026 at 07:34:10PM +0200, Miguel Ojeda wrote:
>> On Fri, Aug 7, 2026 at 2:43=E2=80=AFPM Arnaldo Carvalho de Melo <acme@ke=
rnel.org> wrote:
>> >
>> > Adding Miguel to the CC list, Miguel we're trying to improve BTF suppo=
rt
>> > for Rust, this series handles multiple enabling fixes/improvements tha=
t
>> > gets us to the next level, i.e. we can load everything from DWARF, now
>>=20
>> Thanks for the Cc! Cc'ing rust-for-linux and Gary.
>>=20
>> > its time to try to map it to existing BTF kinds and propose BTF
>> > extensions when we can't use existing encodings.
>>=20
>> Sounds cool :)
>>=20
>> > Inferring from "does any member have a niche layout" means
>> > reverse-engineering rustc's layout algorithm, which is explicitly
>> > unstable and unspecified. It'd break silently on a compiler bump, with
>> > no way to tell from the DWARF that you got it wrong.
>>=20
>> Yeah, the LLM is correct here: the Rust compiler gives very few
>> guarantees for the default `repr`, i.e. in common cases it has the
>> freedom to use whatever layout it wants (i.e. even for essentially
>> equivalent types in the same compilation unit) -- the official docs
>> are at:
>>=20
>>   https://doc.rust-lang.org/reference/type-layout.html
>>=20
>> >     u8                  __discriminant;      /*  0  1 */
>>=20
>> For the niche cases like `Option<NonZero<u32>>`, what would be printed?
>
> Can you think about one such niche case that is present in the kernel
> rust .o files right now? I tried finding the `Option<NonZero<u32>>` to
> look at its DWARF but couldn't find one.

For direct use of `Option<NonZero<..>>` we only have `sriov_get_totalvfs` w=
hich
is `Option<NonZero<u16>>`.

However, we have many case of `Result<(), Error>` where `Error` is `NonZero=
I32`,
so `Ok(())` is mapped to 0.

Best,
Gary
