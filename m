Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B57C4320A
	for <linux-dwarves@archiver.kernel.org>; Wed, 28 Jul 2021 10:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E7360F9B
	for <linux-dwarves@archiver.kernel.org>; Wed, 28 Jul 2021 10:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhG1KxY (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 28 Jul 2021 06:53:24 -0400
Received: from mail-eopbgr130043.outbound.protection.outlook.com ([40.107.13.43]:50055
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231238AbhG1KxY (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Wed, 28 Jul 2021 06:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=534fQ8k8VgHvR3oWaLtQ7pBttk4OuzdAkepMiJKAqd8=;
 b=8YYmou7zNT977bm0jscn9zaIMO/VETkVWPWOsHhDfnNym8G0tBc18BSpxxbfCAPzJyKrP551ntFkUhcr7P3cTEk+o2gn7Ch4N0rHOxVD5oZIVxKdg5Rx+i8dJTLCqc1FDEatzUTem3Msutnq0GXt44OXZmQCitdK+8q18v7LUeM=
Received: from AM5PR0601CA0065.eurprd06.prod.outlook.com (2603:10a6:206::30)
 by AM6PR08MB4470.eurprd08.prod.outlook.com (2603:10a6:20b:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 10:53:18 +0000
Received: from VE1EUR03FT040.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:0:cafe::ed) by AM5PR0601CA0065.outlook.office365.com
 (2603:10a6:206::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend
 Transport; Wed, 28 Jul 2021 10:53:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT040.mail.protection.outlook.com (10.152.18.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.24 via Frontend Transport; Wed, 28 Jul 2021 10:53:17 +0000
Received: ("Tessian outbound 1942ea606101:v100"); Wed, 28 Jul 2021 10:53:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9072cf8e3b4c4e4e
X-CR-MTA-TID: 64aa7808
Received: from 0c5604deb04d.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 97372D50-8B59-411F-A2B7-EC41371FD844.1;
        Wed, 28 Jul 2021 10:53:11 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0c5604deb04d.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 28 Jul 2021 10:53:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNZOcq5ZORU2XxjxAK7zpAR/5KJaob5JTt+ZpwV89jMiL8uj4KzNRhMZHrUEGhM7Xc6bEa03giO1+bJZ8o2iQQxfMd0wZUN9ZA/orC+iomlxviCipvmkjcE9fSlRa5sQVKlErxCrMeiOeihy8lg6baSO72ITh2kI/P7rxc6yfI58xFQQfGOWn8s8oyQjGDnQmL4CDFOmlGVIXBnGh3TcLfcUEnuJJNTkmpjvyWIF/IYi066emV9bkEVSGDjxxe4p5zS/IK5GD5v8ryIKRMOsJTJItOUc+FqXUVQMUMYvMlm9kRkMzEcAPKh2N9Qo9fIO9dWOEB5YuzEgji6DsCo6gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=534fQ8k8VgHvR3oWaLtQ7pBttk4OuzdAkepMiJKAqd8=;
 b=U/rj3zRe6W64SOxJl6F0sxCJvo5JfLRPLxRlfBO0REujey+Ek5rOjn4qfjf+pXELFuEEUWrpshwggoBt7WWK9fMeYZMgrF34BWibY0BCSai9IsQnvU6gIXFmQm2hNr96XAmE54T9Wn9FfBekcD6c8nQ42E3x6w+Q5ik/CIMDGkz+nG77DD2SvqetnDCjWAvEkHwDRQoatjXJAOjlHv/H8i88pmu1bCWIoxU8DINMCsmB+rMia618u6sejE2TZHShOMw4l2GJBSZ4JjHlFM40J5QumVog6UY1233nrAwQyyJVP/0BmMydf8mZHnA8+h90BH0yG0/wjZTQMuOlSfMDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=534fQ8k8VgHvR3oWaLtQ7pBttk4OuzdAkepMiJKAqd8=;
 b=8YYmou7zNT977bm0jscn9zaIMO/VETkVWPWOsHhDfnNym8G0tBc18BSpxxbfCAPzJyKrP551ntFkUhcr7P3cTEk+o2gn7Ch4N0rHOxVD5oZIVxKdg5Rx+i8dJTLCqc1FDEatzUTem3Msutnq0GXt44OXZmQCitdK+8q18v7LUeM=
Received: from DB8PR08MB5436.eurprd08.prod.outlook.com (2603:10a6:10:111::13)
 by DB6PR0802MB2502.eurprd08.prod.outlook.com (2603:10a6:4:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Wed, 28 Jul
 2021 10:53:09 +0000
Received: from DB8PR08MB5436.eurprd08.prod.outlook.com
 ([fe80::599b:3a8e:b16e:147f]) by DB8PR08MB5436.eurprd08.prod.outlook.com
 ([fe80::599b:3a8e:b16e:147f%4]) with mapi id 15.20.4373.018; Wed, 28 Jul 2021
 10:53:08 +0000
From:   Deepak Kumar Mishra <DeepakKumar.Mishra@arm.com>
To:     "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Expected release date of v1.22
Thread-Topic: Expected release date of v1.22
Thread-Index: AQHXg57A/8zXZAjTVkymTzEQmWjXqQ==
Date:   Wed, 28 Jul 2021 10:53:08 +0000
Message-ID: <DB8PR08MB543689EC29E9131A0576F4DD97EA9@DB8PR08MB5436.eurprd08.prod.outlook.com>
References: <YK+41f972j25Z1QQ@kernel.org>
 <20210715213120.GJ24916@kitsune.suse.cz> <YPGIxJao9SrsiG9X@kernel.org>
 <d5b963695314f66240b96f5699a78f0d980a0b44.camel@debian.org>,<YPXptNw0ssvLNWRQ@kernel.org>
In-Reply-To: <YPXptNw0ssvLNWRQ@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: ab73906a-7ee5-468e-b478-08d951b5e881
x-ms-traffictypediagnostic: DB6PR0802MB2502:|AM6PR08MB4470:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4470C8262E3AC6B00F80C0A897EA9@AM6PR08MB4470.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: zqqtMJ9vdNWpLChP1f33IxsVjo5rLG17CfpTGn7rlkgG3IV68DDzBibdejKhm+IsE2pQF5fH9kOZs0oewQyr1KC121YYiXfNXJZozaeBo5Tq54Af7XdeOvj2z1UIEEs77w+4iPy4jRxT6CmdxGGTDrywf23sD0TTjDD3y8phTdD7Q8qjfVPgQ53RTAgEgn/9ALS9PZTafxWBioWcBlR53xYmPvp1e4YvEs81hR5kL6rjtY9VourUMBfzbizPXRnSMfiHs02fNxz9XddojN+uZum2eXzgTSGmlkaQzwU+XaijhQF4Lx1hM1FixLudnhT2HgTDPYhfveypyjplDEQ2kSj7dyxtGrWKX/npv0fujiV9LuCjP/ir+y1Vs/8oiPe27DsPLpL9HR3dJ2BgysTuToa4nz9p4NIz+keiQulDpejhlprB9c9kTm0wGq45Z434e8d8uGflq5A9UyRL/MbW6WFH5psyTrUEcYAHdU+5sWEl98DJY3iljOcH8DK8AUmcDbsQUDFy/xSe/QtpGdSjb0v+X5l/VCfYdg1SDLnmoM5V7OBFMYHILbJcJew++KzSkMeFw1FKbEMh9wV74pBTMcPQkjcg4Ek9fPzU6aFm9wZB5y5Pgzu3B4o+3Ooae60PDo4bN5dCPnA52B1sEbYt3pRW65r7g3CJ+S6qoApbVXNoLErQ6WeCFQ+3MYecNfP4kkDO4QTN3Mo0wmBky1Rndg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5436.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(39830400003)(136003)(316002)(8676002)(76116006)(9686003)(91956017)(66946007)(186003)(64756008)(66556008)(66446008)(38070700005)(66476007)(5660300002)(26005)(55016002)(6506007)(33656002)(83380400001)(4744005)(86362001)(8936002)(71200400001)(52536014)(122000001)(478600001)(38100700002)(7696005)(2906002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gwgJCm56ze9yDhYDbXp8zwp1QJkdTAmDrY81K1X+WzKlJZuxsh7e3aBsCI?=
 =?iso-8859-1?Q?Dk+Z6r8b4bXkQmMhYT81v6o67giKSFOhUhsJnDPwS85DkFFWx0WeiYyvCj?=
 =?iso-8859-1?Q?uq8hrGpR5KGr84pYjpb6wARhRXOyCejiJ5JAHJw2wWPy1oL+hWsRVfRjjv?=
 =?iso-8859-1?Q?2sIx5X8nFnnXOL90qYjGcxxUVKWB1aXMt+EyxYdQkgYX+D4vsIJx2CSDcO?=
 =?iso-8859-1?Q?qV6ZFpsg+xcGffSNXx/kzIjty1Rm2Jtpro++4yB80FNO74O7CSPOpw1rH+?=
 =?iso-8859-1?Q?MlPf21sIO78EzIi/GS/OVipsEy8B+48ILXvzNe+XsdXOuqD8zIjHwFtXAG?=
 =?iso-8859-1?Q?PV0cPyLUJEKKkXAc0bG9CzijFfliay77p7x0bIkrpjy4T6a9QsScpxglM3?=
 =?iso-8859-1?Q?+jlHiWgqk7jxZ7NWxhuTl8Xxjn39e+2oDkMrd+C7Iwi3M03SbOBO3pWjlP?=
 =?iso-8859-1?Q?F4+vVGzkwiWIyxnL3TnuFanlGGKF8KIFfY4s9l33eAyFPdEXj7XpznK6Yz?=
 =?iso-8859-1?Q?60fCp8p7lV0FQJbk2SZlb5kFhRSn+WLUwidHERTAV6Mx1RwQ6rL6WqdsmT?=
 =?iso-8859-1?Q?zyBVjlU2/+LMIBKLVnIHJpRsrNoPKDTgJ30m+eZFkvt/KTyh17EQOhF9Rh?=
 =?iso-8859-1?Q?FQPHuTUdRGtv7Gw5zgQZw6Jux1lPyONuO/rNDipFtXz8ZfYfPUo5hBd3PG?=
 =?iso-8859-1?Q?FOjwIdlJNvrN/R+ALwpa3MF5LkoWszOJrwtwj9rKZ3hof7swPIzrlCBzGo?=
 =?iso-8859-1?Q?G9oFoWBZuhfVyENigCZmhyoAWa23b0KPej9Q7QhbPGHaVzNg1x1XSpMbFu?=
 =?iso-8859-1?Q?3lZR/SGywf3rSA8F8YC1aDRRz5bZZ58wwx4XK4BoiZ3TDxVSDKkawy3D5A?=
 =?iso-8859-1?Q?mlUnD+E6fI/roUUrrKZgoNqIZbCdBMGxNReA8CShg+zbNq16bQuyFwHSOD?=
 =?iso-8859-1?Q?DDXaltOoBLP8fTO2vkLM/8/ocEJXujQqdxlZqQkVTbmWwq+i/5vA5ASZo5?=
 =?iso-8859-1?Q?Zg2F2yegp1hB1IyFVHc78uZDgEl5/wKKnSwBFaiih/l/XfkBksX6KuaA8d?=
 =?iso-8859-1?Q?VchMrxERpADyRe3BGPJTyvTgal1tycW8Y1IeanHd386ITJDPsX4EK9Tvwu?=
 =?iso-8859-1?Q?sYhH7Gqgx5Ivo/qjaTM7cSJDy68GibMiXCB/crw9NGz06byL9B/lwjTXvO?=
 =?iso-8859-1?Q?vP7Y+6Wv8i2r9Z/RbT9YcBpSsb2XCqy6etDP7sM1nl7IIOd+qxC2qmnqr3?=
 =?iso-8859-1?Q?qHI9YuuK+CNCKqtm2JokxbF6Bc4riqwJtDbD2SGmpvtIX6i88MzHzgHP6P?=
 =?iso-8859-1?Q?6+xTKRSNaO+ggobrKph+DHKUyYf7Id2hFEJgcwMYb377F8Y=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2502
Original-Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT040.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8d2afc3c-8491-4337-b361-08d951b5e301
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAtbdM4v9WsxHyJZmKdW1AhNhU61VXvqYfl6E+89qq1PcBO3ILJPnJL9Trf0myOoEjikUHvFkHn1z5hSZG57zjLJJ6vj38XndamGc4z+UxPSlJfMrwgePGzqEGScKzeFTutf5CFEtM7pk0GI0eoruzxogsSl9criZAO5UJmfn3XHLq9vB3hS/4YMd/7lc+aSLO0OSBJDEiGBksIEzo4Ek5ohzEJrZP9Rwelr4uPQYMGa2EFiHHmV+liglRtegWZ3LkO077e4udNBb3lPa1IZMJPasKdpLOC2CUXF0NbLaxy9haJRJG2ySnnfDgiZlIqZ5vG/DwjV9pxVoCUTqf3C5isrFzJLDwjcQC/WXjhtEKSSGSiOOfORgrSDX77NFZkbM/SghdxEZNvKtIMrprh3wTt1yv7huyPM9qVFpaBaIKPPkqGF+5UmnN8afBf9nSLP/oo04TMbDiQeJtpa3peyW+v8zadHa8FXM9HSmYKxxX51oOWpiOoo7R9BK1e2SsRH/qKKP9XayU025YT/v64tGDM4kXxbFBv51Im4tvuOmCPGs+2mOZxsL9RtSm6txe6o44sP1HAqic6/kcWXf+uDosMl52TMtEuEbO9iwd3OySRdCCAhlltH/obNXHDNHcKXWwIEiej7T6tNzOrDt/rUXkVFq1qv/mrwG61dHscW4Kzmn/lUrRSwHiGHAlAyGuQN9eDfmCzxovNohmJ29FHQag==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39850400004)(36840700001)(46966006)(186003)(6506007)(26005)(7696005)(478600001)(2906002)(82310400003)(356005)(82740400003)(52536014)(47076005)(81166007)(83380400001)(70206006)(9686003)(86362001)(70586007)(5660300002)(55016002)(336012)(4744005)(8936002)(316002)(36860700001)(33656002)(110136005)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 10:53:17.9831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab73906a-7ee5-468e-b478-08d951b5e881
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT040.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4470
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hello All,
I want to pick the latest released version of pahole for our internal integ=
ration.
I will be glad if you kindly share the expected time line for release of v1=
.22 so that I can plan accordingly.
Hope the v1.22 is released soon.

Best Regards
Deepak
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
