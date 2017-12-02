// Agent sensing in project hri.mas2j

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */
+sense <- -sense[source(robot_code)];.print("sensing"); !getStop1.

+!getStop1 : not stop1(_) <- .print("Undefined stop"); !getStop1.
+!getStop1 : stop1(1.0) <- .send(robot_code,tell,stop1(1.0)); !getStop2.
+!getStop1 : stop1(0.0) <- .send(robot_code,tell,stop1(0.0)); !getStop2.

+!getStop2 : not stop2(_) <- .print("Undefined pressure"); !getStop2.
+!getStop2 : stop2(1.0) <- .send(robot_code,tell,stop2(1.0)); !getStop3.
+!getStop2 : stop2(0.0) <-.send(robot_code,tell,stop2(0.0)); !getStop3.

+!getStop3 : not stop3(_) <- .print("Undefined location"); !getStop3.
+!getStop3 : stop3(1.0) <- .send(robot_code,tell,stop3(1.0)); !finish.
+!getStop3 : stop3(0.0) <- .send(robot_code,tell,stop3(0.0)); !finish.

+!finish : true <- .send(robot_code,tell,sensorsReady); -stop1(1.0)[source(self)]; -stop1(0.0)[source(self)]; -stop2(1.0)[source(self)];-stop2(0.0)[source(self)];-stop3(1.0)[source(self)]; -stop3(0.0)[source(self)].


