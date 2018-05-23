#!/bin/bash

set -ex

dirs="
sys-process/audit
"

dirs2="
app-admin/setools
sys-apps/checkpolicy
sys-apps/coreutils
sys-apps/policycoreutils
sys-libs/libselinux
sys-libs/libsemanage
sys-process/audit
sec-policy/selinux-base
sec-policy/selinux-base-policy
sec-policy/selinux-unconfined
sec-policy/selinux-virt
"


for d in ${dirs}; do
	out=",,selinux-work/${d}"
	#echo "${d} -> ${out}"
	rm -rf ${out}
	mkdir -p ${out}
	git format-patch -o${out} 06ee2177.. -- ${d}
done
