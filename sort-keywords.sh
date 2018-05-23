#!/bin/bash

mv profiles/coreos/arm64/package.accept_keywords profiles/coreos/arm64/package.accept_keywords.old
cat profiles/coreos/arm64/package.accept_keywords.old | egrep '^($|#)' > profiles/coreos/arm64/package.accept_keywords
cat profiles/coreos/arm64/package.accept_keywords.old | egrep -v '^($|#)' | sort >> profiles/coreos/arm64/package.accept_keywords
rm profiles/coreos/arm64/package.accept_keywords.old
git diff
