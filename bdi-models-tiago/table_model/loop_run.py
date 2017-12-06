#!/usr/bin/env python
import pexpect
import time
import re
import random
from itertools import product

def loop_run_rand(beliefs, num):
    for ii in range(0,num):
        f = open('meta_orders.txt', 'w')
        for i in beliefs:
            select = random.randint(0,len(i)-1)
            f.write(i[select]+'\n')
        f.close()
        run_bdi()
def loop_run(beliefs):
    total=1
    index_list=[]
    for i in list(product(*beliefs)):
        f = open('meta_orders.txt', 'a')
        for j in i:
            f.write(j+'\n')
        f.close()
        run_bdi()
def run_bdi():
    child = pexpect.spawn('./timed_hri.jar')
    time.sleep(10)
    pexpect.signal.SIGINT
    f1 = open('result/coverage_robot.txt', 'a')
    f1.write('------------\n')
    f1.close()
    i = 1
    for num,command in enumerate(open('output.txt','r')): 
        f = open('result/abstract_tests_rand300/abstract_test'+str(i)+'.txt', 'a')
        if re.search("-------",command):
            f.close()
            i = i+1
        else:
            f.write(command)


beliefs = [
    ["feed","clean","fridge","sink","recharge"],
    ["","stop"]
]
loop_run(beliefs)
# loop_run_rand(beliefs,num)
