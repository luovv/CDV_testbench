// Agent sensing in project hri.mas2j

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */
+sense <- -sense[source(robot_code)];.print("sensing"); !getStop1.

//+!getStop : not stop(_) <- .print("Undefined stop"); !getStop1.
+!getStop1 : stop(1) <- .send(robot_code,tell,stop1(1)); !finish.
+!getStop1 : stop(0) <- .send(robot_code,tell,stop1(0)); !finish.



+!finish : true <- .send(robot_code,tell,sensorsReady); -stop(1)[source(self)]; -stop(0)[source(self)].


