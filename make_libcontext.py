#!/usr/bin/python

import re

files = [
["jump_i386_ms_pe_gas.S", "windows_i386", "gcc"],
["make_i386_ms_pe_gas.S", "windows_i386", "gcc"],

["jump_x86_64_ms_pe_gas.S", "windows_x86_64", "gcc"],
["make_x86_64_ms_pe_gas.S", "windows_x86_64", "gcc"],

["jump_i386_sysv_elf_gas.S", "linux_i386", "gcc"],
["make_i386_sysv_elf_gas.S", "linux_i386", "gcc"],

["jump_x86_64_sysv_elf_gas.S", "linux_x86_64", "gcc"],
["make_x86_64_sysv_elf_gas.S", "linux_x86_64", "gcc"],

["make_i386_sysv_macho_gas.S", "apple_i386", "gcc"],
["make_x86_64_sysv_macho_gas.S","apple_x86_64", "gcc"]

#["jump_arm_aapcs_elf_gas.S", "linux_arm", "gcc"],
#["jump_arm_aapcs_macho_gas.S", "apple_arm", "gcc"],
#["jump_i386_sysv_macho_gas.S", "apple_i386", "gcc"],
#["jump_ppc32_sysv_elf_gas.S", "linux_ppc32", "gcc"],
#["jump_ppc32_sysv_macho_gas.S", "apple_ppc32", "gcc"],
#["jump_ppc64_sysv_elf_gas.S",  "linux_ppc64", "gcc"],
#["jump_ppc64_sysv_macho_gas.S", "apple_ppc64", "gcc"],
#["jump_x86_64_sysv_macho_gas.S", "apple_x86_64", "gcc"],
#["make_arm_aapcs_elf_gas.S", "linux_arm", "gcc"],
#["make_arm_aapcs_macho_gas.S", "apple_arm", "gcc"],
#["make_ppc32_sysv_elf_gas.S", "linux_ppc32", "gcc"],
#["make_ppc32_sysv_macho_gas.S", "apple_ppc32", "gcc"],
#["make_ppc64_sysv_elf_gas.S", "linux_ppc64", "gcc"],
#["make_ppc64_sysv_macho_gas.S", "apple_ppc64", "gcc"],
];


def removeCCppComment( text ) :

    def blotOutNonNewlines( strIn ) :  # Return a string containing only the newline chars contained in strIn
        return "" + ("\n" * strIn.count('\n'))

    def replacer( match ) :
        s = match.group(0)
        if s.startswith('/'):  # Matched string is //...EOL or /*...*/  ==> Blot out all non-newline chars
            return blotOutNonNewlines(s)
        else:                  # Matched string is '...' or "..."  ==> Keep unchanged
            return s

    pattern = re.compile(
        r'//.*?$|/\*.*?\*/|\'(?:\\.|[^\\\'])*\'|"(?:\\.|[^\\"])*"',
        re.DOTALL | re.MULTILINE
    )

    return re.sub(pattern, replacer, text)

ignore_tokens = [".file"]


f_out=open("libcontext.cpp","w")

f_out.write("/*\n")
f_out.write("\n")
f_out.write("    auto-generated file, do not modify!\n");
f_out.write("    libcontext - a slightly more portable version of boost::context\n");
f_out.write("    Copyright Martin Husemann 2013.\n");
f_out.write("    Copyright Oliver Kowalke 2009.\n");
f_out.write("    Copyright Sergue E. Leontiev 2013\n");
f_out.write("    Copyright Thomas Sailer 2013.\n");
f_out.write("    Minor modifications by Tomasz Wlostowski 2016.\n");
f_out.write("\n")
f_out.write(" Distributed under the Boost Software License, Version 1.0.\n");
f_out.write("      (See accompanying file LICENSE_1_0.txt or copy at\n");
f_out.write("            http://www.boost.org/LICENSE_1_0.txt)\n");
f_out.write("\n")
f_out.write("*/\n");


f_out.write("#include \"libcontext.h\"\n")


for [f_name, platform, compiler] in files:
    f_out.write("#if defined(LIBCONTEXT_PLATFORM_%s) && defined(LIBCONTEXT_COMPILER_%s)\n" %( platform, compiler ))

    f_out.write("__asm volatile(\n")

    for l in removeCCppComment (open(f_name).read()).split('\n'):
	tokens = l.split()

	if len(tokens) > 0 and tokens[0] not in ignore_tokens:
	    f_out.write("\"%s\\n\"\n"%l.replace('"','\\"'))
#	    f_out.write(l)
    f_out.write(");\n\n");
#    f_out.write(t)

    f_out.write("#endif\n\n")

f_out.close()
