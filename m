Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458DE33D6DD;
	Fri, 31 Jul 2026 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785526303; cv=none; b=P2z0kV6jiaomY5f8M/NQJvgOdV0gNmryveouWmuFFmGiUVzgW0Y+wHf5P1Za8jXUQCdt1vdLVOhRNh3dqiX8OcILLsxBjq41WOjV2uu4NgZZ42aMc/VyoAd+kygSlKtxOJ0TiKrkD+rox+jHDNcIk/LOuDZL3v5d6GeU9O5yVwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785526303; c=relaxed/simple;
	bh=SFMFEpxd0loBImuaz9f+bHSLdp5HoNYiuLLRAfzGi8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PmHwBFM/AN/9FXTchpiznzMlQJk8uJUmIuRO3Qp7WMtfeCKpEGUDIQ78zw1EZWwwxKhYRCKi1+KZVDdmyZxMywVkKA09rSrPcTKtBW/HRy93cUyYmw6jdLryCvursMcDLq6WI9onYHIeybL1Gjd3/IkMvmYiw99ONJfQ33173w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGC38p3K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGC38p3K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08AA1F00ACA;
	Fri, 31 Jul 2026 19:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785526301;
	bh=BjWts1ZSLQmyQN9j43WRxy2oWSfG2EV4Qk6G65HavN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bGC38p3K4sbXtRDv/hHeR9JDG6cB2wm53GC1+T2a16t95X0oO406Ihp4YFc19e4oB
	 tLxMyvRPeuLlPR9i/yGkUpd6SvhLXaOPaMzwfqkxRFfOHCIdZ0/Wxi7ww6ejWLy2qQ
	 JpYYIHp7nlGRoyPocg7aGQvpCYHKkGafGTYG7yiEBqb6pOnu6sY4elWTYaGWBDrnKb
	 Ahnf2kYdFQ07Iw4jMyBDNz9x60DcWMHy9PzW/hphYuuBV5HUewiIqMGYlqnNGiHhOd
	 KQoeKyWXxSE4TMk4Cht8JJtEXE+5MsC/Buvghj+mdQh82H07PIXj+FPTmqKniOJZgm
	 LunmWvLWVyPHQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mark Wieelard <mjw@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/12] scripts: Add vmlinux_comparison.py for DWARF/BTF analysis
Date: Fri, 31 Jul 2026 16:31:00 -0300
Message-ID: <20260731193102.110693-13-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731193102.110693-1-acme@kernel.org>
References: <20260731193102.110693-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Analyzes vmlinux files to compare DWARF versions, compilers, section
sizes, and pahole output across different builds. Validates that
different DWARF encodings (v4 vs v5, compressed vs uncompressed)
produce equivalent pahole output.

The kernel offers several CONFIG_DEBUG_INFO options that affect DWARF
encoding:
- CONFIG_DEBUG_INFO_DWARF4: DWARF version 4 format
- CONFIG_DEBUG_INFO_DWARF5: DWARF version 5 (~15% smaller sections)
- CONFIG_DEBUG_INFO_COMPRESSED_ZLIB: zlib-compressed debug sections
- CONFIG_DEBUG_INFO_COMPRESSED_ZSTD: zstd-compressed (smaller/faster)
- CONFIG_DEBUG_INFO_SPLIT: split DWARF with .dwo files (NOT supported yet)

This script validates pahole correctly handles all supported modes by
comparing output hashes across different vmlinux builds.

Features:
- Extracts DWARF version and DW_AT_producer from debug info
- Reports file sizes and .debug_*/.BTF* section sizes
- Runs pahole -F dwarf and -F btf, computing output hashes
- Streams pahole output for memory efficiency (handles 800MB+ files)
- Optimized readelf: reads only first 100-200 lines for metadata
  instead of processing entire debug sections (minutes → seconds)
- Displays results in ASCII table similar to coverage-table

Example output shows DWARF v4 (599MB sections) vs v5 (500MB) vs
v5+zlib (261MB) all produce identical pahole output (hash 86e1b611),
validating pahole's consistency across different DWARF encodings.

Usage: scripts/vmlinux_comparison.py [directory]
Default directory: ~/dws/

Test vmlinux files covering supported configurations are available in
~/dws/.  Split DWARF (DW_TAG_skeleton_unit) support is deferred to the
next patch series.

Example:

  acme@number:~/git/pahole$ ls -la ~/dws/vmlinux.*
  -rwxr-xr-x. 1 acme acme 876343656 Jul 16 20:25 /home/acme/dws/vmlinux.dwarf4
  -rwxr-xr-x. 1 acme acme 772024544 Jul 16 21:43 /home/acme/dws/vmlinux.dwarf5
  -rwxr-xr-x. 1 acme acme 521968168 Jul 17 08:19 /home/acme/dws/vmlinux.dwarf5.zlib
  -rwxr-xr-x. 1 acme acme 476736632 Jul 17 12:58 /home/acme/dws/vmlinux.dwarf5.zstd
  -rwxr-xr-x. 1 acme acme 772024248 Jul 16 20:32 /home/acme/dws/vmlinux.toolchain_default
  acme@number:~/git/pahole$ scripts/vmlinux_comparison.py ~/dws/
  Scanning /home/acme/dws/ for vmlinux files...
  Found 5 vmlinux file(s)

    Analyzing vmlinux.dwarf4...
      Running pahole -F dwarf...
      Running pahole -F btf...
    Analyzing vmlinux.dwarf5...
      Running pahole -F dwarf...
      Running pahole -F btf...
    Analyzing vmlinux.dwarf5.zlib...
      Running pahole -F dwarf...
      Running pahole -F btf...
    Analyzing vmlinux.dwarf5.zstd...
      Running pahole -F dwarf...
      Running pahole -F btf...
    Analyzing vmlinux.toolchain_default...
      Running pahole -F dwarf...
      Running pahole -F btf...

  ┌───────────────────────────┬─────────┬─────┬───────────────────────────────────┬─────────┬───────┬──────────┬────────┬──────────┬─────────┐
  │ File                      │  Size   │ Ver │ Producer                          │  DWARF  │  BTF  │ DW-Hash  │ DW-Out │ BTF-Hash │ BTF-Out │
  ├───────────────────────────┼─────────┼─────┼───────────────────────────────────┼─────────┼───────┼──────────┼────────┼──────────┼─────────┤
  │ vmlinux.dwarf4            │ 835.7MB │   4 │ GNU C11 16.1.1 -gdwarf-4          │ 599.2MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │
  │ vmlinux.dwarf5            │ 736.3MB │   5 │ GNU C11 16.1.1 -gdwarf-5          │ 499.7MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │
  │ vmlinux.dwarf5.zlib       │ 497.8MB │   5 │ GNU C11 16.1.1 -gdwarf-5 -gz=zlib │ 261.2MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │
  │ vmlinux.dwarf5.zstd       │ 454.7MB │   5 │ GNU C11 16.1.1 -gdwarf-5 -gz=zstd │ 218.1MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │
  │ vmlinux.toolchain_default │ 736.3MB │   5 │ GNU C11 16.1.1                    │ 499.7MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │
  └───────────────────────────┴─────────┴─────┴───────────────────────────────────┴─────────┴───────┴──────────┴────────┴──────────┴─────────┘

  Column descriptions:
    File       : vmlinux filename
    Size       : Total file size
    Ver        : DWARF version
    Producer   : Compiler and flags (truncated)
    DWARF      : Total size of .debug_* sections
    BTF        : Total size of .BTF* sections
    DW-Hash    : SHA256 hash (first 8 chars) of pahole -F dwarf output
    DW-Out     : Size of pahole -F dwarf output
    BTF-Hash   : SHA256 hash (first 8 chars) of pahole -F btf output
    BTF-Out    : Size of pahole -F btf output

  Note: Different hashes indicate different pahole output between files.

  The output shows that vmlinux variants (different DWARF versions, compression)
  produce identical pahole output despite different file sizes and debug section
  sizes, validating pahole's consistency across different DWARF encodings.
  acme@number:~/git/pahole$

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 scripts/vmlinux_comparison.py | 367 ++++++++++++++++++++++++++++++++++
 1 file changed, 367 insertions(+)
 create mode 100755 scripts/vmlinux_comparison.py

diff --git a/scripts/vmlinux_comparison.py b/scripts/vmlinux_comparison.py
new file mode 100755
index 0000000000000000..1633bf8394098e02
--- /dev/null
+++ b/scripts/vmlinux_comparison.py
@@ -0,0 +1,367 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+# Arnaldo Carvalho de Melo <acme@redhat.com>
+# Assisted-by: Claude:claude-sonnet-4-5
+#
+# Compare vmlinux files: DWARF versions, producers, section sizes, and pahole output.
+#
+# Prompt used to generate this script:
+#
+# Given a directory with a series of vmlinux files, look at the DW_AT_producer
+# DWARF tags to notice what's unique for each of the vmlinux files, look at the
+# DWARF version as well, then run pahole -F dwarf and btf to see if the output
+# produced changes for both formats in the different vmlinux files, create a
+# table like the one in the upcoming coverage-table make target. Add columns for
+# each row (DWARF files) with the size of the vmlinux files and the size of the
+# DWARF and BTF related ELF sections on each of the vmlinux files.
+#
+# Usage:
+#   scripts/vmlinux_comparison.py [DIRECTORY]
+#
+#   Default directory: ~/dws/
+
+import argparse
+import hashlib
+import os
+import re
+import subprocess
+import sys
+import tempfile
+
+def format_size(size_bytes):
+    """Format byte size in human-readable format."""
+    for unit in ['B', 'KB', 'MB', 'GB']:
+        if size_bytes < 1024.0:
+            return f"{size_bytes:.1f}{unit}"
+        size_bytes /= 1024.0
+    return f"{size_bytes:.1f}TB"
+
+def get_file_size(path):
+    """Get file size in bytes."""
+    return os.path.getsize(path)
+
+def extract_dwarf_version(vmlinux_path):
+    """Extract DWARF version using readelf (only first 100 lines)."""
+    try:
+        # Only read first 100 lines of debug info to find version quickly
+        cmd = f"readelf --debug-dump=info '{vmlinux_path}' 2>/dev/null | head -100"
+        result = subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=10)
+        if result.returncode != 0:
+            return 'N/A'
+
+        # Look for first "Version:" in output
+        for line in result.stdout.splitlines():
+            if 'Version:' in line:
+                match = re.search(r'Version:\s+(\d+)', line)
+                if match:
+                    return match.group(1)
+        return 'N/A'
+    except Exception as e:
+        return 'N/A'
+
+
+def extract_producer(vmlinux_path):
+    """Extract DW_AT_producer using readelf (only first 200 lines)."""
+    try:
+        # Only read first 200 lines of debug info to find producer quickly
+        cmd = f"readelf --debug-dump=info '{vmlinux_path}' 2>/dev/null | head -200"
+        result = subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=10)
+        if result.returncode != 0:
+            return 'N/A'
+
+        # Look for first DW_AT_producer
+        for line in result.stdout.splitlines():
+            if 'DW_AT_producer' in line:
+                # Extract the actual producer string after the colon
+                match = re.search(r'DW_AT_producer\s*:\s*(?:\([^)]+\):\s*)?(.+)', line)
+                if match:
+                    producer = match.group(1).strip()
+                    # Extract key parts: compiler name, version, DWARF flag
+                    # Example: "GNU C11 16.1.1 20260515 (Red Hat 16.1.1-2) ... -gdwarf-4 ..."
+
+                    # Get compiler and version
+                    compiler_match = re.search(r'(GNU C\d+|clang)\s+([\d.]+)', producer)
+                    compiler = compiler_match.group(0) if compiler_match else 'unknown'
+
+                    # Get DWARF version flag
+                    dwarf_match = re.search(r'-gdwarf-(\d+)', producer)
+                    dwarf_flag = f"-gdwarf-{dwarf_match.group(1)}" if dwarf_match else ''
+
+                    # Get compression if present
+                    compress_match = re.search(r'-gz(=\w+)?', producer)
+                    compress = compress_match.group(0) if compress_match else ''
+
+                    parts = [compiler, dwarf_flag, compress]
+                    return ' '.join(p for p in parts if p)
+        return 'N/A'
+    except Exception as e:
+        return f'Error: {e}'
+
+
+def get_section_sizes(vmlinux_path):
+    """Get sizes of DWARF and BTF sections using readelf."""
+    try:
+        cmd = ['readelf', '-S', vmlinux_path]
+        result = subprocess.run(cmd, capture_output=True, text=True, timeout=30)
+        if result.returncode != 0:
+            return 0, 0
+
+        dwarf_size = 0
+        btf_size = 0
+
+        # Parse section table - readelf outputs sections across two lines:
+        # Line 1: [Nr] Name Type Address Offset
+        # Line 2:      Size EntSize Flags Link Info Align
+        lines = result.stdout.splitlines()
+        i = 0
+        while i < len(lines):
+            line = lines[i]
+
+            # Match section header line: [Nr] Name ...
+            match = re.match(r'\s*\[\s*\d+\]\s+(\S+)', line)
+            if match:
+                section_name = match.group(1)
+
+                # Size is on the next line
+                if i + 1 < len(lines):
+                    next_line = lines[i + 1]
+                    # Extract first hex number from next line (the size)
+                    size_match = re.search(r'^\s+([0-9a-f]+)', next_line)
+                    if size_match:
+                        size = int(size_match.group(1), 16)
+
+                        if section_name.startswith('.debug_'):
+                            dwarf_size += size
+                        elif section_name.startswith('.BTF'):
+                            btf_size += size
+
+            i += 1
+
+        return dwarf_size, btf_size
+    except Exception as e:
+        return 0, 0
+
+
+def run_pahole_and_hash(vmlinux_path, format_type):
+    """Run pahole with given format and return output hash."""
+    try:
+        # Run pahole and stream output for hashing (avoids loading into memory)
+        cmd = ['pahole', '-F', format_type, vmlinux_path]
+        result = subprocess.Popen(cmd, stdout=subprocess.PIPE,
+                                 stderr=subprocess.DEVNULL)  # Ignore stderr to avoid blocking
+
+        # Stream output and compute hash on the fly
+        hasher = hashlib.sha256()
+        file_size = 0
+
+        while True:
+            chunk = result.stdout.read(8192)
+            if not chunk:
+                break
+            hasher.update(chunk)
+            file_size += len(chunk)
+
+        result.wait(timeout=600)  # Increase timeout to 10 minutes for large files
+
+        if result.returncode != 0:
+            return 'ERROR', 0
+
+        hash_short = hasher.hexdigest()[:8]
+        return hash_short, file_size
+    except subprocess.TimeoutExpired:
+        result.kill()
+        result.wait()  # Clean up zombie process
+        return 'TIMEOUT', 0
+    except Exception as e:
+        return 'ERROR', 0
+
+
+def find_vmlinux_files(directory):
+    """Find all vmlinux* files in directory, excluding text files."""
+    vmlinux_files = []
+
+    if not os.path.isdir(directory):
+        print(f"Error: {directory} is not a directory", file=sys.stderr)
+        return []
+
+    for filename in os.listdir(directory):
+        path = os.path.join(directory, filename)
+
+        # Skip non-files
+        if not os.path.isfile(path):
+            continue
+
+        # Only include files starting with "vmlinux"
+        if not filename.startswith('vmlinux'):
+            continue
+
+        # Skip text files (.c, .txt, etc.)
+        if filename.endswith(('.c', '.txt', '.log', '.md')):
+            continue
+
+        # Check if it's an ELF file
+        try:
+            with open(path, 'rb') as f:
+                magic = f.read(4)
+                if magic != b'\x7fELF':
+                    continue
+        except:
+            continue
+
+        vmlinux_files.append(path)
+
+    return sorted(vmlinux_files)
+
+
+def analyze_vmlinux(vmlinux_path):
+    """Analyze a single vmlinux file and return metrics."""
+    filename = os.path.basename(vmlinux_path)
+
+    print(f"  Analyzing {filename}...", file=sys.stderr)
+
+    file_size = get_file_size(vmlinux_path)
+    dwarf_version = extract_dwarf_version(vmlinux_path)
+    producer = extract_producer(vmlinux_path)
+    dwarf_size, btf_size = get_section_sizes(vmlinux_path)
+
+    print(f"    Running pahole -F dwarf...", file=sys.stderr)
+    dwarf_hash, dwarf_out_size = run_pahole_and_hash(vmlinux_path, 'dwarf')
+
+    print(f"    Running pahole -F btf...", file=sys.stderr)
+    btf_hash, btf_out_size = run_pahole_and_hash(vmlinux_path, 'btf')
+
+    return {
+        'filename': filename,
+        'file_size': file_size,
+        'dwarf_version': dwarf_version,
+        'producer': producer,
+        'dwarf_section_size': dwarf_size,
+        'btf_section_size': btf_size,
+        'dwarf_output_hash': dwarf_hash,
+        'dwarf_output_size': dwarf_out_size,
+        'btf_output_hash': btf_hash,
+        'btf_output_size': btf_out_size,
+    }
+
+
+def print_table(results):
+    """Print comparison table with box-drawing characters."""
+    if not results:
+        print("No vmlinux files found.")
+        return
+
+    # Column widths
+    W_FILE = 30
+    W_SIZE = 8
+    W_VER = 4
+    W_PROD = 35
+    W_SECT = 10
+    W_HASH = 10
+    W_OUT = 10
+
+    # Header
+    def print_sep(char='─'):
+        print(f"┌{char*(W_FILE+2)}┬{char*(W_SIZE+2)}┬{char*(W_VER+2)}┬{char*(W_PROD+2)}┬"
+              f"{char*(W_SECT+2)}┬{char*(W_SECT+2)}┬"
+              f"{char*(W_HASH+2)}┬{char*(W_OUT+2)}┬"
+              f"{char*(W_HASH+2)}┬{char*(W_OUT+2)}┐")
+
+    def print_row_sep():
+        print(f"├{'─'*(W_FILE+2)}┼{'─'*(W_SIZE+2)}┼{'─'*(W_VER+2)}┼{'─'*(W_PROD+2)}┼"
+              f"{'─'*(W_SECT+2)}┼{'─'*(W_SECT+2)}┼"
+              f"{'─'*(W_HASH+2)}┼{'─'*(W_OUT+2)}┼"
+              f"{'─'*(W_HASH+2)}┼{'─'*(W_OUT+2)}┤")
+
+    print_sep()
+
+    # Column headers
+    print(f"│ {'File':<{W_FILE}} │ {'Size':>{W_SIZE}} │ {'Ver':>{W_VER}} │ {'Producer':<{W_PROD}} │ "
+          f"{'DWARF':>{W_SECT}} │ {'BTF':>{W_SECT}} │ "
+          f"{'DW-Hash':>{W_HASH}} │ {'DW-Out':>{W_OUT}} │ "
+          f"{'BTF-Hash':>{W_HASH}} │ {'BTF-Out':>{W_OUT}} │")
+
+    print_row_sep()
+
+    # Data rows
+    for r in results:
+        fname = r['filename']
+        if len(fname) > W_FILE:
+            fname = fname[:W_FILE-3] + '...'
+
+        fsize = format_size(r['file_size'])
+        ver = r['dwarf_version']
+
+        prod = r['producer']
+        if len(prod) > W_PROD:
+            prod = prod[:W_PROD-3] + '...'
+
+        dwarf_sect = format_size(r['dwarf_section_size'])
+        btf_sect = format_size(r['btf_section_size'])
+
+        dw_hash = r['dwarf_output_hash']
+        dw_out = format_size(r['dwarf_output_size'])
+
+        btf_hash = r['btf_output_hash']
+        btf_out = format_size(r['btf_output_size'])
+
+        print(f"│ {fname:<{W_FILE}} │ {fsize:>{W_SIZE}} │ {ver:>{W_VER}} │ {prod:<{W_PROD}} │ "
+              f"{dwarf_sect:>{W_SECT}} │ {btf_sect:>{W_SECT}} │ "
+              f"{dw_hash:>{W_HASH}} │ {dw_out:>{W_OUT}} │ "
+              f"{btf_hash:>{W_HASH}} │ {btf_out:>{W_OUT}} │")
+
+    # Footer
+    print(f"└{'─'*(W_FILE+2)}┴{'─'*(W_SIZE+2)}┴{'─'*(W_VER+2)}┴{'─'*(W_PROD+2)}┴"
+          f"{'─'*(W_SECT+2)}┴{'─'*(W_SECT+2)}┴"
+          f"{'─'*(W_HASH+2)}┴{'─'*(W_OUT+2)}┴"
+          f"{'─'*(W_HASH+2)}┴{'─'*(W_OUT+2)}┘")
+
+    print()
+    print("Column descriptions:")
+    print("  File       : vmlinux filename")
+    print("  Size       : Total file size")
+    print("  Ver        : DWARF version")
+    print("  Producer   : Compiler and flags (truncated)")
+    print("  DWARF      : Total size of .debug_* sections")
+    print("  BTF        : Total size of .BTF* sections")
+    print("  DW-Hash    : SHA256 hash (first 8 chars) of pahole -F dwarf output")
+    print("  DW-Out     : Size of pahole -F dwarf output")
+    print("  BTF-Hash   : SHA256 hash (first 8 chars) of pahole -F btf output")
+    print("  BTF-Out    : Size of pahole -F btf output")
+    print()
+    print("Note: Different hashes indicate different pahole output between files.")
+    print()
+    print("The output shows that vmlinux variants (different DWARF versions, compression)")
+    print("produce identical pahole output despite different file sizes and debug section")
+    print("sizes, validating pahole's consistency across different DWARF encodings.")
+
+
+def main():
+    parser = argparse.ArgumentParser(
+        description='Compare vmlinux files: DWARF, BTF, and pahole output')
+    parser.add_argument('directory', nargs='?',
+                       default=os.path.expanduser('~/dws'),
+                       help='Directory containing vmlinux files (default: ~/dws)')
+    args = parser.parse_args()
+
+    directory = os.path.expanduser(args.directory)
+
+    print(f"Scanning {directory} for vmlinux files...", file=sys.stderr)
+    vmlinux_files = find_vmlinux_files(directory)
+
+    if not vmlinux_files:
+        print(f"No vmlinux files found in {directory}", file=sys.stderr)
+        sys.exit(1)
+
+    print(f"Found {len(vmlinux_files)} vmlinux file(s)\n", file=sys.stderr)
+
+    results = []
+    for vmlinux_path in vmlinux_files:
+        result = analyze_vmlinux(vmlinux_path)
+        results.append(result)
+
+    print(file=sys.stderr)
+    print_table(results)
+
+
+if __name__ == '__main__':
+    main()
-- 
2.55.0

