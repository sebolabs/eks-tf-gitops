# DOCKER
A simple Docker configuration for running Terraform on any machine from within a Docker container.

## Assumptions
The following environment variables are accessible or directly passed to the `docker-compose` command execution:
```bash
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_SESSION_TOKEN
```

## Usage
Depending whether you want to use Amazon Linux or Ubuntu, use one of the provided set of commands below to build and run.
```bash
$ docker build -t tf-executor .

$ TF_WORKING_DIR=../terraform docker-compose run --rm tf-bash
```

### Output
------
```bash
========================================
AWS ACCOUNT ALIAS:
LOGGED IN AS: deployer@my.domain
MFA EXPIRES AT: 2022-04-25T10:26:43Z
========================================
CWD: /opt/tf-code
CWD CONTENT:
drwxr-xr-x  9 root root  288 Apr 23 15:33 .
drwxr-xr-x  1 root root 4096 Apr 23 15:00 ..
drwxr-xr-x  3 root root   96 Apr 23 14:32 bin
drwxr-xr-x 14 root root  448 Apr 23 13:02 bootstrap
drwxr-xr-x  5 root root  160 Apr 23 13:39 components
drwxr-xr-x  6 root root  192 Apr 23 14:17 etc
drwxr-xr-x  3 root root   96 Apr 23 14:34 modules
bash-4.2#
```
