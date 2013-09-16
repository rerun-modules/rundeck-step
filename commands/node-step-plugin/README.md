The *node-step-plugin* command will create a Rundeck
[workflow step plugins](http://rundeck.org/docs/developer/workflow-step-plugin-development.html#workflow-node-step-plugin-plugin) 
from your rerun command definition.
The *node-step-plugin* command uses metadata from your rerun command to generate
a plugin that defines configuration properties that map your rerun
command's options into Rundeck job step UI inputs. 
Visible as a plugin, Rundeck job writers see your rerun command as a well defined
workflow step in the GUI or as formailzed configuration items in a job definition file.

Besides generating the plugin code, the node-step-plugin command will also 
create a Makefile that packages the plugin and can deploy it to a local rundeck instance.
You will also get a sample job.yaml file that shows how a user can 
invoke plugin as a job step.

Example:
--------

Imagine you have a command, "waitfor:process", that checks for a system process  
and you would like to make it a custom job step.

Let's say waitfor:process defines the following command options: `rerun waitfor:process --name <> [--interval <30>]`.
The `--name <>` option is required while the `--interval` option is not
since it has a default value, 30.

Run `rundeck-plugin:node-step-plugin` to create the plugin code.

	mkdir rerun-waitfor-process-plugin
	cd rerun-waitfor-process-plugin
    rerun rundeck-plugin:node-step-plugin --module waitfor --command process

The command will produce a source code project.

	.
	├── Makefile
	├── README.md
	└── rerun-waitfor-process-plugin
	    ├── contents
	    │   └── nodestep.sh
	    ├── job.yaml	    
	    └── plugin.yaml

Run `make` to create a zip file suitable for deployment to a Rundeck instance.
Export the RDECK_BASE directory and run `make install` to deploy the plugin.

After the plugin has been deployed, you can load the sample job to call it.

    rd-jobs -p myproject -F yaml -f job.yaml


