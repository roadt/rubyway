
#include <ruby.h>
#include <stdio.h>

#define USE_INSN_RET_NUM

#include "insns_info.inc"

const int OPNUM = 84;

main() {
  int i;

  printf("%-30s%-5s\t%-5s\t%-5s\n", 
	 "name",
	 "arglen",
	 "op",
	 "oplen"
	 );
  printf("-----------------------------------------------------------------------\n");
  for (i= 0; i<  OPNUM ; ++i ) {
    printf("%-30s%-5d\t%-5s\t%-5d\n", 
	   insn_name(i),
	   insn_ret_num(i),
	   insn_op_types(i),
	   insn_len(i)
	   );
  }
}
