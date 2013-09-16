# rerun-%MODULE%-%COMMAND%-plugin

This is a [rundeck][rundeck] [script-based][script-based] [node-step][node-step] plugin that calls 
the rerun %MODULE%:%COMMAND% command.

# Build

To build the plugin run:

    make

It will produce:

    rerun-%MODULE%-%COMMAND%-plugin.zip

To install the plugin, ensure `$RDECK_BASE` is defined and run:

    make install

Copies it to $RDECK_BASE/libext    

[rundeck](http://rundeck.org)
[node-step](http://rundeck.org/docs/developer/workflow-step-plugin-development.html#remote-script-node-step-plugin)
[script-based](http://rundeck.org/docs/developer/workflow-step-plugin-development.html#script-based-step-plugins)