The *rundeck-plugin* commands help you create [Rundeck](http://rundeck.org)
workflow step plugins from your rerun commands.

The *rundeck-plugin* module uses metadata about your commands to generate
a plugin configuration properties to present a similar rundeck web UI.

Example:
--------

Imagine you have a command, "waitfor:process", that checks for a system process  
and you would like to make it a custom job step.

Imagine the following command options: `rerun waitfor:process --name <> [--interval <30>]
The `--name <>` option is required while the `--interval` option is not
and has a default value, 30.

Use `rundeck-plugin:node-step` to create the plugin code.

	mkdir rerun-waitfor-process-plugin
	cd rerun-waitfor-process-plugin
    rerun rundeck-plugin:node-step --module waitfor --command process

The command will produce a source code project.

	.
	├── Makefile
	├── README.md
	└── rerun-waitfor-process-plugin
	    ├── contents
	    │   └── nodestep.sh
	    └── plugin.yaml

Run `make` to create a zip file suitable for deployment to a Rundeck instance.
Export the RDECK_BASE directory and run `make install` to deploy the plugin.

After the plugin has been deployed, you can set up a job to call it
as a job step. The `rundeck-plugin:node-step` command names the plugin
using the following convention: rerun-_module_-_command_-step.
For this example the plugin is named: "rerun-waitfor-process-step".

**Job definition**

Below is an example Job definition that calls the 
new plugin step. A job option is added to let the
user input the name of the process to check:

	- id: 1db3a163-9341-4ca9-9345-f03d6f14f901
	  name: call waitfor:process
	  description: check the host for a running process 
	  uuid: 1db3a163-9341-4ca9-9345-f03d6f14f901
	  group: fun
	  project: examples
	  loglevel: INFO
	  sequence:
	    keepgoing: false
	    strategy: node-first
	    commands:
	    - type: rerun-waitfor-process-step
	      nodeStep: true
	      configuration:
	        name: ${option.name}
	        interval: 3
	  options:
	    name:
	      required: true    
	      description: the process name to check 
