#!/usr/bin/env python
"""
Written by Dejanira Araiza-Illan August 2016
"""

import sys
import os
import rospy
from sensor_msgs.msg import LaserScan
# from sensor_msgs.msg import LaserEcho
from std_msgs.msg import Int8

collided = 0


def process_this(data):
	global collided
	print data
	# for i,value in enumerate(data.ranges):
	# 	print data
	# 	break
	# 	break
	# 	if value < 0.2:
	# 		collided = 1
	# 		print value
	# 		break
	# 	#else:
		#	print 0
	rospy.sleep(50)

def main():
	rospy.init_node('sensors', anonymous=True) #Start node first
	rospy.loginfo("Start reading")
	pub = rospy.Publisher('collision_sensor', Int8, queue_size=1,latch=True)
	# pub = rospy.Publisher('collision_sensor', Int8, queue_size=1,latch=True)
	global collided
	rospy.Subscriber("/scan",LaserScan,process_this)
	# rospy.Subscriber("/scan",LaserEcho,process_this)
	while not rospy.is_shutdown():
		
		# print 'abcdefg'
		rospy.sleep(1)
		# if collided == 1:
		# 	pub.publish(1)
		# 	rospy.sleep(0.25)
		# 	collided = 0
		# else:
		# 	pub.publish(0)
		# 	rospy.sleep(0.25)
	
#---------------------------------------------------------------------------------------------------
if __name__ == '__main__':
	try:
    		main()
	except rospy.ROSInterruptException: #to stop the code when pressing Ctr+c
		pass
        	
