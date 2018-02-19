## Visual Studio Code for Lumen
Thanks to the work of [Jingsheng Wang](https://github.com/INsReady/docker-vscode-php) and a few modifications I created a portable "Visual Studio Code" for Lumen software development. This image meets [requirements to work with Lumen 5.6](https://lumen.laravel.com/docs/5.6#server-requirements) and have vscode extensions for:

- Adds syntax highlighting, commands, hover tips, and linting for Dockerfile and docker-compose files.
- Support for dotenv file syntax.
- Debug support for PHP with XDebug - Advanced Autocompletion and Refactoring support for PHP

## How to use

### Launch:

To launch the "IDE" and set the current folder as the root of your application:

```bash
$ docker run -ti --rm -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/var/www/html \ 
        -e DISPLAY=unix$DISPLAY -e GITUSERNAME='agsotelo' -e GITUSEREMAIL='agsotelo@gmail.com' \ 
        --device /dev/dri --name vscode --net="host" agsotelo/vscode-lumen
```

**Note**: Change GITUSERNAME and GITUSERMAIL as you need (Git global credentials are set at start).

You can set up `bash` alias for the command above, for example:

```bash
nano ~/.bashrc

alias phpcode-lumen='docker run -ti --rm -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/var/www/html -e DISPLAY=unix$DISPLAY -e GITUSERNAME='agsotelo' -e GITUSEREMAIL='agsotelo@gmail.com' -e DISPLAY=unix$DISPLAY --device /dev/dri --name vscode --net="host" vscode-lumen'

source ~/.bashrc
```

Once you set up the alias above, you can simply launch your "IDE" with simple command `phpcode-lumen`.

### Stop:

To stop the container and auto-remove it:

Just use `Ctrl+C` from console, but i have no issues using File > Exit from vscode.

### Use with other Docker image:

This image would work well with [insready/drupal-dev](https://hub.docker.com/r/insready/drupal-dev/), [Xdebug](https://xdebug.org/) remote debugging will simply work out of box.

## Configure Xdebug to work
This image makes assumption that the default remote server file path is at `/var/www/html/`. If this indeed is your remote file path, for example, you use [insready/drupal-dev](https://hub.docker.com/r/insready/drupal-dev/) for setting up your `Drupal` develppment enviroment, then you do not need additional configuration. Otherwise, you need to create a mapping between your remote file path, and the file path inside this container, which defaults to `/var/www/html/`.

To create a file path mapping between remote and local file system, you have to set the `localSourceRoot` and `serverSourceRoot` settings in your `launch.json`, for example:

```
"serverSourceRoot": "/var/www/html/",
"localSourceRoot": "${cwd}"
```

More documentation on this bit configuration can be fund [here](https://github.com/felixfbecker/vscode-php-debug#remote-host-debugging).

## List of `vscode` extensions included

* [PHP IntelliSense](https://marketplace.visualstudio.com/items?itemName=felixfbecker.php-intellisense)
* [PHP Debug](https://marketplace.visualstudio.com/items?itemName=felixfbecker.php-debug)
* [DotENV](https://marketplace.visualstudio.com/items?itemName=mikestead.dotenv)
* [Docker](https://marketplace.visualstudio.com/items?itemName=PeterJausovec.vscode-docker)

## Known issues

* When you close the `vscode` UI, the container doesn't stop automatically. Therefore, you need to use `Ctrl+C` to stop the container therefore to remove it.
* This image has only been tested on Linux. The --net="host" might not work on Mac, therefore it needs one more step tweek to get `Xdebug` work out of box.

## Contributing
You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a [GitHub issue](https://github.com/INsReady/docker-vscode-php/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.
