#! /usr/bin/perl  -w

system("cd varipop/clr; ./do.sh");
system("cd varipop/clr/result; ./do.sh; cd sorted; ./do.sh");
