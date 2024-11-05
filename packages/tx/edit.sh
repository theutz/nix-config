function help() {
	gum format <<-'markdown'
		# @name@

		@description@.

		## Usage

		```bash
		@root@ @name@ [FLAGS]
		```

		### Flags

		@help-flags@
	markdown
	echo
}

width=120
height="90%"

while [[ $# -gt 0 ]]; do
	case "$1" in
	--help | -h)
		show_help=true
		shift 1
		;;
	--width | -x)
		width="$2"
		shift 2
		;;
	--height | -y)
		height="$2"
		shift 2
		;;
	--* | -*)
		gum log -l error "$1: flag not recognized"
		gum log -l fatal "exiting"
		;;
	*)
		gum log -l error "$1: argument not recognized"
		gum log -l fatal "exiting"
		;;
	esac
done

if [[ -v show_help ]]; then
	help
	exit 0
fi

filename=$(tmuxp ls | fzf --tmux=left,30)
file="$TMUXP_CONFIG_DIR/$filename.yml"

if [[ -n "$TMUX" ]]; then
	tmux popup -x "$width" -y "$height" -EE "$EDITOR $file"
else
	"$EDITOR" "$file"
fi
