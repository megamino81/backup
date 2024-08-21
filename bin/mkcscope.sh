#!/bin/sh 
rm -rf cscope.files cscope.out
find . \( -name '*.[ch]' \
-o -name '*.cpp' \
-o -name '*.cc' \
-o -name '*.py' \
-o -name '*.s' \
-o -name '*.S' \) -print > cscope.files
cscope -i cscope.files
