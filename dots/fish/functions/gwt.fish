function gwt --description "Create git worktree with new branch from current branch"
    if test (count $argv) -lt 1
        echo "Usage: gwt <new-branch-name> [base-branch]"
        return 1
    end

    set -l new_branch $argv[1]
    set -l base_branch (git rev-parse --abbrev-ref HEAD)

    if test (count $argv) -ge 2
        set base_branch $argv[2]
    end

    set -l parent_dir (dirname (pwd))
    set -l worktree_path "$parent_dir/$new_branch"

    git worktree add -b $new_branch $worktree_path $base_branch
    echo "Created worktree at $worktree_path"
    echo "To push with tracking: git -C $worktree_path push -u origin $new_branch"
end
