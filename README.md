## Hack font installer for Linux

[![Build Status](https://semaphoreci.com/api/v1/sourcefoundry/hack-linux-installer/branches/master/badge.svg)](https://semaphoreci.com/sourcefoundry/hack-linux-installer)

### An install and upgrade script for the Hack typeface on the Linux platform

The [`hack-linux-installer.sh` shell script](https://github.com/source-foundry/hack-linux-installer/blob/master/hack-linux-installer.sh) installs fonts from the [Hack typeface repository](https://github.com/source-foundry/Hack) at a requested release version number on the Linux platform.  This script can be used for initial font installs and upgrades to new versions (or downgrades if ever necessary).

#### Download and modify permissions

```
$ curl -L -O https://raw.githubusercontent.com/source-foundry/hack-linux-installer/master/hack-linux-installer.sh
$ chmod +x hack-linux-installer.sh
```

#### Usage

```
$ ./hack-linux-installer.sh [VERSION]
```

Define the version number with the format `vX.XXX`.  You must use a lowercase `v` followed by the version number string that is used in the repository releases.

For example, install Hack v3.003 with the following command:

```
$ ./hack-linux-installer.sh v3.003
```

Alternatively, you can use the installer to install the latest version like so:

```
$ ./hack-linux-installer.sh latest
```

#### What it does

- The release archive is pulled from the repository release
- The release archive is unpacked
- The fonts are installed on the path `$HOME/.local/share/fonts`
- The font cache is cleared and regenerated
- `fc-list | grep "Hack"` is executed to display the installed font paths.  You should see expected install filepaths with this command.

