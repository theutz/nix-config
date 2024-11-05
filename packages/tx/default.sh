function help() {
	gum format --type=markdown <<-'EOF'
		# @name@

		@description@.

		## Usage

		```
		@name@ [SUBCOMMAND] [FLAGS]
		```

		### Flags

		@help-flags@

		### Subcommands

		@help-actions@
	EOF
	echo
}

args=()
while [[ $# -gt 0 ]]; do
	case "$1" in
	--help | -h)
		show_help=true
		shift 1
		;;
	@actions@)
		action="$1"
		shift 1
		;;
	--* | -*)
		gum log -l error "$1: flag not recognized"
		gum log -l fatal "exiting"
		;;
	*)
		args+=("$1")
		shift 1
		;;
	esac
done

if [[ ! -v action && ! -v show_help ]]; then
	gum log -l error "no arguments provided"
	gum log -l fatal "exiting"
fi

if [[ ! -v action && -v show_help ]]; then
	help
	exit 0
fi

if [[ -v action && -v show_help ]]; then
	args+=("--help")
fi

set -- "${args[@]}"

"$action" "$@"
