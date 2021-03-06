#!/bin/bash
# source: http://stackoverflow.com/questions/10374520/gsettings-with-cron
# TODO: At night only dark wallpapers.
# see also wallpaperservice and use gnome-session-properties

# to run this script automacticly you can do this: crontab -e
# */5 * * * * /home/user/bin/changewallpaper.sh

# Tip: Don't forget create one blank line at bottom in crontab file

# Wallpaper's directory.
# dir="${HOME}/pictures/new-wallpapers/
#
# # export DBUS_SESSION_BUS_ADDRESS environment variable
# PID=$(pgrep gnome-session)
# export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)
#
# # Random wallpaper.
# wallpaper=`find "${dir}" -type f | shuf -n1`
#
# #Determines how the image set by wallpaper_filename is rendered. Possible values are "none", "wallpaper", "centered", "scaled", "stretched", "zoom", "spanned".
#
# #gsettings set org.gnome.desktop.background picture-options "spanned"
# gsettings set org.gnome.desktop.background picture-options "stretched"
# gsettings set org.gnome.desktop.background picture-uri "file://${wallpaper}"

# new reference: https://major.io/2015/02/11/rotate-gnome-3s-wallpaper-systemd-user-units-timers/

# systemctl --user enable gnome-background-change.timer
# systemctl --user start gnome-background-change.timer

#Checking our work
#You can use systemctl to query the timer we just activated:

#$ systemctl --user list-timers

 SYSTEMDDIR=${HOME}/.config/systemd/user/

 [[ ! -e "$SYSTEMDDIR" ]] && mkdir -p "$SYSTEMDDIR"

 SERVICE="${SYSTEMDDIR}"gnome-background-change.service
 TIMER="${SYSTEMDDIR}"gnome-background-change.timer

if  [[ ! -f "${SERVICE}" ]] ; then
cat <<-EOF > "${SERVICE}"
[Unit]
Description=Rotate GNOME background

[Service]
Type=oneshot
Environment=DISPLAY=:0
ExecStart=/usr/bin/bash "${HOME}"/bin/changewallpaper.sh

[Install]
WantedBy=basic.target
EOF
fi

if [[ ! -f "${TIMER}" ]]; then
cat <<-EOF > "${TIMER}"
[Unit]
Description=Rotate GNOME wallpaper timer

[Timer]
OnCalendar=*:0/5
Persistent=true
Unit=gnome-background-change.service

[Install]
WantedBy=gnome-background-change.service
EOF
fi


USER=$(whoami)
PID=$(pgrep -u $USER gnome-session)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

walls_dir="$HOME"/pictures/new-wallpapers
selection=$(find "$walls_dir" | shuf -n1)
gsettings set org.gnome.desktop.background picture-uri "file://$selection"


