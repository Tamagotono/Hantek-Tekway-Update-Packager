#!/bin/sh
rm -f dst1kb_firmwdump.*
bsdtar -cf dst1kb_firmwdump.up.tar upend tekwayup_client
bsdtar -zcf dst1kb_firmwdump.tar dst1kb_firmwdump.up.tar
# gpg will print it's VERY IMPORTANT warnings even if I will
# supply -q or -qq or -qqq or whatever I want to shun it.
# The text "Reading passphrase from file descriptor 0" is
# unavoitable there because gpg writes it to reallocated fd.
printf 'mso5074fg' | gpg --compress-algo none --passphrase-fd 0 -o dst1kb_firmwdump.up -c dst1kb_firmwdump.tar
