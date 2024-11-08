log() {
	if ! command -v gum 2>/dev/null; then
		printf "ERROR: 'gum' not found in PATH\n"
		exit 1
	fi

	gum log -s "$@"
}

debug() {
	if "${DEBUG:-false}"; then
		log -l debug "$@"
	fi
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
