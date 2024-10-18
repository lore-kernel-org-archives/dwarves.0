Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8161547C3
	for <dwarves@vger.kernel.org>; Fri, 18 Oct 2024 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729282643; cv=none; b=g5N2r0Ddd3rv4UtW3cAW8kdd9+qE5FTHN6OwCd2e8RuJOhCn92/CMa9WMIxCZchW2e9VVDUK+c4KddeCbDmkRzPvmz1FxYQdEL+Jx1+Xl4iuHcwBBdRQd5RYQFW3Dn/PoXm+OeXTsPldQbKTAwVutCnNN5GwHaCh79Uiqm2Eep0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729282643; c=relaxed/simple;
	bh=BFCPODVv0b4Qr21FqOm2BIcZMrTEtGtN2dnsF448rUs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+2PhG1IWi+9BynUQRnVrVneR8FTd8iJoInpWrlQmdh9KkQ+bDKn2LXf1BkePiG9ZCVO0aNuLaXM82PhToDJwSFrYvNXrGlz/EBEZoGcCJQfNASXfNwiCMQjBUXInM2DcWkiBwOOxxA7am1am8CDmayioYv+srjn8Awp1pEpKOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=rUfkcw3F; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="rUfkcw3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729282633; x=1729541833;
	bh=6oa7wKDop5q0H4zO7KtZLNLHBEUanOHseqGxhjhRS40=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rUfkcw3FlTxqKnXA3J110WhMQpI4rKZeYEfZJbHkTtYiei/AIzHD8APHxsRNIIweE
	 QtG5Wa0KRFWcGAZZqSoPINYqGs3G51ZXn+z/2YFfVF9+mJpGZ5QzpKZAQbShMhk8AQ
	 t7LBwpC4vf/nETtB1ZCQOPELdQlCqVUHZhE8EH0lSYNwN9aXjPoluke9koL1H8Ylnj
	 sYIbkL7+vr97VECQw5Qk0f8/Fe+Ljowgrp0dcdooHFGSiOD+f5CbNwYtw5f2Y+mePw
	 PzA+xFuAGhbnrymXDFRciYnGOihTozdx1a5jed5cf7fG4urWN2gGzesviYyEOgg1+2
	 OqD4+6SICCf3Q==
Date: Fri, 18 Oct 2024 20:17:07 +0000
To: Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com
Subject: Re: [PATCH v3 dwarves 3/5] btf_encoder: collect elf_functions in btf_encoder__pre_load_module
Message-ID: <4G5AFfVer_N_eJCZYc22pQM9rXbHOV2CZ4uOmqh4gFd1K2mgnbIDIZUpynMNCdJ-CEyvsBr0-cPdUzgNnM05NPkPjRdqdAnCAp8DrvUc-Iw=@pm.me>
In-Reply-To: <ZxFv46O6UPnqbzGF@x1>
References: <20241016001025.857970-1-ihor.solodrai@pm.me> <20241016001025.857970-4-ihor.solodrai@pm.me> <05bd8cbb-9e6d-479a-abf6-51e7eb5e67f7@oracle.com> <ZxFv46O6UPnqbzGF@x1>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 998b60c6816ea913f94ec14631ce05a6424beffd
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, October 17th, 2024 at 1:13 PM, Arnaldo Carvalho de Melo <acme@=
kernel.org> wrote:

> On Thu, Oct 17, 2024 at 11:56:04AM +0100, Alan Maguire wrote:
>=20
> > On 16/10/2024 01:10, Ihor Solodrai wrote:
> >=20
> > > Introduce a global elf_functions_list variable in btf_encoder.c that
> > > contains an elf_functions per ELF.
> >=20
> > Arnaldo can help provide context here, but at least notionally I think
> > the idea of maintaining libdwarves as a library has value. In that
>=20
>=20
> Yeah, but in all these years I'm not aware of any user, I even need to
> do some testing on building pahole statically with libdwarves to see if
> we get performance improvements...
>=20
> > context, avoiding global lists where possible is a good thing I think,
>=20
>=20
> Even without a library :-)
>=20
> > since if it was used as a library, multiple invokations could confuse
> > the elf_functions list. To that end, can we make the elf_functions_list
> > a field in the conf_load perhaps? It already contains base_btf so there
>=20
>=20
> conf_load looks with the structs we have now, so I would try to start
> there.
>=20
> - Arnaldo
>=20
> > is a precedent for storing data relevant to all encoders there, and
> > btf_encoder__new() has conf_load as a parameter, so the elf functions
> > list can still always be retrieved on encoder creation. In addition the
> > parameter to cus__process_dwflmod() has the parms structure which
> > contains the conf_load; you'd just need to pass that through to your
> > pre_load_module() callback I think.
> >=20
> > It shouldn't be a massive change but I think it would be worthwhile.
> >=20
> > Thanks!

Hi Alan, Arnaldo, thank you for review.

I understand your points, however adding elf_functions to conf_load
feels wrong to me. The global list I added was analogous to `encoders`
list in btf_encoder.c

I poked at the code a bit and came up with a context struct. It's
still a global variable, but with a clear init/exit interface.

Potentially other global BTF encoding-related state, for example
"main" btf_encoder and base_btf, could be stored in this context too.

Please see the diff below and let me know what you think.


---
 btf_encoder.c | 119 ++++++++++++++++++++++++++++----------------------
 btf_encoder.h |   3 ++
 pahole.c      |  16 ++++---
 3 files changed, 80 insertions(+), 58 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 1ec39fe..90aaa25 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -154,19 +154,76 @@ struct btf_kfunc_set_range {
 =09uint64_t end;
 };
=20
+static struct {
+=09bool initialized;
+
+=09/* In principle, multiple ELFs can be processed in one pahole run,
+=09 * so we have to store elf_functions table per ELF.
+=09 * An element is added to the list on btf_encoder__pre_load_module,
+=09 * and removed after btf_encoder__encode is done.
+=09 */
+=09struct list_head elf_functions_list;
+
+=09/* mutex only needed for add/delete, as this can happen in multiple enc=
oding
+=09 * threads.  Traversal of the list is currently confined to thread coll=
ection.
+=09 */
+=09pthread_mutex_t btf_encoder_list_lock;
+=09struct list_head btf_encoder_list;
+
+} btf_encoding_context;
+
+int btf_encoding_context__init() {
+=09int err =3D 0;
+
+=09if (btf_encoding_context.initialized) {
+=09=09fprintf(stderr, "btf_encoding_context__init() called while context i=
s already initialized\n");
+=09=09err =3D -1;
+=09=09goto out;
+=09}
+
+=09INIT_LIST_HEAD(&btf_encoding_context.elf_functions_list);
+=09INIT_LIST_HEAD(&btf_encoding_context.btf_encoder_list);
+=09pthread_mutex_init(&btf_encoding_context.btf_encoder_list_lock, NULL);
+=09btf_encoding_context.initialized =3D true;
+
+out:
+=09return err;
+}
+
+static inline void elf_functions__delete(struct elf_functions *funcs);
+
+void btf_encoding_context__exit() {
+=09struct list_head *pos, *tmp;
+
+=09if (!btf_encoding_context.initialized) {
+=09=09fprintf(stderr, "btf_encoding_context__exit() called while context i=
s not initialized\n");
+=09=09return;
+=09}
+
+=09list_for_each_safe(pos, tmp, &btf_encoding_context.elf_functions_list) =
{
+=09=09struct elf_functions *funcs =3D list_entry(pos, struct elf_functions=
, node);
+=09=09list_del(&funcs->node);
+=09=09elf_functions__delete(funcs);
+=09}
+
+=09pthread_mutex_lock(&btf_encoding_context.btf_encoder_list_lock);
+=09list_for_each_safe(pos, tmp, &btf_encoding_context.btf_encoder_list) {
+=09=09struct btf_encoder *encoder =3D list_entry(pos, struct btf_encoder, =
node);
+=09=09list_del(&encoder->node);
+=09=09btf_encoder__delete(encoder);
+=09}
+=09pthread_mutex_unlock(&btf_encoding_context.btf_encoder_list_lock);
+
+=09pthread_mutex_destroy(&btf_encoding_context.btf_encoder_list_lock);
+=09btf_encoding_context.initialized =3D false;
+}
=20
-/* In principle, multiple ELFs can be processed in one pahole run,
- * so we have to store elf_functions table per ELF.
- * An element is added to the list on btf_encoder__pre_load_module,
- * and removed after btf_encoder__encode is done.
- */
-static LIST_HEAD(elf_functions_list);
=20
 static struct elf_functions *elf_functions__get(Elf *elf)
 {
 =09struct list_head *pos;
=20
-=09list_for_each(pos, &elf_functions_list) {
+=09list_for_each(pos, &btf_encoding_context.elf_functions_list) {
 =09=09struct elf_functions *funcs =3D list_entry(pos, struct elf_functions=
, node);
=20
 =09=09if (funcs->elf =3D=3D elf)
@@ -198,21 +255,9 @@ static void __elf_functions__delete(struct elf_functio=
ns *funcs)
 static inline void elf_functions__delete(struct elf_functions *funcs)
 {
 =09__elf_functions__delete(funcs);
-=09list_del(&funcs->node);
 =09free(funcs);
 }
=20
-static inline void elf_functions__delete_all(void)
-{
-=09struct list_head *pos, *tmp;
-
-=09list_for_each_safe(pos, tmp, &elf_functions_list) {
-=09=09struct elf_functions *funcs =3D list_entry(pos, struct elf_functions=
, node);
-
-=09=09elf_functions__delete(funcs);
-=09}
-}
-
 static int elf_functions__collect(struct elf_functions *functions);
=20
 int btf_encoder__pre_load_module(Dwfl_Module *mod, Elf *elf)
@@ -237,7 +282,7 @@ int btf_encoder__pre_load_module(Dwfl_Module *mod, Elf =
*elf)
 =09if (err)
 =09=09goto out_delete;
=20
-=09list_add_tail(&funcs->node, &elf_functions_list);
+=09list_add_tail(&funcs->node, &btf_encoding_context.elf_functions_list);
=20
 =09return 0;
=20
@@ -246,37 +291,11 @@ out_delete:
 =09return err;
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
 static void btf_encoders__add(struct btf_encoder *encoder)
 {
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
+=09pthread_mutex_lock(&btf_encoding_context.btf_encoder_list_lock);
+=09list_add_tail(&encoder->node, &btf_encoding_context.btf_encoder_list);
+=09pthread_mutex_unlock(&btf_encoding_context.btf_encoder_list_lock);
 }
=20
 #define PERCPU_SECTION ".data..percpu"
@@ -2215,7 +2234,6 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 =09=09err =3D btf_encoder__write_elf(encoder, encoder->btf, BTF_ELF_SEC);
 =09}
=20
-=09elf_functions__delete_all();
 =09return err;
 }
=20
@@ -2588,7 +2606,6 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 =09if (encoder =3D=3D NULL)
 =09=09return;
=20
-=09btf_encoders__delete(encoder);
 =09for (shndx =3D 0; shndx < encoder->seccnt; shndx++)
 =09=09__gobuffer__delete(&encoder->secinfo[shndx].secinfo);
 =09zfree(&encoder->filename);
diff --git a/btf_encoder.h b/btf_encoder.h
index 29f652a..c3886b8 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -23,6 +23,9 @@ enum btf_var_option {
 =09BTF_VAR_GLOBAL =3D 2,
 };
=20
+int btf_encoding_context__init();
+void btf_encoding_context__exit();
+
 struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_f=
ilename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
 void btf_encoder__delete(struct btf_encoder *encoder);
=20
diff --git a/pahole.c b/pahole.c
index 6f83636..2a6e012 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3280,12 +3280,6 @@ static int pahole_threads_collect(struct conf_load *=
conf, int nr_threads, void *
 =09err =3D 0;
=20
 out:
-=09for (i =3D 0; i < nr_threads; i++) {
-=09=09if (threads[i]->encoder && threads[i]->encoder !=3D btf_encoder) {
-=09=09=09btf_encoder__delete(threads[i]->encoder);
-=09=09=09threads[i]->encoder =3D NULL;
-=09=09}
-=09}
 =09free(threads[0]);
=20
 =09return err;
@@ -3818,8 +3812,12 @@ int main(int argc, char *argv[])
 =09=09conf_load.threads_collect =3D pahole_threads_collect;
 =09}
=20
-=09if (btf_encode)
+=09if (btf_encode) {
 =09=09conf_load.pre_load_module =3D btf_encoder__pre_load_module;
+=09=09int err =3D btf_encoding_context__init();
+=09=09if (err < 0)
+=09=09=09goto out;
+=09}
=20
 =09// Make 'pahole --header type < file' a shorter form of 'pahole -C type=
 --count 1 < file'
 =09if (conf.header_type && !class_name && prettify_input) {
@@ -3928,7 +3926,11 @@ try_sole_arg_as_class_names:
 =09=09=09goto out_cus_delete;
 =09=09}
 =09}
+
 out_ok:
+=09if (btf_encode)
+=09=09btf_encoding_context__exit();
+
 =09if (stats_formatter !=3D NULL)
 =09=09print_stats();
=20
--=20
2.43.0


> > > [...]


