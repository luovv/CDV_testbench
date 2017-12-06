stats = open('assertion1.txt','a')

class Flag(smach.State):
    def __init__(self,config,sid):
        smach.State.__init__(self, outcomes=['outcome1','outcome2'])
        self.config = config
        self.id = sid

    def execute(self, userdata):
        global receivedflag1
        global thetime
        receivedflag1 = 0
        rospy.sleep(0.01)
        for i in self.config['trans']:
            rospy.Subscriber(i[0], Int8, self.callback)
            if self.receivedflag == 1:
                receivedflag = 0
                return i[0]
            else:
                return 'self'

        if "final_state" in self.config:
            stats.write('Assertion 1 at test '+ i[1]+': Passed')

    def callback(data):
        if data.data==1:
            self.receivedflag = 1
        else:
            self.receivedflag = 0

def main():
    configs = [{'trans':[['fridge',1]],"wait":300},{'trans':[['grab_food',2]],"wait":300},{'trans':[],"wait":300,"final_state":True}]
    with sm:
        for i, config in enumerate(configs):
            trans_dict={}
            for j in config['trans']:
                trans_dict[j[0]]=j[1]
                trans_dict['self']=i
            smach.StateMachine.add(i,Flag(config,i),transitions=trans_dict)

if __name__ == '__main__':
    try:
        main()
    except  rospy.ROSInterruptException:
        pass