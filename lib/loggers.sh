log() {
	if ! command -v gum >/dev/null; then
		printf "ERROR: 'gum' not found in PATH\n"
		exit 1
	fi

	gum log \
		--structured \
		"${LOG_PREFIX:+--prefix="$LOG_PREFIX"}" \
		"$@"
}

debug() {
	if "${DEBUG:-false}"; then
		log -l debug "$@"
	fi
}

dump() {
	while [[ $# -gt 0 ]]; do
		debug -- dump "$1" "${!1}"
		shift 1
	done
}

fatal() {
	log -l fatal "$@"
}

error() {
	log -l error "$@"
}

warn() {
	log -l warn "$@"
}

info() {
	log -l info "$@"
}
