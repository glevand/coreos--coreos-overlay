#!/bin/bash

: ${run:="mod-1"}
: ${rev:="r3"}

out="/tmp/defconfig-2"
base="/home/geoff/projects/coreos/dev-1/chroot/build"
build="var/tmp/portage/sys-kernel/coreos-modules-4.14.0-${rev}/work/coreos-modules-4.14.0/build"


mkdir -p ${out}

: ${boards:="amd64-usr arm64-usr"}
: ${files:="config defconfig"}

rm ${out}/*-${run}-*

for b in ${boards}; do
	for f in ${files}; do
		f_src="${f}"
		if [[ "${f}" == "config" ]]; then
			f_src=".${f}"
		fi

		cp ${base}/${b}/${build}/${f_src}   ${out}/${f}-${run}-${b}

		if [[ "${run}" != "base" ]]; then
			diff -u ${out}/${f}-base-${b} ${out}/${f}-${run}-${b} > ${out}/${f}-${run}-${b}.diff
		fi
	done
done
