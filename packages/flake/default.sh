MY_FLAKE_DIR="$HOME/@flake-path@"
export MY_FLAKE_DIR

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

@loggers@

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

if [[ ${#args[@]} -gt 0 ]]; then
	error "unrecognized arguments" args "${args[*]}"
	fatal exiting
fi

if [[ -z "$action" && "$show_help" == true ]]; then
	help
	exit 0
fi

if [[ "$show_help" == true ]]; then
	args=("$@")
	args+=("--help")
	set -- "${args[@]}"
fi

if [[ -z "$action" ]]; then
	error "no subcommand provided"
	fatal exiting
fi

LOG_PREFIX="$action"
export LOG_PREFIX

"$action" "$@"
