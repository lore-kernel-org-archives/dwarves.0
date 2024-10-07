Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79A418D642
	for <dwarves@vger.kernel.org>; Mon,  7 Oct 2024 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332738; cv=none; b=UXQGTlOKrclSpkRuudJx47xWIuHs/uTtcB8eM/7a7sePPXqvMEPwYlNsYDXvYRXClOrypoM+sf0Slo7KhPxHocR/37O0dN9QHEhRjh0i3ODPiaJuDkaYa/e2r2JHVcd0OxXpmCcPpkhsi7olFqOJ+0NTT22EvMgB4dQ836QlA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332738; c=relaxed/simple;
	bh=MQQcjRVg3tKe+KxTht4GTbez0KgnRw2AFMsmPHWq0sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qb5UMmqGsFX/wsyJp5BKG8cKoxyL47qa2782EIZoBR8L6UsWOGPoaYgKDmQbS0i3fQTlxlbZDnBGAp1tNoFdniRkSCPhZUxl7jE9+HWqIKxbvl9hBa/8+rxUOjBSWMU6YRnzJqcY02W/2Qhw+u8ke0FzneuhgoHPOhBVCtBpiws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GO75mzxw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GO75mzxw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134F2C4CEC6;
	Mon,  7 Oct 2024 20:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728332738;
	bh=MQQcjRVg3tKe+KxTht4GTbez0KgnRw2AFMsmPHWq0sQ=;
	h=From:To:Cc:Subject:Date:From;
	b=GO75mzxwur+zpFgKgqE1D6ogU3qo0qObAiOj6z9Ecw2DwjJO5X6MFcZ1LglblBjld
	 HgP+XDyu0/BYVGla0XqoZWDZkc3jOe3LHTFem43khJw6BTD59fTMu/f+aRPro1XUCV
	 YbwHvL5DCI1N94EsHb+rcCWdsX9fZuuqMNicJ9SIknCum8dXEw37mUvn7yb2XB6eTC
	 fUTxARdkY7HQOyT5gPS1rS39k18DLHx7MC2QV9EO3iFLIZhzybdIzie4TCSuhrHfo2
	 na+MXc7zIWEDbE5doY5OtZW7UNf5wi+VPYn+ekkqrn79ZSNDuiU05KmOjzQ8kWyNxX
	 vRqyJafuZQJPw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH RFC 0/5] pahole --with_embedded_flexible_array
Date: Mon,  7 Oct 2024 17:25:26 -0300
Message-ID: <20241007202531.942648-1-acme@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Willy, Gustavo,

	Please take a look, there are still some odd cases where the
comment is not being emitted but _there_ is a flexible array inside the
struct marked as having a flexible array "in the middle" (by means of
an embedded struct that _has_ a flexible array.

	This helps with one other case Gustavo talked about at KR.

	Please take a look and give it some testing, please.

- Arnaldo

Arnaldo Carvalho de Melo (5):
  core: Move class__has_flexible_array() from pahole to the core
  core: Cache info about flexible arrays in class__has_flexible_array()
  core: Introduce class__has_embedded_flexible_array()
  fprintf: Add a comment if a member type has an embedded flexible array
  pahole: Introduce --with_embedded_flexible_array

 dwarves.c          | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 dwarves.h          |  6 ++++
 dwarves_fprintf.c  | 12 ++++++--
 man-pages/pahole.1 |  4 +++
 pahole.c           | 36 ++++++++--------------
 5 files changed, 109 insertions(+), 26 deletions(-)

-- 
2.46.2

