#!/usr/bin/env zsh

PROJECT_HOME=$HOME/proj
export WORKON_HOME=~/.virtualenvs

export TF_VAR_git_worktree_root=$(git rev-parse --show-toplevel)
export TF_VAR_ssh_key_name=abhijitb