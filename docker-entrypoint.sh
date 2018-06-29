#!/usr/bin/env sh
set -e

isCommand() {
  for cmd in \
    "analyze" \
    "help" \
    "list" \
    "print-cfg" \
    "print-vars"
  do
    if [ -z "${cmd#"$1"}" ]; then
      return 0
    fi
  done

  return 1
}

if [ "$(printf %c "$1")" = '-' ]; then
  set -- /sbin/tini -- php /composer/vendor/bin/tuli "$@"
elif [ "$1" = "/composer/vendor/bin/tuli" ]; then
  set -- /sbin/tini -- php "$@"
elif [ "$1" = "tuli" ]; then
  set -- /sbin/tini -- php /composer/vendor/bin/"$@"
elif isCommand "$1"; then
  set -- /sbin/tini -- php /composer/vendor/bin/tuli "$@"
fi

exec "$@"
