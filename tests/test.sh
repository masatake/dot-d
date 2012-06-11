#!/bin/sh

cmd=./dot-d
if [ -z "${cmd}" ]; then
    usage 1>&2
    exit 1
elif ! [ -f "${cmd}" ]; then
    echo no such file ${cmd} 1>&2
    exit 1
fi
dir=$(pwd)/tests
if ! [ -d "${dir}/dot-d.d" ]; then
    echo cannot find dot-d.d dir for testing under ${dir} 1>&2
    exit 2
fi

usage ()
{
    echo $1 DOT-D-CMD
}

testList()
{
    output=$(SYSCONF_DIR=${dir}/etc DOT_D_DIR=${dir}/dot-d.d sh ${cmd} list | grep fstab)
    assertEquals "${output}" "fstab ${dir}/dot-d.d/fstab.dot-d _ ${dir}/etc/fstab.d	.conf	${dir}/etc/fstab"

    output=$(SYSCONF_DIR=${dir}/etc DOT_D_DIR=${dir}/dot-d.d sh ${cmd} list | grep yum)
    assertEquals "${output}" "yum.repos ${dir}/dot-d.d/yum.repos.dot-d _ ${dir}/etc/yum.repos.d	.repo	/tmp/yum.repo"
}

testODDX()
{
    output=$(SYSCONF_DIR=${dir}/etc DOT_D_DIR=${dir}/dot-d.d sh ${cmd} concat --diff x)
    assertEquals "$?" 0
}



oneTimeSetUp()
{
    :
}

oneTimeTearDown()
{
    :
}

setUp()
{
    :
}

tearDown()
{
    :
}

. /usr/share/shunit2/shunit2
