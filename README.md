# Scripts

Repository contains helpful scripts for Hacker Game development.

## Running Hacker Game locally

Use `aws configure` and provide credentials before both installation and starting.

### Installation
Install whole stack running:
```
./install.sh
```

### Starting
Next time when you will want to start dev environment run:
```
./start.sh
```

Note: You can use `./start.sh [VERSION]` to choose specific version of Backend docker image.

### Stopping
After you finish working run:
```
./stop.sh
```
to stop database.
