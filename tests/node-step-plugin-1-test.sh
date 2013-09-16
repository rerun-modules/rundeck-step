#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m rundeck-step -p node-step-plugin [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "node-step-plugin"

# The Tests
# ---------
it_generates_a_plugin() {
	# Create a sample module
	module="freddy" command="dance" descr="sample $command command"
	rerun stubbs:add-module --module "$module" --description "test module"
	rerun stubbs:add-command --module "$module" --command "$command" --description "$descr"
	# Create a string and boolean option for the command.
	def_option_flags=( --module "$module" --command "$command" --export false)
	rerun stubbs:add-option ${def_option_flags[@]} --option jumps --description 'num jumps' \
		--arguments true --required true --default "3"
	rerun stubbs:add-option ${def_option_flags[*]} --option slides --description 'should also slide' \
		--arguments false --required false  --default "''"

	# Generate the plugin source base
	tmpdir=$(mktemp -d /tmp/rundeck-step.XXXXX)
	rerun rundeck-step:node-step-plugin --module $module --command $command --dir "$tmpdir"

	test -f "$tmpdir/Makefile"
	test -f "$tmpdir/README.md"
	test -d "$tmpdir/rerun-$module-$command-plugin"
	test -d "$tmpdir/rerun-$module-$command-plugin/contents"
	test -f "$tmpdir/rerun-$module-$command-plugin/contents/nodestep.sh"
	test -f "$tmpdir/rerun-$module-$command-plugin/plugin.yaml"
	grep "name: rerun-$module-$command-plugin" "$tmpdir/rerun-$module-$command-plugin/plugin.yaml"
	grep "title: $module:$command" "$tmpdir/rerun-$module-$command-plugin/plugin.yaml"
	grep "description: $descr" "$tmpdir/rerun-$module-$command-plugin/plugin.yaml"
	grep "\- type: Boolean" "$tmpdir/rerun-$module-$command-plugin/plugin.yaml"
	grep "\- type: String" "$tmpdir/rerun-$module-$command-plugin/plugin.yaml"

	# Try making the plugin into a distributable zip.
	cd "$tmpdir"
	make 
	test -f "rerun-$module-$command-plugin.zip"
}


