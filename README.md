# firefund-lfs

Basically this is for all the large files we need to collaborate on. This includes Illustrator/Photoshop files. Images and pdfs.
You need to be in the [Creative class](https://github.com/orgs/Firefund/teams/creative-class) to have _push_ access to this 
repository.

## Prerequisites

You can test if you have `git` and `git-lfs` installed by trying to call them in your terminal/cmd.
```
git --version
git lfs
```

1. Install [git](https://git-scm.com/downloads) - our version control
1. Install [git lfs](https://git-lfs.github.com/) - our version control for large files like pictures and Illustrator documents


## Getting started

1. Go to https://github.com/Firefund/firefund-lfs/ and copy the git url.
1. Download the repository (`git lfs clone https://github.com/Firefund/firefund-lfs.git`) and `cd` into the firefund-lfs folder.
1. Download our files from git Large File Storage (lfs) by writting `git lfs pull`.

You can see which type of files that are in git lfs by writting: `git lfs track`.
And you can add new file types by writting: `git lfs track "*.filetype"` where _filetype_ is the file extension that you want to
put in git lfs, e.g. `*.ai` or `*.pdf`.


## Using git lfs

After the steps in **Getting started**, you should only need to use _normal_ git commands. That is:

1. `git pull` - download all new commits and git lfs files.
1. `git status` - see if you have any files to commit or push.
1. `git commit -am "message"` - commit files with a "message".
1. `git push` - push files to our server.


## Issues, Problems and Help

Please create a new [issue in firefund-lfs](https://github.com/firefund/firefund-lfs/issues), so we can document issues and
write them down here. Then post the link in our Slack and maybe add @troldmand or @dotnetcarpenter, so they can help you out.
