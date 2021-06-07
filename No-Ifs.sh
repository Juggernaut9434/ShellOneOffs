#!/bin/sh

# No If statements in Shell
# use &&, &, ||, ; instead

# documentation
pwd
ls

# Setup Environment
echo "test This is a Test" | tee foo

# found test
echo is:; [ -z "$(grep test foo)" ] && echo found test || echo no test found

# no horse found
echo horse:; [ -z "$(grep horse foo)" ] && echo found horse || echo no horse found

# clean up
rm foo
