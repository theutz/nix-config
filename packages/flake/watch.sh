@loggers@

help() {
	gum format <<-'markdown'
		# @cmd@

		@description@.

		## Usage

		```bash
		$ @cmd@ [FLAGS]
		```

		### Flags

		| Long   | Short | Description    |
		| :---   | :---  | :---           |
		| --help | -h    | show this help |
	markdown
	echo
}

args=()

while [[ $# -gt 0 ]]; do
	case "$1" in
	--help | -h)
		debug parsed flag "'$1'"
		show_help=true
		shift 1
		;;
	--* | -*)
		debug parsed flag "'$1'"
		error unknown flag "'$1'"
		fatal exiting
		;;
	*)
		debug parsed arg "$1"
		shift 1
		;;
	esac
done

set -- "${args[@]}"

if [[ -n "${show_help:-""}" ]]; then
	debug "showing help"
	help
	exit 0
fi

if ! cd "$MY_FLAKE_DIR"; then
	error "could not switch to" dir "$MY_FLAKE_DIR"
	fatal exiting
fi

debug "watching" cmd "switch" args "'$*'"

LOG_PREFIX="$LOG_PREFIX switch" watchexec --clear --restart --notify -- switch "$@"
