#!/usr/bin/env python

import pexpect
import time
import re
import random

# Tree of belief decisions to write into meta agent
choose_belief_1 = ["feed","clean","fridge","sink","recharge"] #For a-c
choose_belief_2 = ["","stop"]


random.seed(300)
# Assemble 100 cases randomly but with constraints
for ii in range(0,20):
	f = open('result/meta_orders.txt', 'w')
	select2 = random.randint(0,3)
	f.write(choose_belief_1[select2]+'\n')
	select2 = random.randint(0,1)
	f.write(choose_belief_2[select2]+'\n')
	f.close()
	child = pexpect.spawn('./timed_hri.jar')
	time.sleep(10)
	pexpect.signal.SIGINT
	f1 = open('result/coverage_robot.txt', 'a')
	f1.write('------------\n')
	f1.close()

#Separate tests in individual files
i = 1
for num,command in enumerate(open('output.txt','r')): 
	f = open('result/abstract_tests_rand300/abstract_test'+str(i)+'.txt', 'a')
	if re.search("-------",command):
		f.close()
		i = i+1
	else:
		f.write(command)
