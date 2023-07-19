TAR_HASH=$(sha256sum *.tar.gz | awk '{ print $1 }')

cat SHA256SUMS | grep $TAR_HASH || exit 1

# this still does not work, moving forward and would have a look later on.
# gpg --verify --status-fd 1 --verify SHA256SUMS.asc SHA256SUMS 2>/dev/null | grep "^\[GNUPG:\] VALIDSIG.*${1}\$ || exit 1
