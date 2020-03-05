xsetroot -cursor_name left_ptr &

export VISUAL=emacsclient
export EDITOR="$VISUAL"

nitrogen --restore &

xrdb -global -load ~/.Xresources

xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55 &

exec dbus-launch --exit-with-session emacs &

tint2 &
