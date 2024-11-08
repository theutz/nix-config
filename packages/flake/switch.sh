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
		help
		exit 0
		;;
	*)
		fatal "argument not found: $1"
		;;
	esac
done
set -- "''${args[@]}"
