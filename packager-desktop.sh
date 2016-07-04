#!/bin/sh
REVISION="0"
NAME=firmwdump

DEVICE=dst1kb
PRODMFR=hantek
PRODMODEL=mso5074fg
DATE=`date +"%Y%m%d"`

PRODNAME=$PRODMFR"_"$PRODMODEL
FILENAME=$DEVICE"_"$NAME"_"$PRODNAME"_"$DATE"."$REVISION

rm -f $FILENAME.*
tar -cf $FILENAME.up.tar upend tekwayup_client
tar -zcf $FILENAME.tar $FILENAME.up.tar
# gpg will print it's VERY IMPORTANT warnings even if I will
# supply -q or -qq or -qqq or whatever I want to shun it.
# The text "Reading passphrase from file descriptor 0" is
# unavoitable there because gpg writes it to reallocated fd.
echo $PRODMODEL | gpg --compress-algo none --passphrase-fd 0 -o $FILENAME.up -c $FILENAME.tar

# cleanup intermediate files
rm $FILENAME.up.tar $FILENAME.tar

# done
echo "Your file \""$FILENAME".up\" is ready."

