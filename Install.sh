#!/bin/sh
echo "Counter-Strike 1.6 \"Installer\""
curdir=$(cd "$(dirname "$0")"; pwd)
echo "Current game directory: \"${curdir}\""
echo "Copying .desktop file to ~/.local/share/applications"
mv "${curdir}/cstrike.png" "${curdir}/install"
cat "${curdir}/cstrike.desktop" \
	| sed "s:%%exepath%%:${curdir}:" \
	| sed "s:%%iconpath%%:${curdir}/install/cstrike.png:" \
	> ~/.local/share/applications/cstrike.desktop
echo "OK"
. ~/.config/user-dirs.dirs
echo "Copying .desktop file to $XDG_DESKTOP_DIR/"
cat "${curdir}/cstrike.desktop" \
	| sed "s:%%exepath%%:${curdir}:" \
	| sed "s:%%iconpath%%:${curdir}/install/cstrike.png:" \
	> "$XDG_DESKTOP_DIR"/cstrike.desktop
chmod +x "$XDG_DESKTOP_DIR"/cstrike.desktop
chmod +x "${curdir}/langchanger.sh"
"${curdir}/langchanger.sh"
echo "OK"
echo "Change permissions CHMOD"
chmod +x "${curdir}/cstrike.sh"
chmod +x "${curdir}/hl_linux"
echo "OK"
echo "Completion installation"
# gsettings set org.gnome.nautilus.preferences executable-text-activation ask
mkdir -p "${curdir}/install"
mv "${curdir}/cstrike.desktop" "${curdir}/install"
mv "${curdir}/Install.sh" "${curdir}/install"
rm "${curdir}/install/Install.txt"
echo "OK"
