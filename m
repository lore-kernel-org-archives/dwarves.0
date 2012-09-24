From: Nicolas <nikos42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Brain fart alert
Date: Tue, 25 Sep 2012 00:19:02 +0200
Message-ID: <5060DC56.4080609@gmail.com>
References: <CACHCVZ6oDyFwGbC4EwF_wsR9tCkoych5N6buLhRRLcyaL6iifw@mail.gmail.com>  <20120820180216.GE3046@infradead.org>  <CACHCVZ5EJadxOTJ0T4phSfAcm1FK7wfeDTp9QcSa1V1JCpa8SA@mail.gmail.com> <1346674948.3090.40.camel@springer.wildebeest.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020409090508020407010103"
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1346674948.3090.40.camel-OO0OHOuVXW89n/EXqpbZ8ns8WZQLr0HW@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Wielaard <mjw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Arnaldo Carvalho de Melo <acme-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

This is a multi-part message in MIME format.
--------------020409090508020407010103
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

I can't reproduce the segfault on i386 anymore (I updated my system
since last time I tried), but I got a new brain fart alert, with the
attached example.

As previously to reproduce: g++ -g -c brainfart2.cpp -o brainfart2.o &&
pahole brainfart2.o

Thanks a lot,
Nicolas


On 03/09/2012 14:22, Mark Wielaard wrote:
> On Thu, 2012-08-30 at 18:35 +0200, Nicolas wrote:
>> On my i386 box, pahole segfaults in dwfl_module_getelf (in libdw.so.1,
>> version 0.153), but the problem may be on elfutils' side.
> 
> I cannot replicate that on i386 with 0.152 or 0.155 (so it might be
> 0.153 specific). But could you give a bit more details, and/or supply
> the binaries you tried to pahole, a core file or backtrace when this
> happens?
> 
> Thanks,
> 
> Mark
> 


--------------020409090508020407010103
Content-Type: text/x-c++src;
 name="brainfart2.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="brainfart2.cpp"

using namespace std;
namespace std
{
  template<class _CharT> struct char_traits;
  template<typename _CharT, typename _Traits = char_traits<_CharT> > class basic_ostream;
  typedef basic_ostream<char> ostream;
}
class A  {};
class B: public A {};
class C: public B
{
  virtual void f(std::ostream& os) const;
};
void C::f(ostream& os) const {}

--------------020409090508020407010103--
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
