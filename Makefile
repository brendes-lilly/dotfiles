REPO = $(shell pwd)
SCRIPTS_DIR = $(REPO)/scripts

install:
	./install.sh

update:
	if [ -z $$GITHUB_REPOSITORY ] || [ -z $$CODESPACES ]; then \
		echo "Not in a codespace; exiting"; \
		exit 1; \
	else \
		cd $(REPO); \
		git pull; \
		$(MAKE) install; \
	fi
	
sync:
	$(SCRIPTS_DIR)/sync.sh


.PHONY: install update sync

