#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for bitcoindiamondd"

  set -- bitcoindiamondd "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "bitcoindiamondd" ]; then
  mkdir -p "$BITCOIN_DIAMOND_DATA"
  chmod 700 "$BITCOIN_DIAMOND_DATA"
  chown -R bitcoindiamond "$BITCOIN_DIAMOND_DATA"

  echo "$0: setting data directory to $BITCOIN_DIAMOND_DATA"

  set -- "$@" -datadir="$BITCOIN_DIAMOND_DATA"
fi

if [ "$1" = "bitcoindiamondd" ] || [ "$1" = "bitcoindiamond-cli" ] || [ "$1" = "bitcoindiamond-tx" ]; then
  echo
  exec gosu bitcoindiamond "$@"
fi

echo
exec "$@"