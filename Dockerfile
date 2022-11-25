FROM ubuntu:22.04

# https://www.scala-sbt.org/1.x/docs/Installing-sbt-on-Linux.html
# The quotes on the two echo commands are necessary, for some reason.
RUN apt-get update
RUN apt-get install apt-transport-https curl gnupg -yqq
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list
RUN curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import
RUN chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk scala sbt
# Grab from viirya's fork of this project - the original has been dead for some time and doesn't work with sbt anymore
RUN git clone https://github.com/viirya/eventsim.git
WORKDIR /eventsim
RUN sbt assembly
RUN chmod +x bin/eventsim

CMD [ "/bin/bash" ]