MY_FLAKE_DIR="$HOME/@flake-path@"
export MY_FLAKE_DIR

LOG_PREFIX="@name@"
export LOG_PREFIX

@loggers@

help() {
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

DEBUG=false
show_help=false
action=""

args=()

while [[ $# -gt 0 ]]; do
	case "$1" in
	--verbose | -v)
		DEBUG=true
		export DEBUG
		debug parsed flag "'$1'" known "true"
		shift 1
		;;
	--help | -h)
		debug parsed flag "'$1'" known "true"
		show_help=true
		shift 1
		;;
	@actions@)
		debug "parsed" arg "$1" known "true"
		action="$1"
		shift 1
		;;
	--* | -*)
		error "parsed" flag "$1" known "false"
		fatal exiting
		;;
	*)
		debug parsed arg "$1" known "false"
		args+=("$1")
		shift 1
		;;
	esac
done

set -- "${args[@]}"

debug "env" DEBUG "$DEBUG"
debug "env" MY_FLAKE_DIR "$MY_FLAKE_DIR"

if [[ ${#args[@]} -gt 0 ]]; then
	error "unknown" args "${args[*]}"
	fatal exiting
fi

debug "parsing complete"

if [[ -z "$action" && "$show_help" == true ]]; then
	debug "showing @name@ help..."
	help
	exit 0
fi

if [[ "$show_help" == true ]]; then
	debug "forward help flag to" action "$action"

	args=("$@")
	args+=("--help")
	set -- "${args[@]}"
fi

if [[ -z "$action" ]]; then
	error "no subcommand provided"
	fatal exiting
fi

debug "calling" subcommand "$action" args "'$*'"

LOG_PREFIX="$LOG_PREFIX $action" "$action" "$@"

debug "action successful" action "$action"
