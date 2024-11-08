MY_FLAKE_DIR="$HOME/@flake-path@"
export MY_FLAKE_DIR

function help() {
	gum format <<-'EOF'
		# @name@

		@description@.

		## Commands

		| Name | Description |
		| :--- | :---        |
		${lib.concatLines (lib.mapAttrsToList (_: cmd: ''
		  | ${lib.getName cmd} | ${cmd.meta.description or ""} |'')
		commands)}
	EOF
}

@loggers@

show_help=false
action=""

args=()

while [[ $# -gt 0 ]]; do
	case "$1" in
	--help | -h)
		show_help=true
		shift 1
		;;
	build | switch | goto | watch)
		action="$1"
		shift 1
		;;
	--* | -*)
		error "flag not recognized" flag "$1"
		fatal exiting
		;;
	*)
		args+=("$1")
		shift 1
		;;
	esac
done

set -- "${args[@]}"

if [[ ${#args[@]} -gt 0 ]]; then
	error "unrecognized arguments" args "${args[*]}"
	fatal exiting
fi

if [[ -z "$action" && $show_help ]]; then
	help
	exit 0
fi

if [[ ! -v action ]]; then
	error "no subcommand provided"
	fatal exiting
fi

"$action" "$@"
