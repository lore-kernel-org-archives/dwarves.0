Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D4E1EB25
	for <dwarves@vger.kernel.org>; Tue, 27 Feb 2024 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039692; cv=none; b=KNW139IwvJSDoep/7ai4m4FW4O6hhxRn16qaI/hiCnF/Vw89uLAvKo49vmXhGBCK5eGDmlu4WyGl8kBmWl1+/5P2TBVnECGvk7v7eAT7EaFnBaMfn1xV7AGiz2v6kVq4E8hWZZuAQm5KmZObnDqCMrSoncdlFxoHi4uYMM73Oi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039692; c=relaxed/simple;
	bh=o41yAmQkDwpyx4SuFW5SqKaXcr2EHZxDvU/0pMF+02A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTerUzPUEyS/sjFtpe4EixBCVgaBZyjCtI52cZClILIQdcO+1kRUEyG7OKsQr3x0ZsVwNLOu3wQKyChYpZ11sdUm1NqAzWq7WdtTgb8mHnuBYVVNl5Gidjq9mlx+oNdCFPuF4IdzSWnNdzOsav7cBMSMLv/4QQp1DZUl0OX9obs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUMxXREa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUMxXREa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128D1C433C7;
	Tue, 27 Feb 2024 13:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709039691;
	bh=o41yAmQkDwpyx4SuFW5SqKaXcr2EHZxDvU/0pMF+02A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUMxXREaq1O6QJvKrs/NGYOvipVszW7XZn7s2Su+oK+cc6ZZG7YJ9DaEon+AfdS4k
	 4EHiYG1mju4tgeEVHvRVh/57HZnZRiatAw9mjxJQORaH90Iu9R2GzRMNmhLXTUWoaC
	 9aAgh9W1VJ1StQ2OssLmqSlvb3/wZUj4PsequFbmG/M3OFler2+pnRokSKVd8JYDPs
	 SlN/0MqvhBwwFTdSb2qGYCBWVBRx7yYZIG4X7PcimIC6j2Xm+4HyrXPQsf+jb4opbS
	 ZZ9kcy3kNghpG1kjuZwKEYWoOTZb7GlrPvu46phMsFabsyF4PhU/EjzPiQWu/tJs7l
	 t2vGVxHJTM/yQ==
Date: Tue, 27 Feb 2024 10:14:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: J B <jb.1234abcd@gmail.com>
Cc: dwarves@vger.kernel.org
Subject: Re: pahole Version 1.25-4 dumps
Message-ID: <Zd3gSG7v3web_rM2@x1>
References: <CAJXMFhFbv5MccigKvmQt9MhYwKv2iyigEG3Bhs64BZ=PMWc0WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJXMFhFbv5MccigKvmQt9MhYwKv2iyigEG3Bhs64BZ=PMWc0WQ@mail.gmail.com>

On Mon, Feb 26, 2024 at 09:09:34AM +0100, J B wrote:
> H,i
> some random tests:

⬢[acme@toolbox pahole]$ git diff
diff --git a/syscse.c b/syscse.c
index 4a5b199b7a636b9f..b09c8564759dab76 100644
--- a/syscse.c
+++ b/syscse.c
@@ -18,6 +18,12 @@
 static const char *prefix = "sys_";
 static size_t prefix_len = 4;
 
+static struct conf_fprintf conf;
+
+static struct conf_load conf_load = {
+        .conf_fprintf = &conf,
+};
+
 static bool filter(struct function *f)
 {
        if (f->proto.nr_parms != 0) {
@@ -156,7 +162,7 @@ int main(int argc, char *argv[])
                 argp_help(&argp, stderr, ARGP_HELP_SEE, argv[0]);
                 return EXIT_FAILURE;
        }
-       err = cus__load_files(cus, NULL, argv + remaining);
+       err = cus__load_files(cus, &conf_load, argv + remaining);
        if (err != 0) {
                cus__fprintf_load_files_err(cus, "syscse", argv + remaining, err, stderr);
                return EXIT_FAILURE;
⬢[acme@toolbox pahole]$ syscse bla
syscse: bla: Invalid argument
⬢[acme@toolbox pahole]$ syscse blaadsfafa
syscse: blaadsfafa: Invalid argument
⬢[acme@toolbox pahole]$

At some point conf_load became non-optional for:

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff7f4b1ed in dwarf__load_file (cus=0x4052a0, conf=0x0, filename=0x7fffffffe4c3 "bla") at /home/acme/git/pahole/dwarf_loader.c:3626
3626		if (conf->max_hashtable_bits != 0) {
Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.8-16.fc39.x86_64 elfutils-libelf-0.190-4.fc39.x86_64 elfutils-libs-0.190-4.fc39.x86_64 glibc-2.38-16.fc39.x86_64 libgcc-13.2.1-6.fc39.x86_64 libzstd-1.5.5-4.fc39.x86_64 xz-libs-5.4.4-1.fc39.x86_64 zlib-1.2.13-4.fc39.x86_64
(gdb) bt
#0  0x00007ffff7f4b1ed in dwarf__load_file (cus=0x4052a0, conf=0x0, filename=0x7fffffffe4c3 "bla") at /home/acme/git/pahole/dwarf_loader.c:3626
#1  0x00007ffff7f310f5 in cus__load_file (cus=0x4052a0, conf=0x0, filename=0x7fffffffe4c3 "bla") at /home/acme/git/pahole/dwarves.c:2074
#2  0x00007ffff7f31ca1 in cus__load_files (cus=0x4052a0, conf=0x0, filenames=0x7fffffffe1c0) at /home/acme/git/pahole/dwarves.c:2577
#3  0x000000000040177a in main (argc=2, argv=0x7fffffffe1b8) at /home/acme/git/pahole/syscse.c:159
(gdb)

Thanks for the report, I'll add it.

- Arnaldo
 
> $ ls test.txt
> /usr/bin/ls: cannot access 'test.txt': No such file or directory
> $ syscse test.txt
> Segmentation fault (core dumped)
> $ coredumpctl info
>        Signal: 11 (SEGV)
>                 Stack trace of thread 48074:
>                 #0  0x00007624fb32430b n/a (libdwarves.so.1 + 0x5b30b)
>                 #1  0x00007624fb30b2ff cus__load_file (libdwarves.so.1 + 0x422f>
>                 #2  0x00007624fb312af9 cus__load_files (libdwarves.so.1 + 0x49a>
>                 #3  0x000063ada590a093 main (syscse + 0x1093)
>                 #4  0x00007624fb10ccd0 n/a (libc.so.6 + 0x25cd0)
>                 #5  0x00007624fb10cd8a __libc_start_main (libc.so.6 + 0x25d8a)
>                 #6  0x000063ada590a165 _start (syscse + 0x1165)
>                 ELF object binary architecture: AMD x86-64
> $ touch test.txt
> $ syscse test.txt
> Segmentation fault (core dumped)
> $ <as above>
> $ syscse /boot/vmlinuz-linux
> Segmentation fault (core dumped)
> $ <as above>
> 
> jb
> 
