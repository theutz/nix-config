@loggers@

help() {
	gum format <<-'markdown'
		# @name@

		@description@

		## Usage

		```bash
		@name@ [SUBCOMMAND] [FLAGS] [ARGUMENTS] [-- [SUBCOMMAND ARGS]]
		```

		### Flags

		| Long       | Short | Description             |
		| :---       | :---  | :---                    |
		| --help     | -h    | show this help          |
		| --unstable | -u    | use the unstable branch |
		| --verbose  | -v    | enable verbose logging  |

		## Subcommands

		### `search`

		```
		@name@ search [FLAGS] [ARGUMENTS] [-- [RUN ARGS]]
		```

		#### Flags

		| Long  | Short | Description              |
		| :---  | :---  | :---                     |
		| --run | -r    | run the command if found |
	markdown
}

ref="flake:nixpkgs"

if [[ $# == 0 ]]; then
	error "no arguments found"
	show_help=true
else
	show_help=false
fi

action=""
args=()
while [[ $# -gt 0 ]]; do
	debug -- parsing item "$1"
	case "$1" in
	--verbose | -v)
		DEBUG=true
		export DEBUG
		debug -- parsed flag "$1"
		;;
	--help | -h)
		show_help=true
		;;
	--unstable | -u)
		ref="NixOS/nixpkgs/nixpkgs-unstable"
		;;
	search | s)
		action="search"
		;;
	--)
		args+=("${args[@]}")
		break
		;;
	*)
		args+=("$1")
		;;
	esac
	shift 1
done

set -- "${args[@]}"

if [[ $show_help == true ]]; then
	help
	exit 0
fi

function search() {
	LOG_PREFIX="search"
	export LOG_PREFIX
	args=()
	do_run=false
	while [[ $# -gt 0 ]]; do
		debug -- parsed item "$1"
		case "$1" in
		--run | -r)
			do_run=true
			;;
		*)
			args+=("$1")
			;;
		esac
		shift 1
	done
	set -- "${args[@]}"

	res="$(gum spin -- \
		nix search --quiet "$ref" --json "$1" |
		jq --raw-output0 -f <(
			cat <<-'jq'
				to_entries []
				| { name: .key } + .value
				| .name |= split(".")
				| select((.name | length) <= 3)
				| .name |= last
			jq
		) |
		fzf \
			--query "$1" \
			--read0 \
			--highlight-line \
			--preview='echo {} | jq -C' \
			--preview-window=wrap \
			--sync)"

	{
		v=do_run
		debug "var" "${!v}" "$v"
	}

	if [[ "$do_run" == true ]]; then
		name="$(echo "$res" | jq -r '.name')"
		debug -- running ref "$ref" name "$name"
		nix run "$ref#$name" -- "$@"
	else
		debug "echoing output"
		echo "$res"
	fi
}

debug action is "$action"
debug -- args are "$*"

"$action" "$@"
