ultra tldr:
adjust pk for operator in docker-compose
then in the same folder run ```docker-compose up -d``` or the needful build instructions should you prefer buid it yourself adding the needful ```--build``` and adjusting comments in docker-compose.yml
docker image on the hub is referenced by default, for those curious and lazy: https://hub.docker.com/repository/docker/solaaa/xai-docker-unofficial/general


default config will have it auto reset, consdier setting a discord webhook for notifications on failures
in most cases it 'should' pick back bup

updates likely will be needed as currently gotta use some jank automation to make this work, is not meant to be run as a daemon imo
otherwise it does try to auto update and run on it's own

*have fun* but dyor

docker-compose.yml can be yeeted of the key after launching, or can set it up by running the following updating operator key to the operator hot wallet's PK and optionally adding a discord webhook if you want pings on updates and things.
```
docker run --name xai-sentry-node --env OPERATOR_KEY_VARIABLE=keygohere  --env NOTIFICATION_WEBHOOK_OPTIONAL= --restart unless-stopped --cpus 3 --memory 5G solaaa/xai-docker-unofficial:latest
```

To view the log file, first find the container ID by running: 

```
docker ps
```

Then, use the container ID to execute the `cat` command:

```
docker exec <container_id> cat /var/log/sentry-node-cli.log
```

For those not using further automation, to pull latest verison we have to stop and recreate it. If you wanna learn how to do this stuff easier ask chatGPT to build your intuition on docker some.
```
docker stop xai-sentry-node && docker rm xai-sentry-node && docker pull solaaa/xai-docker-unofficial:latest
```
then re-run the initial 'docker run' command done prior, again having to re-input the needful operator PK

also on an ending ramble, your terminal likely stores a cache of recent commands in ~/.bash_history or ~/.zsh_history , if using the docker run command in terminal the PK will be there until trimmed or manually removed.
