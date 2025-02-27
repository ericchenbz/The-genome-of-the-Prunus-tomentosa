#!/usr/bin/python
import sys
import commands
import os
if len(sys.argv) <> 3:
        print "Usage: " + sys.argv[0] + " file1 file2"
        sys.exit(-1)
file1=open(sys.argv[1],'r')
file2=open(sys.argv[2],'w')
head=file1.readline()
sample=head.split('\t')
file2.write('Desc\t'+'\t'.join(sample[:-1])+'\n')
Line1=file1.readlines()
for line1 in Line1:
        lin1=line1.split('\t')
        file2.write('(null)\t'+'\t'.join(lin1[:-1])+'\n')
file1.close()
file2.close()

#Orthogroup     CON     DASZ    Kiwifruit       TGY     YK10    Total
#OG0000000      949     0       0       0       0       949
