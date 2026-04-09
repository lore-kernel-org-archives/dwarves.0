Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010052.outbound.protection.outlook.com [40.93.198.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E546B3DEFE2
	for <dwarves@vger.kernel.org>; Thu,  9 Apr 2026 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746079; cv=fail; b=Xz333Olq21uaJAETLXvflsLpF50iO4Nr/h1KBXmdqTZveCzoGzXmW4aDDbmaE9G5bCEY/OqocLweR5VMb+KJ/sO44ZP+wnHGinRXOIIaiXtwvfO5ejoOsOaBV1iZ+hWh1fABXXhpB0DLEffcNHjYDtPpESgaBKtUngFhnd370v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746079; c=relaxed/simple;
	bh=gwgnxm8eCQr4ROH7oyTKn/sjk69qkBW8r5v0qU8QmJ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GFoYCBWKbSbMxoWfWLvzMLGmogZER+dsNR2CMpZ34pOui/jzX/0+8/YkgE690q2dzv99u8uZ4xE/3p9RHXqgmVU0i5i8sXtTonDIc1FBS1616TscdrOncD9bfWLi7sLMRjn8IS5owFAvaDldnrg3UBbPLY4UrgwqSTNquRF7f70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j0x8NxII; arc=fail smtp.client-ip=40.93.198.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j0x8NxII"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iP/nVlBXGqlcP0pS/PM+bxhCohlMbWBz8IkOJvmWW8M04N3mkf9jVK4zni1jCfUTd6tP1XQDWDOt8K3y8bSZz1NzJGkL4rW2MMeKgCArs5YpUtVv/wMN/n8dqsxgnlyDAP3xBKQKhkDGlRMvi0NbKa1b+NPYuJF04b/7sHfEaafuo106ABqDJhbgIddyWPLbsvYSaixXqpwcqrTScguPIrdeKyGSiGI0dU3l/arZzdHu5TyR778DObDGtgwdjBbh55j/qP20x8sM1fNoh8/iZO9XbxkuFc4ICM9ugiW32KmZivWxT21ArfMyx63dnzkaeSv5n5v3hM8taEnVjZlLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq+OP6wvz3KadcFsXcF7I/ROjCb0LoNaDYOBQPgroeI=;
 b=IEMs2h6gxL5i5OJWsey8mgph7dB+tD3EMLwH1MrBWrVjzWtH4mlAjNp4XepneIR5igiqcj11JPsps8CEgcU7K2NJDKJK4cn2eIPXinWJlTg6j9QYwWnKBJLN+OAv1pEqEzczL5NHFzEm1sSiXIqh7Vemf3BoSwt5Z33QiJcdakNZAhFJkRskYKV5HKt8MlJpgSdtSBdndNUWA4WeS0smBDlsGJ/e6utKiv/hYbzkxhlXprm2siTqIvrIyDGypnkvMfjdvc+cKVnAE0HfC7U1NcB3sYZiINqbWuMAApi46smiYCCbwX4De04MH3jP4cmOtuxG22Eg28qqulFoFhBcYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq+OP6wvz3KadcFsXcF7I/ROjCb0LoNaDYOBQPgroeI=;
 b=j0x8NxIIIuclvDbbvGSpclNlrFAL5yRwwoaqbHsguxEIxUHWjhlGkFTnSlc+0c/GRL19yle091ZucOtl17IURGmFkjysZVKlOaoQJ3jWLbzBVkbfSK60Mzl2rY8FBZOACNhRa7o5EpV7o3hkEYcmTH3OjZ0LHysxXJyiVOVz4QXBYmFJWaNfsJP7G3bl93V6K8b/NCgdh+jMZ+fKvOorc8WcysadH0wGzO1bMW7IsVxVDPrj/kTTKyYKRwmt/oKf+vLfufEiq0ndSMAoQEg5ZMFsVttByQRCyUZf1vWrikFbvZdzyGy0DdpZQq8PVlxdQqPyyByrLsXPs8zfVo4ckw==
Received: from CH0PR03CA0348.namprd03.prod.outlook.com (2603:10b6:610:11a::23)
 by PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 14:47:44 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::31) by CH0PR03CA0348.outlook.office365.com
 (2603:10b6:610:11a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 14:47:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 14:47:44 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 07:47:29 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 07:47:19 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 9 Apr
 2026 07:47:18 -0700
From: Gal Pressman <gal@nvidia.com>
To: <dwarves@vger.kernel.org>
CC: Gal Pressman <gal@nvidia.com>
Subject: [PATCH dwarves] man-pages: Fix incorrect command line argument in documentation
Date: Thu, 9 Apr 2026 17:47:18 +0300
Message-ID: <20260409144718.1582227-1-gal@nvidia.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a58f257-8b89-4d19-3743-08de9646f5c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ahWrhLWixJethdESrbJQrpzaXPQAiDRVUiyVU9KXrJaEsi5kPcV2GsdEtikhzrQ9kcxs50GyTSadDJ+cuG+HgRwEIUVUkA0Eyf3RA2PmPvX1xasoWlNNnIfkfvVM9oCnqKn32/zAUv+yp1OGij0+vG9W3HtV8l4+KTCzZ9hEYkM/x+EPyFWM7KDgND+5rK9FhjvM9sAly5Mqz0UAzQi0Zuz31B+72mUFbYd1ti2wpMPMqaZxivA8A1wUcKnaL8NjnJROyDAwhbCqg3IbfsjICX+uvE4fqX37bBwqUByBLcqvIZ+7S7GWjf9x6jWIKTFFPoCnpard5/knHw3YlIKe7v/ImduQw4oytMO5EYJWcHWeVgrhq5ZG+YEB8WgCsdx3ARcpAIr+uM82c43fAoDD5DYu5G4G6rLfjTh21zJb1z4id/oF+1p+SP7rYpKSMVMGecfk+UGNbBTKb+z0TxZGuv5RPzl3IIWAaPqHZeUaUvpWiSv7CVVG9fJsav5TDHENZgRm20Lf7amyT34GXkBLJx9IVjREKl5DLuuSbTBPM1n6+86/8HsweqLLK13zZ+00ZFNBGt+B00nuje0xtniJ+xxHEELaHlU7/05o/xXQBpwpOJNvuXu0LqNImaqzteciYtk0C0ylN2DI7mirc6gCrF8Sxa6JuzGprfsZVLlmz6pL1gczuCpSAsNhXcyZN8mi+v3iT4RymmqPpb0Im4pWQb1DQleCyINXoH8q3I6giyM9kiBk6Nh8MGXMogbFFyv3ghpBI7Tmr8nt1jA/21WJKA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ls8KTFhXJaGLWwIPha7iE6F2GgAJWrAa5yJ9mPsnsABOeWPC1L2Oc5l2TgJd/RlM4qUKbzO4Wc8aVocJURQRgNQYIpIfznEnWyYr6SoZIP4tyYDLjWnQbLkJVf3Z1/mtRNrNRNir0QfXA5rcsbLWBROTH/1UOah+VeEnz2GipdhqYQtMGtgtEQ7o0aptJ7Mt7u6RZAY+9HlF09mQt5qjadBwhbgcPmOVVBT8ex3JJv5MR1kZJxI37/g1K1hFOR9A6d3W1kV2+PYSkiXZ2eq13K7NSIPjW4jqkaJ6u84sO4ufX0vCVAVjP/erytlG4PiNkD6VAf2Km64JQqov0VpjpT1vMHxFIYeJHvKoXL6hdEcwfpMghZyNb5NG03WS9FWFb+q1yZDHi4CL6DPOTOcZk3/efCsmhESbqLKuljCZPNwYWKl+f6/78N+38omNDKiA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:47:44.6562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a58f257-8b89-4d19-3743-08de9646f5c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259

The --with_flexible_array and --with_embedded_flexible_array arguments
were wrongly documented with the short argument '-P' (copy-paste mistake
from previous argument), remove it.

Fixes: 7eea706c1499 ("pahole: Introduce --with_flexible_array option to show just types ending in a flexible array")
Fixes: 446c28d118b9 ("pahole: Introduce --with_embedded_flexible_array")
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 man-pages/pahole.1 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 90a8f4566de6..19067f4fef03 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -404,11 +404,11 @@ Show only structs that has holes that can be packed if members are reorganized,
 for instance when using the \fB\-\-reorganize\fR option.
 
 .TP
-.B \-P, \-\-with_flexible_array
+.B     \-\-with_flexible_array
 Show only structs that have a flexible array.
 
 .TP
-.B \-P, \-\-with_embedded_flexible_array
+.B     \-\-with_embedded_flexible_array
 Show only structs that have an embedded flexible array, i.e. a contained struct that has flexible arrays, a flexible array "in the middle".
 
 .TP
-- 
2.52.0

