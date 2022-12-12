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
#RUN git clone https://github.com/viirya/eventsim.git

# COPY /bin /eventsim/bin
# COPY /data /eventsim/data
# COPY /examples /eventsim/examples
# COPY /project /eventsim/project
# COPY /src /eventsim/src

# COPY ./java.config /

COPY . /eventsim

WORKDIR /eventsim
RUN sbt assembly

# Important note: bin/eventsim is NOT the build artefact.
# The build from sbt assembly will create /eventsim/target/scala-2.12/eventsim-assembly-2.0.jar
# bin/eventsim is simply an executable script to run that JAR with the JVM.
RUN chmod +x bin/eventsim
RUN sed -i -e 's/\r$//' bin/eventsim
# Use this in combination with docker run -it container_name:tag to debug things
#CMD [ "/bin/bash" ]
# Dev params - this will be changed later to add an actual confluent config
CMD ./bin/eventsim -c configs/Guitar-config.json --continuous --from 14 --nusers 2000 -k 1