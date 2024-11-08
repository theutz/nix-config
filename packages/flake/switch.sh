@loggers@

help() {
	gum format <<-'markdown'
		# @main@ @name@

		@description@.

		## Usage

		```bash
		$ @main@ @name@ [FLAGS]
		```

		### Flags

		| Long   | Short | Description    |
		| :----- | :---- | :------------- |
		| --help | -h    | show this help |
	markdown
}

args=()
while [[ $# -gt 0 ]]; do
	case "$1" in
	--help | -h)
		show_help=true
		shift 1
		;;
	--* | -*)
		error "flag not found" "flag" "$1"
		fatal "exiting"
		;;
	*)
		args+=("$1")
		shift 1
		;;
	esac
done
set -- "${args[@]}"

if [[ "${show_help-false}" ]]; then
	help
	exit 0
fi
