From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: ANNOUNCE: pahole v1.16 (Fixes + BTF_KIND_FUNC)
Date: Mon, 16 Dec 2019 12:07:20 -0300
Message-ID: <20191216150720.GA18669@kernel.org>
References: <20190626211613.GE3902@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190626211613.GE3902@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dwarves@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Jan Engelhardt <jengelh@inai.de>, Domenico Andreoli <cavok@debian.org>, Matthias Schwarzott <zzam@gentoo.org>, David Seifert <soap@gentoo.org>, Pavel Borzenkov <pavel.borzenkov@gmail.com>, Andrii Nakryiko <andriin@fb.com>, Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>, Gareth Lloyd <gareth.lloyd@uk.ibm.com>, Martin Cermak <mcermak@redhat.com>, William Cohen <wcohen@redhat.com>, Clark Williams <williams@redhat.com>
List-Id: dwarves@vger.kernel.org

Hi,

	The v1.16 release of pahole and its friends is out, available at
the usual places:

Main git repo:

   git://git.kernel.org/pub/scm/devel/pahole/pahole.git

Mirror git repo:

   https://github.com/acmel/dwarves.git

tarball + gpg signature:

   https://fedorapeople.org/~acme/dwarves/dwarves-1.16.tar.xz
   https://fedorapeople.org/~acme/dwarves/dwarves-1.16.tar.bz2
   https://fedorapeople.org/~acme/dwarves/dwarves-1.16.tar.sign

Best Regards,

- Arnaldo

v1.16 changes:

BTF encoder:

  Andrii Nakryiko <andriin@fb.com>:

  - Preserve and encode exported functions as BTF_KIND_FUNC.

    Add encoding of DWARF's DW_TAG_subprogram_type into BTF's BTF_KIND_FUNC
    (plus corresponding BTF_KIND_FUNC_PROTO). Only exported functions are converted
    for now. This allows to capture all the exported kernel functions, same subset
    that's exposed through /proc/kallsyms.

BTF loader:

  Arnaldo Carvalho de Melo <acme@redhat.com>

  - Add support for BTF_KIND_FUNC

    Some changes to the fprintf routines were needed, as BTF has as the
    function type just a BTF_KIND_FUNC_PROTO, while DWARF has as the type for a
    function its return value type. With a function->btf flag this was overcome and
    all the other goodies in pfunct are present.

Pretty printer:

  Arnaldo Carvalho de Melo:

  - Account inline type __aligned__ member types for spacing:

              union {
                      refcount_t         rcu_users;            /*  2568     4 */
                      struct callback_head rcu __attribute__((__aligned__(8))); /*  2568    16 */
      -       } __attribute__((__aligned__(8)));                                               /*  2568    16 */
      +       } __attribute__((__aligned__(8)));               /*  2568    16 */
              struct pipe_inode_info *   splice_pipe;          /*  2584     8 */

  - Fix alignment of class members that are structs/enums/unions

    E.g. look at that 'completion' member in this struct:

       struct cpu_stop_done {
              atomic_t                   nr_todo;              /*     0     4 */
              int                        ret;                  /*     4     4 */
      -       struct completion  completion;                   /*     8    32 */
      +       struct completion          completion;           /*     8    32 */

              /* size: 40, cachelines: 1, members: 3 */
              /* last cacheline: 40 bytes */

  - Fixup handling classes with no members, solving a NULL deref.

  Gareth Lloyd <gareth.lloyd@uk.ibm.com>:

  - Avoid infinite loop trying to determine type with static data member of its own type.

RPM spec file.

Jiri Olsa <jolsa@redhat.com>

    Add dwarves dependency on libdwarves1.

pfunct:

  Arnaldo Carvalho de Melo <acme@redhat.com>

  - type->type == 0 is void, fix --compile for that

    We were using the fall back for that, i.e. 'return 0;' was being emitted
    for a function returning void, noticed with using BTF as the format.

pdwtags:

    - Print DW_TAG_subroutine_type as well

      So that we can see at least via pdwtags those tags, be it from DWARF of BTF.

core:

  Arnaldo Carvalho de Melo <acme@redhat.com>

    Fix ptr_table__add_with_id() handling of pt->nr_entries, covering how
    BTF variables IDs are encoded.


pglobal:

  Arnaldo Carvalho de Melo <acme@redhat.com>:

  - Allow passing the format path specifier, to use with BTF

    I.e. now we can, just like with pahole, use:

      pglobal -F btf --variable foo.o

    To get the global variables.

Tree wide:

  Arnaldo Carvalho de Melo <acme@redhat.com>:

  - Fixup issues pointed out by various coverity reports.
