#!/bin/sh

# /////////////////////////////////////////////////////////////////
#
# hack-linux-installer.sh
#  A shell script that installs the Hack fonts from repository
#  releases by release version number
#
#  Copyright 2018 Christopher Simpkins
#  MIT License
#
#  Usage: ./hack-linux-installer.sh [VERSION]
#         Format the version number as vX.XXX or "latest"
#
# /////////////////////////////////////////////////////////////////

HACK_INSTALL_PATH="$HOME/.local/share/fonts"

get_latest_release() {
  curl -s "https://api.github.com/repos/source-foundry/Hack/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/'
}

if [ $# -ne 1 ]; then
    echo "Please include a version number argument formatted as vX.XXX (or \"latest\")"
    exit 1
fi

if [ "$1" = "--help" ]; then
    echo "Usage: ./hack-linux-installer [VERSION]"
    echo "Format [VERSION] as vX.XXX for the desired release version of the fonts. Or just set it to \"latest\"."
    exit 0
fi

if [ ! -d "$HACK_INSTALL_PATH" ]; then
    echo "Unable to detect the install directory path '$HACK_INSTALL_PATH'.  Please create this path and execute the script again."
    exit 1
fi

HACK_VERSION="${1:-latest}"
if [ "$HACK_VERSION" = "latest" ]
then
  HACK_VERSION="$(get_latest_release)"
fi
HACK_DL_URL="https://github.com/source-foundry/Hack/releases/download/$HACK_VERSION/Hack-$HACK_VERSION-ttf.tar.gz"
HACK_ARCHIVE_PATH="Hack-$HACK_VERSION-ttf.tar.gz"

# pull user requested fonts from the Hack repository releases & unpack
echo " "
echo "Pulling Hack $HACK_VERSION fonts from the Github repository release..."
curl -L -O "$HACK_DL_URL"

echo " "
echo "Unpacking the font files..."
if [ -f "$HACK_ARCHIVE_PATH" ]; then
    tar -xzvf "$HACK_ARCHIVE_PATH"
else
    echo "Unable to find the pulled archive file.  Install failed."
    exit 1
fi

# install
if [ -d "ttf" ]; then
    echo " "
    echo "Installing the Hack fonts..."
    # clean up archive file
    rm "$HACK_ARCHIVE_PATH"

    # move fonts to install directory
    echo "Installing Hack-Regular.ttf on path $HACK_INSTALL_PATH/Hack-Regular.ttf"
    mv ttf/Hack-Regular.ttf "$HACK_INSTALL_PATH/Hack-Regular.ttf"

    echo "Installing Hack-Italic.ttf on path $HACK_INSTALL_PATH/Hack-Italic.ttf"
    mv ttf/Hack-Italic.ttf "$HACK_INSTALL_PATH/Hack-Italic.ttf"

    echo "Installing Hack-Bold.ttf on path $HACK_INSTALL_PATH/Hack-Bold.ttf"
    mv ttf/Hack-Bold.ttf "$HACK_INSTALL_PATH/Hack-Bold.ttf"

    echo "Installing Hack-BoldItalic.ttf on path $HACK_INSTALL_PATH/Hack-BoldItalic.ttf"
    mv ttf/Hack-BoldItalic.ttf "$HACK_INSTALL_PATH/Hack-BoldItalic.ttf"

    echo " "
    echo "Cleaning up..."
    rm -rf ttf

    # clear and regenerate font cache
    echo " "
    echo "Clearing and regenerating the font cache.  You will see a stream of text as this occurs..."
    echo " "
    fc-cache -f -v

    echo " "
    echo "Testing. You should see the expected install filepaths in the output below..."
    fc-list | grep "Hack"

    echo " "
    echo "Install of Hack $HACK_VERSION complete."
    exit 0
else
    echo "Unable to identify the unpacked font directory. Install failed."
    exit 1
fi
