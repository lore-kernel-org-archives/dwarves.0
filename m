Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF20941228
	for <dwarves@vger.kernel.org>; Wed, 20 Sep 2023 20:15:42 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63BCCE
	for <dwarves@vger.kernel.org>; Wed, 20 Sep 2023 13:15:39 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-770ef0da4c2so9401285a.3
        for <dwarves@vger.kernel.org>; Wed, 20 Sep 2023 13:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695240939; x=1695845739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KjiggUyQYaXdrX5h9h6CEmaZNsBN7wNveaVEjl3faww=;
        b=gzcneh+E/b39WZFZXupKfrJrFkgyKJK9LLcVsVadvicyjNcx3Oqe/r5Ae8yqn1Sqf6
         aUlogDFXfVuZkuF13TiSBw9uZGqlk69veUO4L6dG75tVnFfk7zpzik86CadtK7IbzHO5
         LWUP49N5s65Z48Fyi6pNFIOpU0lXEfIaWhOxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695240939; x=1695845739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjiggUyQYaXdrX5h9h6CEmaZNsBN7wNveaVEjl3faww=;
        b=Io6vIzbEnv0ZNXqN1JciN2liETCa9SP75VYAfunufrzLzu14gIhH/4lOBflIrzkDlm
         goYfzGDU47RfHHhhXRRgUgkXgmpRZQazg0BwysowOwvbt4fCs0hyI0QGVxugvyMgLuWC
         /ktNwK3zdfXy9nVYqqclveJ/xZmno4U40tV5/ydJYnNe5Xfn+4gbvNzmBbMuJl+Zmddp
         b2tDdDDUjV/szszcOB3Hf85hlz32bCl/N8ktQXtN0IapCDAHogv7mCuFlQJxcQbvm/2d
         cPpQXGQli3ct3SKSOlbs3mJW9fbpaqYeHNGiOz2cN5f0Q/KdvmmOOj8vuBecB8cAVNXo
         pR2w==
X-Gm-Message-State: AOJu0Yzyur5CwFTgsl7lrVy1T6s3F8prcSg4fqxKXDQOK403mceLMHYm
	hhhy2HODIWif+8dIQUwCTWtz4LlRefT1qV1aFAY=
X-Google-Smtp-Source: AGHT+IGzk01VxcNRtiMCm3IRpOiOofgFrIbB2ochwvXCEJnvd8LLC832yOxk2yPa78lhoBtatxrQnA==
X-Received: by 2002:a05:620a:2943:b0:772:6419:89ab with SMTP id n3-20020a05620a294300b00772641989abmr4647613qkp.55.1695240938672;
        Wed, 20 Sep 2023 13:15:38 -0700 (PDT)
Received: from meerkat.local ([209.226.106.110])
        by smtp.gmail.com with ESMTPSA id t2-20020a05620a034200b0076ce061f44dsm5369qkm.25.2023.09.20.13.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 13:15:38 -0700 (PDT)
Date: Wed, 20 Sep 2023 16:15:29 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: dwarves@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, linux-rtc@vger.kernel.org, linux-trace-devel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: This list is being migrated to new infrastructure
Message-ID: <20230920-ligament-cortex-6344a0@meerkat>
References: <20230920-uncouple-grime-729f33@meerkat>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230920-uncouple-grime-729f33@meerkat>
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	SUSPICIOUS_RECIPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 03:52:05PM -0400, Konstantin Ryabitsev wrote:
> Hello, all:
> 
> This list is being migrated to the new vger infrastructure. This should be a
> fully transparent process and you don't need to change anything about how you
> participate with the list or how you receive mail.
> 
> There will be a brief 20-minute delay with archives on lore.kernel.org. I will
> follow up once the archive migration has been completed.

This work is now completed. I will monitor the performance to make
sure that the new infrastructure is still successfully coping with the
email traffic.

If you notice any problems, please report them to helpdesk at kernel.org.

-K
