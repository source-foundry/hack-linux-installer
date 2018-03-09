## Hack font installer for Linux

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

#### What it does

- The release archive is pulled from the repository release
- The release archive is unpacked
- The fonts are installed on the path `$HOME/.local/share/fonts`
- The font cache is cleared and regenerated
- `fc-list | grep "Hack"` is executed to display the installed font paths.  You should see valid output from this command.

