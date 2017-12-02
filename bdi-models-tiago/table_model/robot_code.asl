// Agent robot_model in project hri.mas2j

/* Initial beliefs and rules */

/* Initial goals */
!reset.

/* Plans */

+!reset :  true <- add_time(10);.print("Robot is resetting"); coverage("robot-p1");!waiting.

+!waiting : not feed & not clean & not fridge & not sink & not recharge & not timeup<- .print("Waiting"); !waiting.
+!waiting : not feed & not clean & not fridge & not sink & not recharge & timeup <- -feed[source(human)];.print("timeup"); !recharge.

+!waiting : feed <- coverage("robot-p2"); add_time(10);.print("You asked for feed"); -feed[source(human)];.send(sensors,tell,sense); !feed_readSensor.
+!waiting : clean <- add_time(10);.print("You asked for clean");coverage("robot-p3"); -clean[source(human)]; .send(sensors,tell,sense);!clean_readSensor.
+!waiting : fridge <- add_time(10);.print("You asked for fridge");coverage("robot-p4"); -fridge[source(human)]; .send(sensors,tell,sense);!fridge_readSensor.
+!waiting : sink <- add_time(10);.print("You asked for sink");coverage("robot-p5"); -sink[source(human)]; .send(sensors,tell,sense);!sink_readSensor.
+!waiting : recharge <- add_time(10);.print("You asked for recharge"); coverage("robot-p6"); -recharge[source(human)]; .send(sensors,tell,sense);!recharge_readSensor.

+!feed_readSensor : not sensorsReady <- .send(sensors,tell,sense);!feed_readSensor.
+!feed_readSensor : sensorsReady <-.send(sensors,tell,sense); coverage("robot-p7"); !feed_moveToFridge.

+!clean_readSensor : sensorsReady <-.send(sensors,tell,sense); coverage("robot-p8"); !clean_moveToHuman.

+!fridge_readSensor : not sensorsReady <- !feed_readSensor.
+!fridge_readSensor : sensorsReady <-.send(sensors,tell,sense); coverage("robot-p9"); !fridge_moveToFridge.

+!sink_readSensor : not sensorsReady <-!feed_readSensor.
+!sink_readSensor : sensorsReady <-.send(sensors,tell,sense); coverage("robot-p10"); !sink_moveToSink.

+!recharge_readSensor : not sensorsReady <-!recharge_readSensor.
+!recharge_readSensor : sensorsReady <-.send(sensors,tell,sense); coverage("robot-p10"); !recharge_recharge.

//+!moveToFridge : not stop1(1) <- add_time(10);.print("go to frige"); coverage_robot("p3");!grabFood.
//+!grabFood : not stop2(1) <- add_time(10);.print("grab food"); coverage_robot("p3");!goToTable.
//+!goToTable : not stop3(1) & feed <- add_time(10);.print("go to table"); coverage_robot("p3");!foodReady.


+!feed_moveToFridge : not stop(1) <- add_time(10);.print("Move to fridge"); coverage("robot-p11");!feed_grabFood.
+!feed_moveToFridge : stop(1) <- add_time(10);.print("feed pause"); coverage("robot-p12");!feed_grabFood.
+!feed_grabFood : true <- add_time(10);.print("Grab Food"); coverage("robot-p13");!feed_moveToHuman.
+!feed_moveToHuman: true <- add_time(10);.print("Move to human"); coveraget("robot-p14");.send(human,tell,feedReady);!recharge.

+!clean_moveToHuman: not stop(1) <- add_time(10);.print("Move to human"); coverage("robot-p15");!clean_grabFood.
+!clean_moveToHuman: stop(1) <- add_time(10);.print("clean pause"); coverage("robot-p16");!clean_grabFood.
+!clean_grabFood : true <- add_time(10);.print("Grab food"); coverage("robot-p17");!clean_moveToSink.
+!clean_moveToSink: true <- add_time(10);.print("Move to sink"); coverage("robot-p18");!clean_dropSink.
+!clean_dropSink : true <- add_time(10);.print("Drop sink"); coverage("robot-p19");.send(human,tell,cleanReady);!recharge.

+!fridge_moveToFridge : not stop(1) <- add_time(10);.print("move to Fridge"); coverage("robot-p20");.send(human,tell,fridgeReady);!recharge.
+!fridge_moveToFridge : stop(1) <- add_time(10);.print("fridge pause"); coverage("robot-p21");.send(human,tell,fridgeReady);!recharge.

+!sink_moveToSink : not stop(1) <- add_time(10);.print("go to frige"); coverage("robot-p22");.send(human,tell,sinkReady);!recharge.
+!sink_moveToSink : stop(1) <- add_time(10);.print("pause"); coverage("robot-p23");.send(human,tell,sinkReady);!recharge.

+!recharge_recharge : not stop(1) <- .print("recharge"); coverage("robot-p24");.send(human,tell,rechargeReady);!done.
+!recharge_recharge : stop(1) <- .print("recharge"); coverage("robot-p25");.send(human,tell,rechargeReady);!done.

+!recharge : true <- .print("recharge"); coverage("robot-p26");.send(human,tell,rechargeReady);!done.

//+!grabFood : stop2(1) <- add_time(30);.print("Grabbed object"); coverage_robot("p3");!pause2.
//+!goToTable : stop3(1) <- add_time(30);.print("Grabbed object"); coverage_robot("p3"); !pause3.

//+!pause1 : true <- !grabFood.
//+!pause2 : true <- !goToTable.
//+!pause3 : true <- !foodReady.

//+!foodReady : true <- .send(human,tell,feedReady);!done.
//+!recharge : true <- .print("recharge");!done.



+!done : true <- print("done").