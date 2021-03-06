# Compare this file to:
# https://github.com/open-contracting/standard_profile_template/blob/master/include/config.mk

# Edit these variables as appropriate.

# The space-separated, period-prefixed translations to build (for easier substitutions).
TRANSLATIONS=.es
# The source language and translations to build.
LANGUAGES=.en $(TRANSLATIONS)

# Directory of documentation files to build with Sphinx.
DOCS_DIR=docs
# Directory of catalog files.
LOCALE_DIR=locale
# Directory in which to build documentation files.
BUILD_DIR=build
# Extra build files or directories. (These should match paths in .gitignore.)
EXTRA_BUILD_FILES=docs/_static/patched
# Files that are built and distributed (you may use Bash extended globbing).
DIST_FILES=schema/profile/release-schema.json schema/profile/codelists schema/patched docs/extensions/!(index).md
# Directory in which to build .pot files.
POT_DIR=$(BUILD_DIR)/locale
# The prefix, if any, to the schema and codelists domains.
DOMAIN_PREFIX=ppp-
# Directory containing assets to copy to the build directory (no trailing slash).
ASSETS_DIR=
# The Transifex project name.
TRANSIFEX_PROJECT=ocds-for-ppps

# Compile PO files for codelists and schema to MO files, so that `translate` succeeds.
.PHONY: compile
compile:
	pybabel compile --use-fuzzy -d $(LOCALE_DIR) -D $(DOMAIN_PREFIX)schema
	pybabel compile --use-fuzzy -d $(LOCALE_DIR) -D $(DOMAIN_PREFIX)codelists

# Put local targets below.

# Update OCDS Show for PPPs.
.PHONY: update_ocds_show
update_ocds_show:
	curl -Ss -O https://codeload.github.com/open-contracting/ocds-show-ppp/zip/gh-pages
	unzip -q gh-pages
	rm -f gh-pages
	rm -rf docs/_static/ocds-show
	# Delete these files, which will otherwise be caught by `sphinx-build -b gettext`.
	rm -f ocds-show-ppp-gh-pages/CONTRIBUTING.md
	rm -f ocds-show-ppp-gh-pages/README.md
	mv ocds-show-ppp-gh-pages docs/_static/ocds-show
