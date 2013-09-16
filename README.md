You've created an awesome rerun command that is
flexible and environment independent because of 
the options you've defined for it.

How do you share your command as an automation building block to 
people writing process automation jobs but give them a 
friendly user interface?
Expose your command as a [Rundeck](http://rundeck.org) job step!

Use *job-step* to generate a single-step Job definition that calls your command.

Use *node-step-plugin* to generate a workflow step plugin.

The *rundeck-step* commands utilize the command metadata from
your rerun module to produce the needed wrapper code.