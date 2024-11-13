{
	onefetch

	gum format <<-'markdown'
		## Commands

		@commands@

		## Packages

		@packages@
	markdown
} | gum pager
