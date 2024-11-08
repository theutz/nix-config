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
