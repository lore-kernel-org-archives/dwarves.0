Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9355148FE8
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 20:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732047355; cv=none; b=kHtj9i6yc8TCbZW09/8kHQ6hVuV2xka4Ozz3gmL2DwoiSrNgFEiR6SFL8j6foKmYkyrWeueivP84oC1qVi1yOcZcg07gT2bZzeFuxts6JgoapEi1oWYKb988FmVml1VTUJtwo+7qMSTSZ7ilenmXauAf9l8xM9b6RvsXN5VlthY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732047355; c=relaxed/simple;
	bh=EvNPehYclA9SU4ah/9rE+5/YfMSGKJvgu1DJZ6FYawg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZIUqpOIimk7Iw4NLdvRUzpVd8nlo1Fsg/lLLQMHZfbRgflElwTQRC2QWshKn6bliqgoKg5iTjR6dCsc+S7aPkiWAyIcRDnKG2KitgJdcukxXdd9Hx01PuU+3m3c/AuzonKGns3bcrlnKjU0J05+RDfugyBfCb+kzmcOYv/Ef+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2nQLCiV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2nQLCiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898D0C4CECF;
	Tue, 19 Nov 2024 20:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732047355;
	bh=EvNPehYclA9SU4ah/9rE+5/YfMSGKJvgu1DJZ6FYawg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2nQLCiVWhQTwYbLMcia/NX6o5JzvpsxkAFh3CvpCOifc9jj1xpyURc6Cw6P+aD2l
	 xz6kfmSd2f9n8/fRnr2OXJmk2Hp9cshzWcJbn5GlkamyueGcxlU3rQgEYjXLu2A0Pj
	 UKzsz3y/DlxuBzwukHn0ulsSEOgJcM1eIak87VQ9dXz+hfZAi7bk6UFw01wByKTS1V
	 Yi6l57bBWJQXQ0+0wPYad3/X9BePQIvakkabRnAPlVBVCNcCj+JjfaZHMDShU+YaYg
	 kjn0chRXBzLV7JADQcQceYoQSYnZVCI+tnZCypc+xg3lrpQGWwl5PRpB7z0BBDQSVB
	 sx8q+F+yIN6+Q==
Date: Tue, 19 Nov 2024 17:15:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, dwarves@vger.kernel.org
Subject: Re: [PATCH 2/5] tests default_vmlinux_btf: Introduce test for using
 BTF by default
Message-ID: <Zzzx9luQUEv_V7iG@x1>
References: <20241118204146.772762-1-acme@kernel.org>
 <20241118204146.772762-3-acme@kernel.org>
 <33b85d2c1adafb5a46a874dfcfd43682395e1564.camel@gmail.com>
 <ZzzrsLQCF9hYtT7P@x1>
 <020ec6550eb5e73bb5a273c57a686565a0a274df.camel@gmail.com>
 <ZzzxNrJ51E2dIAGJ@x1>
 <acff9e62b537ddb657cba04d3755db5b86cdfd86.camel@gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acff9e62b537ddb657cba04d3755db5b86cdfd86.camel@gmail.com>

On Tue, Nov 19, 2024 at 12:13:56PM -0800, Eduard Zingerman wrote:
> On Tue, 2024-11-19 at 17:12 -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Nov 19, 2024 at 11:54:12AM -0800, Eduard Zingerman wrote:
> > > On Tue, 2024-11-19 at 16:49 -0300, Arnaldo Carvalho de Melo wrote:
> > > 
> > > [...]
> > > 
> > > > > Lgtm.
> > 
> > And I'm taking the lgtm as an Acked-by, maybe a Reviewed-by?
> 
> Sorry for confusion, let's go with Acked-by.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Thats what I tentatively had added, and already pushed to the next
branch, thanks!

- Arnaldo
