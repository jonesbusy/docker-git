# Docker git client

## Build the image

```
docker build .
```

## Usage

```
docker run --rm -e LOCAL_USER_ID=$(id -u) -e GROUP_USER_ID=$(id -g) -v $(pwd):/git -v ${HOME}/.ssh:/home/git/.ssh -v ${HOME}/.gitconfig:/home/git/.gitconfig  <image name> <command>
```

Add an alias to your shell

```
alias gitd="docker run --rm -e LOCAL_USER_ID=$(id -u) -e GROUP_USER_ID=$(id -g) -v $(pwd):/git -v ${HOME}/.ssh:/home/git/.ssh -v ${HOME}/.gitconfig:/home/git/.gitconfig <image name>"
