MY_FLAKE_DIR="$HOME/@flake-path@"
export MY_FLAKE_DIR

@loggers@

function help() {
	gum format <<-'markdown'
		# @name@

		@description@.

		## Usage

		```bash
		$ flake [COMMAND] [FLAGS]
		```

		### Commands

		@help-actions@

		### Flags

		| Long      | Short | Description          |
		| :---      | :---  | :---                 |
		| --help    | -h    | show this help       |
		| --verbose | -v    | print debug messages |
	markdown
	echo
}

show_help=false
action=""

args=()

while [[ $# -gt 0 ]]; do
	case "$1" in
	--verbose | -v)
		DEBUG=true
		export DEBUG
		shift 1
		;;
	--help | -h)
		show_help=true
		shift 1
		;;
	@actions@)
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

debug "env" DEBUG "$DEBUG"
debug "env" MY_FLAKE_DIR "$MY_FLAKE_DIR"

if [[ ${#args[@]} -gt 0 ]]; then
	error "unrecognized arguments" args "${args[*]}"
	fatal exiting
fi

debug "all arguments received"

if [[ -z "$action" && "$show_help" == true ]]; then
	help
	exit 0
fi

debug "don't show root help"

if [[ "$show_help" == true ]]; then
	debug "forward help flag to subcommand"

	args=("$@")
	args+=("--help")
	set -- "${args[@]}"
fi

debug "no help command to forward to subcommand"

if [[ -z "$action" ]]; then
	error "no subcommand provided"
	fatal exiting
fi

LOG_PREFIX="$action"
export LOG_PREFIX

debug "env" "LOG_PREFIX" "$LOG_PREFIX"

debug "calling" subcommand "$action" args "'$*'"

"$action" "$@"
