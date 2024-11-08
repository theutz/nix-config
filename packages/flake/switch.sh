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
	echo

	if [[ -d "$MY_FLAKE_DIR/result" ]]; then
		info "cleaning up old builds..."
		rm -rf "$MY_FLAKE_DIR/result"
		echo
	fi

	if [[ "$(git log -1 --pretty=%B)" == "WIP" ]]; then
		echo
		info "uncommitting WIP changes..."
		git reset HEAD~
		echo
	fi

	debug "cleaned up"
}

trap cleanup EXIT

show_help=false

args=()

while [[ $# -gt 0 ]]; do
	case "$1" in
	--help | -h)
		debug parsed flag "'--help'"
		show_help=true
		shift 1
		;;
	--force | -f)
		debug parsed flag "'--force'"
		force=true
		shift 1
		;;
	--* | -*)
		error "flag not found" "flag" "$1"
		fatal "exiting"
		;;
	*)
		debug parsed arg "$1"
		args+=("$1")
		shift 1
		;;
	esac
done

set -- "${args[@]}"

debug "env" DEBUG "$DEBUG"
debug "env" LOG_PREFIX "$LOG_PREFIX"

if [[ "$show_help" == true ]]; then
	debug "show help"
	help
	exit 0
fi

debug "don't show help"

if ! cd "$MY_FLAKE_DIR"; then
	error "failed to cd " "dir" "$MY_FLAKE_DIR"
	fatal "exiting"
fi

if [[ "${force-false}" == false ]]; then
	info "checking git status..."
	echo
	if [[ -z "$(git -c color.status=always status --short | tee /dev/tty)" ]]; then
		warn "no changes detected. Exiting..."
		exit 0
	fi
	echo
fi

info "creating WIP commit..."
echo
git add -A && git commit -m "WIP"
echo

info "switching to new generation..."
echo
if darwin-rebuild switch --flake .; then
	echo
	info "profile switched"
else
	echo
	error "failure while changing profile"
	fatal "exiting"
fi
echo

current_generation="$(darwin-rebuild --list-generations | awk '/\(current\)/ {print $1}')"

info "committing changes..."
echo
if git commit --amend --message "Generation $current_generation"; then
	echo
	info "changes committed"
else
	echo
	error "changes could not be committed"
	fatal exiting
fi
echo

info "pushing changes"
echo
if git pull --rebase && git push; then
	echo
	info "changes pushed"
else
	echo
	error "changes could not be pushed"
	fatal exiting
fi
echo
