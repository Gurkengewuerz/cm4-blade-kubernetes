random_string() {
  RANDOM_STRING=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
  eval "$1='"$RANDOM_STRING"'"
}
