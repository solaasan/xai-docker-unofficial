ultra tldr:
adjust pk for operator in docker-compose
then in the same folder run ```docker-compose up -d``` or the needful build instructions should you prefer buid it yourself adding the needful ```--build``` and adjusting comments in docker-compose.yml
docker image on the hub is referenced by default, for those curious and lazy: https://hub.docker.com/repository/docker/solaaa/xai-docker-unofficial/general


default config will have it auto reset, consdier setting a discord webhook for notifications on failures
in most cases it 'should' pick back bup

updates likely will be needed as currently gotta use some jank automation to make this work, is not meant to be run as a daemon imo
otherwise it does try to auto update and run on it's own

*have fun* but dyor