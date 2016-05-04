FROM ubuntu

ADD install-*.sh ./

ENV TERM linux
RUN apt-get update && apt-get -y install sudo wget
RUN . ./install-distroupdate.sh
RUN . ./install-basepackages.sh
RUN . ./install-git.sh
RUN . ./install-emacs.sh
RUN . ./install-zsh.sh
RUN . ./install-byobu.sh
RUN . ./install-golang.sh
RUN . ./install-awscli.sh
RUN . ./install-panoramix.sh

RUN . ./install-powerlinefonts.sh
# RUN . ./install-golangliteide.sh
# RUN . ./install-visualstudiocode.sh
# RUN . ./install-docker.sh

CMD ["/bin/zsh"]
