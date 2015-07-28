processCSVFile () {
    csvFile=$1;
    csvFile=$(printf '%q' "$csvFile")
    touch generate_keytabs.sh;
    chmod 755 generate_keytabs.sh;

    echo "#!/bin/bash" > generate_keytabs.sh;
    echo "###########################################################################" >> generate_keytabs.sh;
    echo "###########################################################################" >> generate_keytabs.sh;
    echo "## " >> generate_keytabs.sh;
    echo "## Ambari Security Script Generator" >> generate_keytabs.sh;
    echo "## "  >> generate_keytabs.sh;
    echo "## Ambari security script is generated which should be run on the" >> generate_keytabs.sh;
    echo "## Kerberos server machine." >> generate_keytabs.sh;
    echo "## " >> generate_keytabs.sh;
    echo "## Running the generated script will create host specific keytabs folders." >> generate_keytabs.sh;
    echo "## Each of those folders will contain service specific keytab files with " >> generate_keytabs.sh;
    echo "## appropriate permissions. There folders should be copied as the appropriate" >> generate_keytabs.sh;
    echo "## host's '/etc/security/keytabs' folder" >> generate_keytabs.sh;
    echo "###########################################################################" >> generate_keytabs.sh;
    echo "###########################################################################" >> generate_keytabs.sh;

    rm -f commands.mkdir;
    rm -f commands.chmod;
    rm -f commands.addprinc;
    rm -f commands.xst
    rm -f commands.xst.cp
    rm -f commands.chown.1
    rm -f commands.chmod.1
    rm -f commands.chmod.2
    rm -f commands.tar

    seenHosts="";
    seenPrincipals="";

    echo "mkdir -p ./tmp_keytabs" >> commands.mkdir;
    cat $csvFile | while read line; do
        hostName=`echo $line|cut -d , -f 1`;
        service=`echo $line|cut -d , -f 2`;
        principal=`echo $line|cut -d , -f 3`;
        keytabFile=`echo $line|cut -d , -f 4`;
        keytabFilePath=`echo $line|cut -d , -f 5`;
        owner=`echo $line|cut -d , -f 6`;
        group=`echo $line|cut -d , -f 7`;
        acl=`echo $line|cut -d , -f 8`;

        if [[ $seenHosts != *$hostName* ]]; then
              echo "mkdir -p ./keytabs_$hostName" >> commands.mkdir;
              echo "chmod 755 ./keytabs_$hostName" >> commands.chmod;
              echo "chown -R root:$group `pwd`/keytabs_$hostName" >> commands.chown.1
              echo "tar -cvf keytabs_$hostName.tar -C keytabs_$hostName ." >> commands.tar
              seenHosts="$seenHosts$hostName";
        fi

        if [[ $seenPrincipals != *" $principal"* ]]; then
          echo -e "kadmin.local -q \"addprinc -randkey $principal\"" >> commands.addprinc;
          seenPrincipals="$seenPrincipals $principal"
        fi
        tmpKeytabFile="`pwd`/tmp_keytabs/$keytabFile";
            newKeytabPath="`pwd`/keytabs_$hostName$keytabFilePath";
            newKeytabFile="$newKeytabPath/$keytabFile";
        if [ ! -f $tmpKeytabFile ]; then
          echo "kadmin.local -q \"xst -k $tmpKeytabFile $principal\"" >> commands.xst;
        fi
        if [ ! -d $newKeytabPath ]; then
            echo "mkdir -p $newKeytabPath" >> commands.mkdir;
        fi
        echo "cp $tmpKeytabFile $newKeytabFile" >> commands.xst.cp
        echo "chmod $acl $newKeytabFile" >> commands.chmod.2
        echo "chown $owner:$group $newKeytabFile" >> commands.chown.1
    done;


    echo "" >> generate_keytabs.sh;
    echo "" >> generate_keytabs.sh;
    echo "###########################################################################" >> generate_keytabs.sh;
    echo "# Making host specific keytab folders" >> generate_keytabs.sh;
    echo "###########################################################################" >> generate_keytabs.sh;
    cat commands.mkdir >> generate_keytabs.sh;
    echo "" >> generate_keytabs.sh;
    echo "###########################################################################" >> generate_keytabs.sh;
    echo "# Changing permissions for host specific keytab folders" >> generate_keytabs.sh;
    echo "###########################################################################" >> generate_keytabs.sh;
    cat commands.chmod >> generate_keytabs.sh;
    echo "" >> generate_keytabs.sh;
    echo "###########################################################################" >> generate_keytabs.sh;
    echo "# Creating Kerberos Principals" >> generate_keytabs.sh;
    echo "###########################################################################" >> generate_keytabs.sh;
    cat commands.addprinc >> generate_keytabs.sh;
    echo "" >> generate_keytabs.sh;
    echo "###########################################################################" >> generate_keytabs.sh;
    echo "# Creating Kerberos Principal keytabs in host specific keytab folders" >> generate_keytabs.sh;
    echo "###########################################################################" >> generate_keytabs.sh;
    cat commands.xst >> generate_keytabs.sh;
    cat commands.xst.cp >> generate_keytabs.sh;
    echo "" >> generate_keytabs.sh;
    echo "###########################################################################" >> generate_keytabs.sh;
    echo "# Changing ownerships of host specific keytab files" >> generate_keytabs.sh;
    echo "###########################################################################" >> generate_keytabs.sh;
    cat commands.chown.1 >> generate_keytabs.sh;
    echo "" >> generate_keytabs.sh;
    echo "###########################################################################" >> generate_keytabs.sh;
    echo "# Changing access permissions of host specific keytab files" >> generate_keytabs.sh;
    echo "###########################################################################" >> generate_keytabs.sh;
    #cat commands.chmod.1
    cat commands.chmod.2 >> generate_keytabs.sh;
    echo "" >> generate_keytabs.sh;
    echo "###########################################################################" >> generate_keytabs.sh;
    echo "# Packaging keytab folders" >> generate_keytabs.sh;
    echo "###########################################################################" >> generate_keytabs.sh;
    cat commands.tar >> generate_keytabs.sh;
    echo "" >> generate_keytabs.sh;
    echo "###########################################################################" >> generate_keytabs.sh;
    echo "# Cleanup" >> generate_keytabs.sh;
    echo "###########################################################################" >> generate_keytabs.sh;
    echo "rm -rf ./tmp_keytabs" >> generate_keytabs.sh;
    echo "" >> generate_keytabs.sh;
    echo "echo \"****************************************************************************\"" >> generate_keytabs.sh;
    echo "echo \"****************************************************************************\"" >> generate_keytabs.sh;
    echo "echo \"** Copy and extract 'keytabs_[hostname].tar' files onto respective hosts. **\"" >> generate_keytabs.sh;
    echo "echo \"**                                                                        **\"" >> generate_keytabs.sh;
    echo "echo \"** Generated keytab files are preserved in the 'tmp_keytabs' folder.      **\"" >> generate_keytabs.sh;
    echo "echo \"****************************************************************************\"" >> generate_keytabs.sh;
    echo "echo \"****************************************************************************\"" >> generate_keytabs.sh;

    rm -f commands.mkdir >> generate_keytabs.sh;
    rm -f commands.chmod >> generate_keytabs.sh;
    rm -f commands.addprinc >> generate_keytabs.sh;
    rm -f commands.xst >> generate_keytabs.sh;
    rm -f commands.xst.cp >> generate_keytabs.sh;
    rm -f commands.chown.1 >> generate_keytabs.sh;
    rm -f commands.chmod.1 >> generate_keytabs.sh;
    rm -f commands.chmod.2 >> generate_keytabs.sh;
    rm -f commands.tar >> generate_keytabs.sh;
    # generate keytabs
    sh ./generate_keytabs.sh
}


processCSVFile $@