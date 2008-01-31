From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Creating ELF function/file size statistics
Date: Thu, 31 Jan 2008 10:23:45 -0200
Message-ID: <20080131122345.GJ1819@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Erik Ekman <yarrick-UYDU3/A3LUY@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

> I am doing some developing in C and want to see ELF size per function,
> file and directory. Right now I extract the sizes of functions and
> fields from objdump and use an ugly sed hack to find the file of each
> function/object, and then a python script that does some matching.

> I read about the DWARF format and it seems it includes the things I
> need. The output from objdump -W and eu-readelf -w shows that
> functions and object are tied to a file in some way.

> Does any of the existing dwarf programs do this? pdwtags looked as a
> best fit from reading the OLS paper. I have not fetched the latest
> source yet due to some workplace firewalls. If no tool does this and
> it is possible, then I am interested in developing one.

> Please cc me, i am not on the list.

I had to look up your address on the net and only saw your message today
because I don't use the newsgroups interface regularly, anyway:

pfunct is the tool, look at this, the top 5 functions per .o file on a
directory hierarchy:

[acme@doppio pahole]$ find examples -name "*.o" | while read file ; do \
		echo "---> $file" ; \
		pfunct --sizes $file | sort -k2 -nr | head -5 ; \ 
		echo "--------" ; done
---> examples/qsize.o
operator<<: 164
operator>>: 83
q_atomic_decrement: 25
--------
---> examples/prototype1.o
main: 50
--------
---> examples/qsettings.o
getPath: 1233
checkAccess: 762
globalMutex: 277
iniChopTrailingSpaces: 259
unusedCacheFunc: 229
--------
---> examples/multi-cu/main.o
main: 63
--------
---> examples/multi-cu/a.o
a_foo_print: 29
--------
---> examples/prototype2.o
foo: 27
--------
[acme@doppio pahole]$

There are more options, some useful, some just for laughs, like
--function_name_len:

----------------------------- 8< -------------------------------------------

[acme@doppio pahole]$ pfunct --help
Usage: pfunct [OPTION...] -e [FILE] {[FUNCTION]}

  -c, --class=CLASS          functions that have CLASS pointer parameters
  -E, --externals            show just external functions
  -f, --function=FUNCTION    show just FUNCTION
  -g, --goto_labels          show number of goto labels
  -G, --cc_uninlined         declared inline, uninlined by compiler
  -H, --cc_inlined           not declared inline, inlined by compiler
  -i, --inline_expansions    show inline expansions
  -I, --inline_expansions_stats   show inline expansions stats
  -l, --decl_info            show source code info
  -N, --function_name_len    show size of functions names
  -p, --nr_parms             show number of parameters
  -s, --sizes                show size of functions
  -S, --nr_variables         show number of variables
  -t, --total_inline_stats   show Multi-CU total inline expansions stats
  -T, --variables            show variables
  -V, --verbose              be verbose

 Input selection options:
      --debuginfo-path=PATH  Search path for separate debuginfo files
  -e, --executable=FILE      Find addresses in FILE
  -k, --kernel               Find addresses in the running kernel
  -K, --offline-kernel[=RELEASE]   Kernel with all modules
  -M, --linux-process-map=FILE   Find addresses in files mapped as read from
                             FILE in Linux /proc/PID/maps format
      --pid=PID              Find addresses in files mapped into process PID

  -?, --help                 Give this help list
      --usage                Give a short usage message

Mandatory or optional arguments to long options are also mandatory or optional
for any corresponding short options.

----------------------------- 8< -------------------------------------------

- Arnaldo
