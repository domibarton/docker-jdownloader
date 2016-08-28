FROM openjdk:8-jre
MAINTAINER Dominique Barton

#
# Create user and group for JDownloader.
#

RUN groupadd -r -g 666 jdownloader \
    && useradd -r -u 666 -g 666 -d /jdownloader jdownloader

#
# Add JDownloader init script.
#

ADD jdownloader.sh /jdownloader.sh
RUN chmod 755 /jdownloader.sh

#
# Download JDownloader.
#

RUN wget -O /jdownloader/JDownloader.jar --progress=bar:force http://installer.jdownloader.org/JDownloader.jar

#
# Define container settings.
#

VOLUME ["/jdownloader/cfg", "/media"]

#
# Start JDownloader.
#

WORKDIR /jdownloader

CMD ["/jdownloader.sh"]
