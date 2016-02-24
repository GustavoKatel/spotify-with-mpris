# spotify-with-mpris

This is a workaround to the bug present in kde. See https://bugs.kde.org/show_bug.cgi?id=351852

It checks if there is any mpris player running.
If there is any, then all commands go to the mpris player, otherwise the script pushes everything to spotify.

Dependencies: package mpris-remote

Bind the media keys to the script using the args to switch the commands.

Example:
$ spotify-keys.sh PlayPause
$ spotify-keys.sh Stop
$ spotify-keys.sh Next
$ spotify-keys.sh Previous
