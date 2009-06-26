From: Samuel Bronson <naesten-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: pahole regression: -a no longer works?
Date: Thu, 25 Jun 2009 21:29:28 -0400
Message-ID: <db65a1cd0906251829p5e10b56fo861728d35ea54fb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

I've just noticed that pahole's -a flag does not seem to result in
typedef'd structs being printed anymore.

For example, with Debian's dwarves 1.3-1, on a self-compiled libVEX
from valgrind, I see loads of typedef'd struct types like this one:

typedef struct {
        IRTypeEnv *                type_env;             /*     0     4 */
        HReg *                     vregmap;              /*     4     4 */
        Int                        n_vregmap;            /*     8     4 */
        HInstrArray *              code;                 /*    12     4 */
        Int                        vreg_ctr;             /*    16     4 */

        /* size: 20, cachelines: 1 */
        /* last cacheline: 20 bytes */
} ISelEnv;      /* definitions: 1 */

but in the latest, I get only the following three:

struct _IRConst {
        IRConstTag                 tag;                  /*     0     4 */
        union {
                Bool               U1;                   /*           1 */
                UChar              U8;                   /*           1 */
                UShort             U16;                  /*           2 */
                UInt               U32;                  /*           4 */
                ULong              U64;                  /*           8 */
                Double             F64;                  /*           8 */
                ULong              F64i;                 /*           8 */
                UShort             V128;                 /*           2 */
        } Ico;                                           /*     4     8 */

        /* size: 12, cachelines: 1, members: 2 */
        /* last cacheline: 12 bytes */
};
struct _IRExpr {
        IRExprTag                  tag;                  /*     0     4 */
        union {
                struct {
                        Int        binder;               /*     4     4 */
                } Binder;                                /*           4 */
                struct {
                        Int        offset;               /*     4     4 */
                        IRType     ty;                   /*     8     4 */
                } Get;                                   /*           8 */
                struct {
                        IRRegArray * descr;              /*     4     4 */
                        IRExpr *   ix;                   /*     8     4 */
                        Int        bias;                 /*    12     4 */
                } GetI;                                  /*          12 */
                struct {
                        IRTemp     tmp;                  /*     4     4 */
                } RdTmp;                                 /*           4 */
                struct {
                        IROp       op;                   /*     4     4 */
                        IRExpr *   arg1;                 /*     8     4 */
                        IRExpr *   arg2;                 /*    12     4 */
                        IRExpr *   arg3;                 /*    16     4 */
                        IRExpr *   arg4;                 /*    20     4 */
                } Qop;                                   /*          20 */
                struct {
                        IROp       op;                   /*     4     4 */
                        IRExpr *   arg1;                 /*     8     4 */
                        IRExpr *   arg2;                 /*    12     4 */
                        IRExpr *   arg3;                 /*    16     4 */
                } Triop;                                 /*          16 */
                struct {
                        IROp       op;                   /*     4     4 */
                        IRExpr *   arg1;                 /*     8     4 */
                        IRExpr *   arg2;                 /*    12     4 */
                } Binop;                                 /*          12 */
                struct {
                        IROp       op;                   /*     4     4 */
                        IRExpr *   arg;                  /*     8     4 */
                } Unop;                                  /*           8 */
                struct {
                        IREndness  end;                  /*     4     4 */
                        IRType     ty;                   /*     8     4 */
                        IRExpr *   addr;                 /*    12     4 */
                } Load;                                  /*          12 */
                struct {
                        IRConst *  con;                  /*     4     4 */
                } Const;                                 /*           4 */
                struct {
                        IRCallee * cee;                  /*     4     4 */
                        IRType     retty;                /*     8     4 */
                        IRExpr * * args;                 /*    12     4 */
                } CCall;                                 /*          12 */
                struct {
                        IRExpr *   cond;                 /*     4     4 */
                        IRExpr *   expr0;                /*     8     4 */
                        IRExpr *   exprX;                /*    12     4 */
                } Mux0X;                                 /*          12 */
        } Iex;                                           /*     4    20 */

        /* size: 24, cachelines: 1, members: 2 */
        /* last cacheline: 24 bytes */
};
struct _IRStmt {
        IRStmtTag                  tag;                  /*     0     4 */
        union {
                struct {
                } NoOp;                                  /*           0 */
                struct {
                        Addr64     addr;                 /*     4     8 */
                        Int        len;                  /*    12     4 */
                } IMark;                                 /*          12 */
                struct {
                        IRExpr *   base;                 /*     4     4 */
                        Int        len;                  /*     8     4 */
                        IRExpr *   nia;                  /*    12     4 */
                } AbiHint;                               /*          12 */
                struct {
                        Int        offset;               /*     4     4 */
                        IRExpr *   data;                 /*     8     4 */
                } Put;                                   /*           8 */
                struct {
                        IRRegArray * descr;              /*     4     4 */
                        IRExpr *   ix;                   /*     8     4 */
                        Int        bias;                 /*    12     4 */
                        IRExpr *   data;                 /*    16     4 */
                } PutI;                                  /*          16 */
                struct {
                        IRTemp     tmp;                  /*     4     4 */
                        IRExpr *   data;                 /*     8     4 */
                } WrTmp;                                 /*           8 */
                struct {
                        IREndness  end;                  /*     4     4 */
                        IRExpr *   addr;                 /*     8     4 */
                        IRExpr *   data;                 /*    12     4 */
                } Store;                                 /*          12 */
                struct {
                        IRDirty *  details;              /*     4     4 */
                } Dirty;                                 /*           4 */
                        IRExpr *   data;                 /*     8     4 */
                } WrTmp;                                 /*           8 */
                struct {
                        IREndness  end;                  /*     4     4 */
                        IRExpr *   addr;                 /*     8     4 */
                        IRExpr *   data;                 /*    12     4 */
                } Store;                                 /*          12 */
                struct {
                        IRDirty *  details;              /*     4     4 */
                } Dirty;                                 /*           4 */
                struct {
                        IRMBusEvent event;               /*     4     4 */
                } MBE;                                   /*           4 */
                struct {
                        IRExpr *   guard;                /*     4     4 */
                        IRJumpKind jk;                   /*     8     4 */
                        IRConst *  dst;                  /*    12     4 */
                } Exit;                                  /*          12 */
        } Ist;                                           /*     4    16 */

        /* size: 20, cachelines: 1, members: 2 */
        /* last cacheline: 20 bytes */
};

This should be pretty easy to reproduce, but if not I could provide
you with an .o file... I'd bisect it myself if it weren't for the fact
that libebl.a is no longer available on Debian squeeze/sid, which
means I can't build without patching the cmake :-(
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
