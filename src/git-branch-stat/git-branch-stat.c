/*
 * print the current git branch name.
 * use `-b` to also print brackets around it.
 *
 */

#include <git2.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

/* check if repo has modifications */
static int check_status_cb(const char *path, unsigned int status_flags, void *payload) {
	int *has_changes = (int *)payload;

	/* check for index or working directory changes */
	if (status_flags & (
	    GIT_STATUS_INDEX_NEW |
	    GIT_STATUS_INDEX_MODIFIED |
	    GIT_STATUS_INDEX_DELETED |
	    GIT_STATUS_INDEX_RENAMED |
	    GIT_STATUS_INDEX_TYPECHANGE |
	    GIT_STATUS_WT_NEW |
	    GIT_STATUS_WT_MODIFIED |
	    GIT_STATUS_WT_DELETED |
	    GIT_STATUS_WT_RENAMED |
	    GIT_STATUS_WT_TYPECHANGE
	)) {
		/* stop iteration early once a change is found */
	    *has_changes = 1;
	    return 1;
	}

	return 0;
}

int main(int argc, char *argv[]) {
	int brackets = 0;
	int opt;

	while ((opt = getopt(argc, argv, "b")) != -1) {
		switch (opt) {
			case 'b':
				brackets = 1;
				break;
			default:
				return 1;
		}
	}

	git_libgit2_init();

	/* open repository */
	git_repository *repo = NULL;
	int error = git_repository_open_ext(&repo, ".", 0, NULL);
	if (error < 0) {
	    git_libgit2_shutdown();
		/* not a git repo or error */
	    return 0;
	}

	/* get current branch name */
	git_reference *head = NULL;
	error = git_repository_head(&head, repo);
	if (error < 0) {
	    git_repository_free(repo);
	    git_libgit2_shutdown();
	    return 0;
	}

	const char *branch_name = git_reference_shorthand(head);

	/* check for modifications */
	int has_changes = 0;
	git_status_options status_opts = GIT_STATUS_OPTIONS_INIT;
	status_opts.show = GIT_STATUS_SHOW_INDEX_AND_WORKDIR;
	status_opts.flags = GIT_STATUS_OPT_INCLUDE_UNTRACKED |
	                   GIT_STATUS_OPT_RENAMES_HEAD_TO_INDEX |
	                   GIT_STATUS_OPT_SORT_CASE_SENSITIVELY;

	error = git_status_foreach_ext(repo, &status_opts, check_status_cb,
					&has_changes);
	if (error < 0) {
	    git_reference_free(head);
	    git_repository_free(repo);
	    git_libgit2_shutdown();
	    return 0;
	}

	if (brackets) {
		printf("[%s%s]", branch_name, has_changes ? "+" : "");
    } else {
		printf("%s%s", branch_name, has_changes ? "+" : "");
    }

	/* cleanup */
	git_reference_free(head);
	git_repository_free(repo);
	git_libgit2_shutdown();

	return 0;
}
