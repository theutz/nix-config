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
		error unknown arg "$1"
		fatal exiting
		;;
	esac
done

set -- "${args[@]}"

if [[ -n "${show_help:-""}" ]]; then
	debug "showing help"
	help
	exit1
fi
