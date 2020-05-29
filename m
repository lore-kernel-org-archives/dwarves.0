From: Andrii Nakryiko <andrii.nakryiko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] btf_encoder: Teach pahole to store percpu variables in
 vmlinux BTF.
Date: Thu, 28 May 2020 22:19:34 -0700
Message-ID: <CAEf4BzYd=26j_5RWxfVVq=4DrzEc62gQChX94mUabxturBpRdg@mail.gmail.com>
References: <20200529011305.35132-1-haoluo@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200529011305.35132-1-haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexei Starovoitov <alexei.starovoitov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Borkmann <daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org>, Oleg Rombakh <olegrom-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Martin Lau <kafai-b10kYP2dOMg@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

On Thu, May 28, 2020 at 6:14 PM Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
>
> On SMP systems, the global percpu variables are placed in a speical
> '.data..percpu' section, which is stored in a segment whose initial
> address is set to 0, the addresses of per-CPU variables are relative
> positive addresses[1].
>
> This patch extracts these variables from vmlinux and places them with
> their type information in BTF, so that they can be accessed in BPF.
>
> In a v5.7-rc7 linux kernel, I was able to extract 291 such variables.
> The space overhead is small.
>
> Testing:
>
> Before:
>  $ readelf -SW vmlinux | grep BTF
>  [25] .BTF              PROGBITS        ffffffff821a905c 13a905c 2d2bf8 00   A  0   0  1
>
> After:
>  $ pahole -J vmlinux
>  $ readelf -SW vmlinux  | grep BTF
>  [25] .BTF              PROGBITS        ffffffff821a905c 13a905c 2d4db8 00   A  0   0  1
>
> Common percpu vars can be found in the BTF section.
>
>  $ bpftool btf dump file vmlinux | grep runqueues
>  [14098] VAR 'runqueues' type_id=13725, linkage=global-alloc
>
>  $ bpftool btf dump file vmlinux | grep cpu_stopper
>  [17589] STRUCT 'cpu_stopper' size=72 vlen=5
>  [17609] VAR 'cpu_stopper' type_id=17589, linkage=global-alloc
>
> References:
>  [1] https://lwn.net/Articles/531148/
> Signed-off-by: Hao Luo <haoluo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> ---
>  btf_encoder.c | 27 +++++++++++++++++++++++++++
>  libbtf.c      | 29 +++++++++++++++++++++++++++++
>  libbtf.h      |  2 ++
>  pahole.c      |  1 +
>  4 files changed, 59 insertions(+)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index df16ba0..f550f34 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -241,6 +241,33 @@ int cu__encode_btf(struct cu *cu, int verbose)
>                 }
>         }
>
> +       cu__for_each_variable(cu, core_id, pos) {

One other thing that's missing is DATASEC type. All variables should
be contained within a datasection. See `struct btf_var_secinfo`, each
variable will have a size and offset within its data section specified
as well.

> +               int btf_var_id;
> +               struct variable *var;
> +               uint32_t linkage;
> +
> +               var = tag__variable(pos);
> +               /*
> +                * .data..percpu is stored in a segment whose initial address is
> +                * set to 0, the addresses of per-CPU variables are addresses
> +                * relative to 0.
> +                *
> +                * https://lwn.net/Articles/531148/
> +                */
> +               if ((int64_t)var->ip.addr <= 0)

This heuristic seems fragile. Why not check section name directly,
instead of relying on indirect things like this?

> +                       continue;
> +               linkage = variable__scope(var) == VSCOPE_GLOBAL;

linkage is not a bool, it's enum, please specify explicitly

> +               btf_var_id = btf_elf__add_var_type(btfe, var->ip.tag.type,
> +                                                  var->name, linkage,
> +                                                  type_id_off);
> +               if (btf_var_id < 0) {
> +                       err = -1;
> +                       printf("error: failed to encode variable '%s'\n",
> +                              variable__name(var, cu));
> +                       goto out;
> +               }
> +       }
> +
>  out:
>         if (err)
>                 btf_elf__delete(btfe);
> diff --git a/libbtf.c b/libbtf.c
> index 2fbce40..de85666 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -613,6 +613,35 @@ int32_t btf_elf__add_func_proto(struct btf_elf *btfe, struct ftype *ftype, uint3
>         return type_id;
>  }
>
> +int32_t btf_elf__add_var_type(struct btf_elf *btfe, uint32_t type,
> +                             uint32_t name_off, uint32_t linkage,
> +                             uint32_t type_id_off)
> +{
> +       struct {
> +               struct btf_type type;
> +               struct btf_var var;
> +       } t;
> +
> +       t.type.name_off = name_off;
> +       t.type.info = BTF_INFO_ENCODE(BTF_KIND_VAR, 0, 0);
> +       t.type.type = type_id_off + type;
> +
> +       t.var.linkage = linkage;
> +
> +       ++btfe->type_index;
> +       if (gobuffer__add(&btfe->types, &t.type, sizeof(t)) < 0) {
> +               btf_elf__log_type(btfe, &t.type, true, true,
> +                                 "type=%u name=%s Error in adding gobuffer",
> +                                 t.type.type, btf_elf__name_in_gobuf(btfe, t.type.name_off));
> +               return -1;
> +       }
> +
> +       btf_elf__log_type(btfe, &t.type, false, false, "type=%u name=%s",
> +                         t.type.type, btf_elf__name_in_gobuf(btfe, t.type.name_off));
> +
> +       return btfe->type_index;
> +}
> +
>  static int btf_elf__write(const char *filename, struct btf *btf)
>  {
>         GElf_Shdr shdr_mem, *shdr;
> diff --git a/libbtf.h b/libbtf.h
> index f3c8500..d9e723a 100644
> --- a/libbtf.h
> +++ b/libbtf.h
> @@ -55,6 +55,8 @@ int32_t btf_elf__add_enum(struct btf_elf *btf, uint32_t name, uint32_t size,
>  int btf_elf__add_enum_val(struct btf_elf *btf, uint32_t name, int32_t value);
>  int32_t btf_elf__add_func_proto(struct btf_elf *btf, struct ftype *ftype,
>                                 uint32_t type_id_off);
> +int32_t btf_elf__add_var_type(struct btf_elf *btfe, uint32_t type, uint32_t name_off,
> +                             uint32_t linkage, uint32_t type_id_off);
>  void btf_elf__set_strings(struct btf_elf *btf, struct gobuffer *strings);
>  int  btf_elf__encode(struct btf_elf *btf, uint8_t flags);
>
> diff --git a/pahole.c b/pahole.c
> index e2a081b..8407db9 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1084,6 +1084,7 @@ static error_t pahole__options_parser(int key, char *arg,
>         case 'i': find_containers = 1;
>                   class_name = arg;                     break;
>         case 'J': btf_encode = 1;
> +                 conf_load.get_addr_info = true;

curious, what does this do?

>                   no_bitfield_type_recode = true;       break;
>         case 'l': conf.show_first_biggest_size_base_type_member = 1;    break;
>         case 'M': conf.show_only_data_members = 1;      break;
> --
> 2.27.0.rc2.251.g90737beb825-goog
>
