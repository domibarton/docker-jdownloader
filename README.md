## About

This is a Docker image for [JDownloader](http://www.jdownloader.org/) - the open-source download manager.

The Docker image currently supports:

* running JDownloader under its __own user__ (not `root`)
* running JDownloader in headless (non-GUI) mode
* changing of the __UID and GID__ for the JDownloader user

## Run

### Run via Docker CLI client

To run the JDownloader container you can execute:

```bash
docker run --name jdownloader -v <cfg path>:/jdownloader/cfg -v <media path>:/media domibarton/jdownloader
```

### Run via Docker Compose

You can also run the JDownloader container by using [Docker Compose](https://www.docker.com/docker-compose).

If you've cloned the [git repository](https://github.com/domibarton/docker-jdownloader) you can build and run the Docker container locally (without the Docker Hub):

```bash
docker-compose up -d
```

If you want to use the Docker Hub image within your existing Docker Compose file you can use the following YAML snippet:

```yaml
jdownloader:
    image: "domibarton/jdownloader"
    container_name: "jdownloader"
    volumes:
        - "<cfg path>:/jdownloader/cfg"
        - "<media path>:/media"
    restart: always
```

## Configuration

### Volumes

Please mount the following volumes inside your JDownloader container:

* `/jdownloader/cfg`: Holds all the JDownloader configuration files
* `/media`: Directory for downloaded media

### Configuration files

The JDownloader configuration files are located on `/jdownloader/cfg`, respectively your mounted directory on the host.

__IMPORTANT:__ It is recommended that you setup the [My JDownloader credentials](#My JDownloader credentials), so that you can easily configure your JDownloader settings via the [My JDownloader WebUI](https://my.jdownloader.org)

### My JDownloader credentials

If you want to use the [My JDownloader WebUI](https://my.jdownloader.org), you've to configure your credentials in the `/jdownloader/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json` configuration file. Here's an example content:

```
{
  "autoconnectenabledv2" : true,
  "email" : "your@mail.address",
  "password" : "your_secret_password",
}
```

### Downloader directory

To change the download directory, you've to edit the file `/jdownloader/cfg/org.jdownloader.settings.GeneralSettings.json` and add the following setting:

```
"defaultdownloadfolder" : "/media"
```

### UID and GID

By default JDownloader runs with user ID and group ID `666`.
If you want to run JDownloader with different ID's you've to set the `JDOWNLOADER_UID` and/or `JDOWNLOADER_GID` environment variables, for example:

```
JDOWNLOADER_UID=1234
JDOWNLOADER_GID=1234
```