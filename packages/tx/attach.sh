function help() {
	gum format <<-'markdown'
		# @cmd@

		@description@.

		## Usage

		```bash
		@cmd@ [FLAGS]
		```

		### Flags

		@help-flags@
	markdown
	echo
}

args=()

while [[ $# -gt 0 ]]; do
	case "$1" in
	--help | -h)
		show_help=true
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

if [[ -v show_help ]]; then
	help
	exit 0
fi

set -- "${args[@]}"

if [[ $# -gt 0 ]]; then
	gum log -l error "$*: argument\(s\) not recognized"
	gum log -l fatal "exiting"
fi

filename="$(tmuxp ls | fzf --tmux=left,30)"
gum log -l debug -s "Session" "filename" "$filename"

file="$HOME/$TMUXP_CONFIG_DIR/$filename.yml"
gum log -l debug -s "Session" "path" "$file"

session=$(yq -r '.session_name' "$file")
gum log -l debug -s "Session" "name" "$session"

if ! tmux has -t "$session"; then
	gum log -l debug -s "Session" "exists" "true"
	gum log -l info -s "Loading" "session" "$session" "path" "$file"
	tmuxp load -d "$filename"
else
	gum log -l debug -s "Session" "exists" "false"
fi

if [[ -n "$TMUX" ]]; then
	tmux switch-client -t "$session"
else
	tmux attach-client -t "$session"
fi
