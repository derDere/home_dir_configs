xsetroot -cursor_name left_ptr &

export VISUAL=emacsclient
export EDITOR="$VISUAL"

nitrogen --restore &

xrdb -global -load ~/.Xresources

xcompmgr -c -C -t-11 -l-11 -r8 -o.66 &

exec dbus-launch --exit-with-session emacs &

tint2 &
