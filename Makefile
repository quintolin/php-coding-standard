SHELL := /bin/sh
.POSIX: # enable POSIX compatibility
.SUFFIXES: # no special suffixes
.DEFAULT_GOAL := default

# dummy entry to force make to do nothing by default
.PHONY: default
default:
	@echo "Please choose target explicitly."

# git helper: push current branch to configured remotes
.PHONY: git_push_current_branch
git_push_current_branch:
	git remote | xargs -L1 git push --verbose

# git helper: push all tags to all configured remotes
.PHONY: git_push_tags
git_push_tags:
	git remote | xargs -L1 git push --verbose --tags

# lint all files against EditorConfig settings
.PHONY: lint_editorconfig
lint_editorconfig:
	docker container run --rm --user=$$(id --user):$$(id --group) --volume=$$PWD:/check mstruebing/editorconfig-checker:v3.0.1

# lint PHP coding style
.PHONY: lint_coding_style
lint_coding_style:
	docker container run --rm --user=$$(id --user):$$(id --group) --volume=$$PWD:/code ghcr.io/php-cs-fixer/php-cs-fixer:3.54-php8.3 check --verbose --show-progress=dots

# fix PHP coding style
.PHONY: fix_coding_style
fix_coding_style:
	docker container run --rm --user=$$(id --user):$$(id --group) --volume=$$PWD:/code ghcr.io/php-cs-fixer/php-cs-fixer:3.54-php8.3 fix --verbose --show-progress=dots
