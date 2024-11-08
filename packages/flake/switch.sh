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

		| Long      | Short | Description          |
		| :-----    | :---- | :-------------       |
		| --help    | -h    | show this help       |
		| --verbose | -v    | print debug messages |
	markdown
	echo
}

cleanup() {
	debug "cleaning up..."

	if [[ -d "$MY_FLAKE_DIR/result" ]]; then
		info "cleaning up old builds..."
		rm -rf "$MY_FLAKE_DIR/result"
	fi

	if [[ "$(git log -1 --pretty=%B)" == "WIP" ]]; then
		info "uncommitting WIP changes..."
		git reset HEAD~
	fi

	debug "cleaned up"
}

trap cleanup EXIT

show_help=false

args=()

while [[ $# -gt 0 ]]; do
	case "$1" in
	--help | -h)
		show_help=true
		shift 1
		;;
	--force | -f)
		force=true
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

debug "env" DEBUG "$DEBUG"
debug "env" LOG_PREFIX "$LOG_PREFIX"

if [[ "$show_help" == true ]]; then
	help
	exit 0
fi

if ! cd "$MY_FLAKE_DIR"; then
	error "failed to cd " "dir" "$MY_FLAKE_DIR"
	fatal "exiting"
fi

if [[ "${force-false}" == false ]]; then
	info "checking git status..."
	if [[ -z "$(git -c color.status=always status --short | tee /dev/tty)" ]]; then
		warn "no changes detected. Exiting..."
		exit 0
	fi
	echo
fi

info "creating WIP commit..."
git add -A && git commit -m "WIP"

info "switching to new generation..."
if darwin-rebuild switch --flake .; then
	info "profile switched"
else
	error "failure while changing profile"
	fatal "exiting"
fi

current_generation="$(darwin-rebuild --list-generations | awk '/\(current\)/ {print $1}')"

info "committing changes..."
if git commit --amend --message "Generation $current_generation"; then
	info "changes committed"
else
	fatal "changes could not be committed"
fi

info "pushing changes"
if git pull --rebase && git push; then
	info "changes pushed"
else
	fatal "changes could not be pushed"
fi
