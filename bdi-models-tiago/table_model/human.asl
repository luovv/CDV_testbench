// Agent environment in project hri.mas2j

/* Initial beliefs and rules */

/* Initial goals */
!setup.

/* Plans */

+!setup : meta <- !chooseLaser.
+!setup : true <- !setup.

+!chooseLaser : stop <- stop1; -stop[source(percept)]; coverage("human-p1"); !activate.
+!chooseLaser : not stop <- stop0; -stop[source(percept)]; coverage("human-p2"); !activate.

+!activate : feed <- -meta[source(meta)];.print("feed"); tofile("tell feed");coverage("human-p3");.send(robot_code,tell,feed); !waitingFeed.
+!activate : clean <- -meta[source(meta)];.print("clean"); tofile("tell clean");coverage("human-p4");.send(robot_code,tell,clean); !waitingClean.
+!activate : fridge <- -meta[source(meta)];.print("fridge"); tofile("tell fridge");coverage("human-p5");.send(robot_code,tell,fridge); !waitingFridge.
+!activate : sink <- -meta[source(meta)];.print("sink"); tofile("tell sink");coverage("human-p6");.send(robot_code,tell,sink); !waitingSink.
+!activate : recharge <- -meta[source(meta)];.print("recharge"); tofile("tell recharge");coverage("human-p11");.send(robot_code,tell,recharge); !waitingRecharge.


+!waitingFeed: not feedReady <-.print("Waiting feed");!waitingFeed.
+!waitingFeed: feedReady <- -feedReady[source(robot_code)]; coverage("human-p7"); !done.

+!waitingClean: not cleanReady <-.print("Waiting clean");!waitingClean.
+!waitingClean: cleanReady <- -cleanReady[source(robot_code)]; coverage("human-p8"); !done.

+!waitingFridge: not fridgeReady <-.print("Waiting fridge");!waitingFridge.
+!waitingFridge: fridgeReady <- -fridgeReady[source(robot_code)]; coverage("human-p9"); !done.

+!waitingSink: not sinkReady <-.print("Waiting sink");!waitingSink.
+!waitingSink: sinkReady <- -sinkReady[source(robot_code)]; coverage("human-p10"); !done.

+!waitingRecharge: not rechargeReady <-.print("Waiting recharge");!waitingRecharge.
+!waitingRecharge: rechargeReady <- -rechargeReady[source(robot_code)]; coverage("human-p10"); !done.

+!done: true <-.print("done"); coverage("plan5").

