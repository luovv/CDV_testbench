// Agent robot_model in project hri.mas2j

/* Initial beliefs and rules */

/* Initial goals */
!reset.

/* Plans */

+!reset :  true <- add_time(10);.print("Robot is resetting"); coverage("robot-p1");!waiting.

+!waiting : not feed & not timeup<- .print("Waiting"); !waiting.
+!waiting : feed <- add_time(10);.print("You asked for feed");coverage("robot-p2"); -food[source(human)]; !readSensor.
+!waiting : not feed & timeup <- -food[source(human)];.print("timeup"); !recharge.


+!waiting : recharge <- -recharge[source(human)]; add_time(40); .print("recharge");  !recharge.

+!readSensor : not sensorsReady <- .send(sensors,tell,sense);!readSensor.
+!readSensor : sensorsReady <-.send(sensors,tell,sense); !goToFrige.

+!goToFrige : not stop1(1) <- add_time(30);.print("go to frige"); coverage_robot("p3");!grabFood.
+!grabFood : not stop2(1) <- add_time(30);.print("grab food"); coverage_robot("p3");!goToTable.
+!goToTable : not stop3(1) & feed <- add_time(30);.print("go to table"); coverage_robot("p3");!foodReady.


+!goToFrige : stop1(1) <- add_time(30);.print("Grabbed object"); coverage_robot("p3");!pause1.
+!grabFood : stop2(1) <- add_time(30);.print("Grabbed object"); coverage_robot("p3");!pause2.
+!goToTable : stop3(1) <- add_time(30);.print("Grabbed object"); coverage_robot("p3"); !pause3.

+!pause1 : true <- !grabFood.
+!pause2 : true <- !goToTable.
+!pause3 : true <- !foodReady.

+!foodReady : true <- .send(human,tell,feedReady);!done.
+!recharge : true <- .print("recharge");!done.

+!done : true <- coverage_robot("p11").
