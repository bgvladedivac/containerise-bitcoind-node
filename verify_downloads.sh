TAR_HASH=$(sha256sum *.tar.gz | awk '{ print $1 }')

cat SHA256SUMS | grep $TAR_HASH

if [ $? -ne 0 ];
then
	echo "Release it not safe"
	exit 1
fi

echo "Release hash was found in the SHA256SUSM file"
