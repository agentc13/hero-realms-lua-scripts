# Contributing to this repository

Here are instructions on how to contribute to this repo from the CLI (Command Line Interface), I will add instructions on how to do this from the GitHub Desktop app at a later date.

_all of this info was taken and modified from https://kbroman.org/github_tutorial/_

So you want to contribute changes to this repository? Here are instructions on how you can do this.

1.  Go to my repository on github. (https://github.com/agentc13/Hero-Realms-Lua-Scripts)

2.  Click the “Fork” button at the top right.

    You’ll now have your own copy of that repository in your github account.

3.  Open a terminal/shell. (If you are using vscode, "ctrl+shift+\`"  ("^+Shift+\`" on mac) will open a terminal in the IDE, you can use other methods as well)

4.  Type `$ git clone git@github.com:username/Hero-Realms-Lua-Scripts` where 'username' is your username.

    You’ll now have a local copy of your version of the repository.

5.  Change (cd) into the project directory.
    `$ cd Hero-Realms-Lua-Scripts`

6.  Add a connection to my repository.

    `$ git remote add agentc13 git://github.com/agentc13/Hero-Realms-Lua-Scripts`

## To check that you set up this remote correctly:

1. Go to your CLI and type
   `$ git remote -v`
2. Make changes to files.
   `git add` and `git commit` those changes
   `git push` them back to github. These will go to your _version_ of the repository.

3. Go to your version of the repository on github.

4. Click the “Pull Request” button at the top.

   The main repository will be on the left and your fork of the repository will be on the right.

5. Click the green button “Create pull request”.

6. Give a succinct and informative title, in the comment field give a short explanation of the changes ('Adding username_example.lua to repo')

7. Click the green button “Create pull request” again.

## Pulling others’ changes

Before you make further changes to the repository, you should check that your local version is up to date relative to the main version.

1. Go into the directory for the project and type:
   `$ git pull repo main` where _repo_ is the nickname you setup for the agentc13/Hero-Realms-Lua-Scripts repo.
   This will pull down and merge all of the changes that have been made to the main repo.

2. Now push them back to your github repository.
   `$ git push`
