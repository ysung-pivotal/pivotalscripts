#!/bin/bash

distributeTarballs() {
    	csvFile=$1;
    	skipPrompt=$2;
    	csvFile=$(printf '%q' "$csvFile")
    	tarballPrefix="keytabs_"

    if [[ $skipPrompt != "noprompt" ]]
    then
    	echo "Going to distribute the following files"
    	ls -l ${tarballPrefix}*.tar
    	echo "Continue?? [y/n]"
    	read ans
    	if [[ $ans = [yY] ]]
    	then
    		echo "Starting keytab distribution"
    	fi

    	if [[ $ans = [nN] ]]
    	then
    		echo "Exiting distribution process..."
		return
    	fi
	fi

	for tarFile in `ls ${tarballPrefix}*.tar`
	do
		# keytabs_node2.phd.local.tar
		host=`echo ${tarFile} | cut -d _ -f 2 | awk -F ".tar" '{print $1}'`

		echo "Shipping file $tarFile to host $host"
		scp ${tarFile} ${host}:/tmp/
		if [ $? -gt 0 ]
		then
			echo "Failed to SCP file: $?"
			exit 1
		fi

		echo "Extracting /tmp/$tarFile on host $host"
		ssh ${host} "tar -xvf /tmp/${tarFile} -C /"
		if [ $? -gt 0 ]
		then
			echo "Untar failed: $?"
			exit 1
		fi
	done

    echo "changing file permissions for keytabs..."
    while read line
    do
        IFS="," read -r hostname desc princ keyfile keydir owner group bits <<< "$line"
        echo "changing permissions to ${owner}:${group} mode ${bits} for file ${keydir}/${keyfile} on host $hostname"
        ssh -n $hostname "mkdir -p ${keydir}; chown ${owner}:${group} ${keydir}/${keyfile}; chmod ${bits} ${keydir}/${keyfile}"
    done < "$csvFile"
}

distributeTarballs $@