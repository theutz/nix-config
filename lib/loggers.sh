log() {
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
