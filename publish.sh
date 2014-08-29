#!/bin/sh

function rename {
	FILENAME=$1
	NF=$(echo "$1" | tr " " "_")
	echo mv "$FILENAME" $NF
	mv "$FILENAME" $NF
}

function publish {
	pushd ../bluexml.github.com

	find . -type f -name "*.html" \
		-exec replace "\"^/assets" "\"/blogs/assets" -- {} \;

	find . -type f -name "*.html" \
		-exec replace "/pages" "/blogs/pages" -- {} \;

	find . -type f -name "*.html" \
		-exec replace "/archive" "/blogs/archive" -- {} \;

	find . -type f -name "*.html" \
		-exec replace "/categories" "/blogs/categories" -- {} \;

	find . -type f -name "*.html" \
		-exec replace "/tags" "/blogs/tags" -- {} \;

	find . -type f -name "*.html" \
		-exec replace "/blogs/blogs" "/blogs/blogs" -- {} \;

	rsync -avzP -e ssh * root@elrond.bluexml.com:/data/www/virtuals/bluedolmen/www.bluedolmen.org/html/blogs

}

echo Don't publish anything...

#publish
