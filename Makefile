REPO = $(shell pwd)
SCRIPTS_DIR = $(REPO)/scripts

install:
	sh install.sh

update:
	@if [ -z "$$GITHUB_REPOSITORY" ] || [ -z "$$CODESPACES" ]; then \
		echo "Not in a codespace; exiting"; \
		exit 1; \
	else \
		cd $(REPO); \
		git pull; \
		$(MAKE) install; \
	fi
	
sync:
	sh $(SCRIPTS_DIR)/sync.sh


.PHONY: install update sync

