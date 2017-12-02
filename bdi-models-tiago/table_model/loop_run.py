#!/usr/bin/env python

import pexpect
import time
import re

# Tree of belief decisions to write into meta agent
choose_belief_1 = ["feed","clean","fridge","sink","recharge"] #For a-c
choose_belief_2 = ["","stop"]

# Try all environment combinations once
for i1 in choose_belief_1:
	for i2 in choose_belief_2:
		f = open('meta_orders.txt', 'w')
		f.write(i1+'\n')
		f.write(i2+'\n')
		f.close()
		child = pexpect.spawn('./timed_hri.jar')
		time.sleep(5)
		pexpect.signal.SIGINT
		f1 = open('coverage_robot.txt', 'a')
		f1.write('------------\n')
		f1.close()

#Separate tests in individual files
# i = 1
# for num,command in enumerate(open('output.txt','r')): 
# 	f = open('abstract_tests/abstract_test'+str(i)+'.txt', 'a')
# 	if re.search("-------",command):
# 		f.close()
# 		i = i+1
# 	else:
# 		f.write(command)
