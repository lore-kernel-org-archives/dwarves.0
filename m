Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70F1F4E38
	for <dwarves@vger.kernel.org>; Tue,  7 Jan 2025 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736276997; cv=none; b=ZI9VnOmAFgKYCa1+G853cvJK5ujHHWpYGeUHa5QjNxz+Ug+PvYUTbxBx+ufNouSFOq/Docpclx7R4AIG9md22dyMy4dc3rsmHjqk0vV9m+uY8+UwpqkjS+LJme4jCn0/AySSp8zxFeue0vEtiLK+3WnGS/CC+8XMeGHEVXmhqGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736276997; c=relaxed/simple;
	bh=9IeFZzMnVRUUbyUt7fLv61oIiHiC1M36VosCjsne8Cs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgjU9q7EPl2gYrygQXj4OhyyhDbEans6wEROL1KsYgEX/YN3TTPKUKnpR/h38ixowLqC2ztcfz6nq31L/dfzd18Rmbj2TqtEgNRoe9iW80NCiK9I/XIpF2zU4ok54CEtiGptB2mnRk5W6GOzh8e43RKkUmHAWFSMny1zS71iZLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Jf6RQghi; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Jf6RQghi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736276992; x=1736536192;
	bh=VeQTSyx/mjaHmdLYSH5yxPaGXWhYyevT098OP7Y4JnA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Jf6RQghi1Ux8zy9GqVZXvpYvijaM7gehiT1TLpuhZeLiJ7bIHoe9Kl7fZj9YXZuzz
	 rLAGchitP1g9nC5XMOC5g7hfBBfp6yCofNscZ7LTXPwQ2s/rdsOK/tKUaT5WBXZhgv
	 0DyaH27e1oOsmScAKUIH5JiPtHDAqlU8O7zbItfRne2kgC0nSNOTIUGtqLuMHZ8g34
	 edPzsPcTea/C5rt1VcZhipMI6H6LQ6eCY06ly4oWrOHAmXR4SW9P8TZJyFecY+iZ9N
	 HgeY1Y9JJn/v657G7V8AD+VZxm2ImXqqv6xQ0grdX8NUjoFW2+cXttfu0w7ifpNf6u
	 ZpNYZy8XtJdYA==
Date: Tue, 07 Jan 2025 19:09:48 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, olsajiri@gmail.com
Subject: [PATCH dwarves v4 09/10] btf_encoder: clean up global encoders list
Message-ID: <20250107190855.2312210-10-ihor.solodrai@pm.me>
In-Reply-To: <20250107190855.2312210-1-ihor.solodrai@pm.me>
References: <20250107190855.2312210-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 6f70ca2a186137f3dca0e61bdde6a5bfcd51ef32
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

With multithreading moved entirely to the dwarf_loader, now there is
only one btf_encoder. Hence there is no need to maintain a global list
of encoders anymore.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 94 +++++----------------------------------------------
 btf_encoder.h |  4 ---
 2 files changed, 8 insertions(+), 90 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 7fc04cb..4b6e4b7 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -218,39 +218,6 @@ static struct elf_functions *elf_functions__find(const=
 Elf *elf, const struct li
 =09return NULL;
 }
=20
-
-static LIST_HEAD(encoders);
-static pthread_mutex_t encoders__lock =3D PTHREAD_MUTEX_INITIALIZER;
-
-/* mutex only needed for add/delete, as this can happen in multiple encodi=
ng
- * threads.  Traversal of the list is currently confined to thread collect=
ion.
- */
-
-#define btf_encoders__for_each_encoder(encoder)=09=09\
-=09list_for_each_entry(encoder, &encoders, node)
-
-static void btf_encoders__add(struct btf_encoder *encoder)
-{
-=09pthread_mutex_lock(&encoders__lock);
-=09list_add_tail(&encoder->node, &encoders);
-=09pthread_mutex_unlock(&encoders__lock);
-}
-
-static void btf_encoders__delete(struct btf_encoder *encoder)
-{
-=09struct btf_encoder *existing =3D NULL;
-
-=09pthread_mutex_lock(&encoders__lock);
-=09/* encoder may not have been added to list yet; check. */
-=09btf_encoders__for_each_encoder(existing) {
-=09=09if (encoder =3D=3D existing)
-=09=09=09break;
-=09}
-=09if (encoder =3D=3D existing)
-=09=09list_del(&encoder->node);
-=09pthread_mutex_unlock(&encoders__lock);
-}
-
 #define PERCPU_SECTION ".data..percpu"
=20
 /*
@@ -868,39 +835,6 @@ static int32_t btf_encoder__add_var_secinfo(struct btf=
_encoder *encoder, size_t
 =09return gobuffer__add(&encoder->secinfo[shndx].secinfo, &si, sizeof(si))=
;
 }
=20
-int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_e=
ncoder *other)
-{
-=09size_t shndx;
-=09if (encoder =3D=3D other)
-=09=09return 0;
-
-=09for (shndx =3D 1; shndx < other->seccnt; shndx++) {
-=09=09struct gobuffer *var_secinfo_buf =3D &other->secinfo[shndx].secinfo;
-=09=09size_t sz =3D gobuffer__size(var_secinfo_buf);
-=09=09uint16_t nr_var_secinfo =3D sz / sizeof(struct btf_var_secinfo);
-=09=09uint32_t type_id;
-=09=09uint32_t next_type_id =3D btf__type_cnt(encoder->btf);
-=09=09int32_t i, id;
-=09=09struct btf_var_secinfo *vsi;
-
-=09=09if (strcmp(encoder->secinfo[shndx].name, other->secinfo[shndx].name)=
) {
-=09=09=09fprintf(stderr, "mismatched ELF sections at index %zu: \"%s\", \"=
%s\"\n",
-=09=09=09=09shndx, encoder->secinfo[shndx].name, other->secinfo[shndx].nam=
e);
-=09=09=09return -1;
-=09=09}
-
-=09=09for (i =3D 0; i < nr_var_secinfo; i++) {
-=09=09=09vsi =3D (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
-=09=09=09type_id =3D next_type_id + vsi->type - 1; /* Type ID starts from =
1 */
-=09=09=09id =3D btf_encoder__add_var_secinfo(encoder, shndx, type_id, vsi-=
>offset, vsi->size);
-=09=09=09if (id < 0)
-=09=09=09=09return id;
-=09=09}
-=09}
-
-=09return btf__add_btf(encoder->btf, other->btf);
-}
-
 static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, size_=
t shndx)
 {
 =09struct gobuffer *var_secinfo_buf =3D &encoder->secinfo[shndx].secinfo;
@@ -1326,18 +1260,16 @@ static void btf_encoder__delete_saved_funcs(struct =
btf_encoder *encoder)
 =09}
 }
=20
-static int btf_encoder__add_saved_funcs(bool skip_encoding_inconsistent_pr=
oto)
+static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool =
skip_encoding_inconsistent_proto)
 {
 =09struct btf_encoder_func_state **saved_fns =3D NULL, *s;
 =09int err =3D 0, i =3D 0, j, nr_saved_fns =3D 0;
-=09struct btf_encoder *e =3D NULL;
=20
-=09/* Retrieve function states from each encoder, combine them
+=09/* Retrieve function states from the encoder, combine them
 =09 * and sort by name, addr.
 =09 */
-=09btf_encoders__for_each_encoder(e) {
-=09=09list_for_each_entry(s, &e->func_states, node)
-=09=09=09nr_saved_fns++;
+=09list_for_each_entry(s, &encoder->func_states, node) {
+=09=09nr_saved_fns++;
 =09}
=20
 =09if (nr_saved_fns =3D=3D 0)
@@ -1349,9 +1281,8 @@ static int btf_encoder__add_saved_funcs(bool skip_enc=
oding_inconsistent_proto)
 =09=09goto out;
 =09}
=20
-=09btf_encoders__for_each_encoder(e) {
-=09=09list_for_each_entry(s, &e->func_states, node)
-=09=09=09saved_fns[i++] =3D s;
+=09list_for_each_entry(s, &encoder->func_states, node) {
+=09=09saved_fns[i++] =3D s;
 =09}
 =09qsort(saved_fns, nr_saved_fns, sizeof(*saved_fns), saved_functions_cmp)=
;
=20
@@ -1383,9 +1314,7 @@ static int btf_encoder__add_saved_funcs(bool skip_enc=
oding_inconsistent_proto)
=20
 out:
 =09free(saved_fns);
-=09btf_encoders__for_each_encoder(e) {
-=09=09btf_encoder__delete_saved_funcs(e);
-=09}
+=09btf_encoder__delete_saved_funcs(encoder);
=20
 =09return err;
 }
@@ -2147,7 +2076,7 @@ int btf_encoder__encode(struct btf_encoder *encoder, =
struct conf_load *conf)
 =09int err;
 =09size_t shndx;
=20
-=09err =3D btf_encoder__add_saved_funcs(conf->skip_encoding_btf_inconsiste=
nt_proto);
+=09err =3D btf_encoder__add_saved_funcs(encoder, conf->skip_encoding_btf_i=
nconsistent_proto);
 =09if (err < 0)
 =09=09return err;
=20
@@ -2553,7 +2482,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
=20
 =09=09if (encoder->verbose)
 =09=09=09printf("File %s:\n", cu->filename);
-=09=09btf_encoders__add(encoder);
 =09}
=20
 =09return encoder;
@@ -2570,7 +2498,6 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 =09if (encoder =3D=3D NULL)
 =09=09return;
=20
-=09btf_encoders__delete(encoder);
 =09for (shndx =3D 0; shndx < encoder->seccnt; shndx++)
 =09=09__gobuffer__delete(&encoder->secinfo[shndx].secinfo);
 =09free(encoder->secinfo);
@@ -2740,8 +2667,3 @@ out:
 =09encoder->cu =3D NULL;
 =09return err;
 }
-
-struct btf *btf_encoder__btf(struct btf_encoder *encoder)
-{
-=09return encoder->btf;
-}
diff --git a/btf_encoder.h b/btf_encoder.h
index 0081a99..0f345e2 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -27,10 +27,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, cons=
t char *detached_filenam
 void btf_encoder__delete(struct btf_encoder *encoder);
=20
 int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *con=
f);
-
 int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, str=
uct conf_load *conf_load);
=20
-struct btf *btf_encoder__btf(struct btf_encoder *encoder);
-
-int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encod=
er *other);
 #endif /* _BTF_ENCODER_H_ */
--=20
2.47.1


