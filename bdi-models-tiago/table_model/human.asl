// Agent environment in project hri.mas2j

/* Initial beliefs and rules */

/* Initial goals */
!setup.

/* Plans */

+!setup : meta <- !activate.
+!setup : true <- !setup.

+!activate : feed <- -meta[source(meta)];.print("feed"); tofile("tell feed");coverage("human-p1");.send(robot_code,tell,feed);.
+!activate : clean <- -meta[source(meta)];.print("clean"); tofile("tell clean");coverage("human-p2");.send(robot_code,tell,clean).
+!activate : fridge <- -meta[source(meta)];.print("fridge"); tofile("tell fridge");coverage("human-p3");.send(robot_code,tell,fridge).
+!activate : sink <- -meta[source(meta)];.print("sink"); tofile("tell sink");coverage("human-p4");.send(robot_code,tell,sink).

+!chooseLaser : stop000 <- stop000; -stop000[source(percept)]; coverage("human-p2"); !waitingFood.
+!chooseLaser : stop001 <- stop001; -stop000[source(percept)]; coverage("human-p3"); !waitingFood.
+!chooseLaser : stop010 <- stop010; -stop010[source(percept)]; coverage("human-p4"); !waitingFood.
+!chooseLaser : stop011 <- stop011; -stop011[source(percept)]; coverage("human-p5"); !waitingFood.
+!chooseLaser : stop100 <- stop100; -stop100[source(percept)]; coverage("human-p6"); !waitingFood.
+!chooseLaser : stop101 <- stop101; -stop101[source(percept)]; coverage("human-p7"); !waitingFood.
+!chooseLaser : stop110 <- stop110; -stop110[source(percept)]; coverage("human-p8"); !waitingFood.
+!chooseLaser : stop111 <- stop111; -stop111[source(percept)]; coverage("human-p9"); !waitingFood.

+!waitingFood: not feedReady <-.print("Waiting food"); coverage("plan5");!waitingFood.
+!waitingFood: feedReady <- -feedReady[source(robot_code)]; coverage("plan6"); !done.

+!done: true <-.print("done"); coverage("plan5").


