#!/bin/bash


# Create the service principals for both hawq and pxf using "kadmin.local" command from
# the KDC server as the root user. Note hawq service princpals will be created using the
# postgres user identiy. This is hawq requirement and can not be changed

kadmin.local -q "addprinc -randkey postgres@PIVOTALHDDEV.SWACORP.COM"
kadmin.local -q "addprinc -randkey postgres/xldd4ehwq03.swacorp.com@PIVOTALHDDEV.SWACORP.COM"
kadmin.local -q "addprinc -randkey postgres/xldd4ehwq04.swacorp.com@PIVOTALHDDEV.SWACORP.COM"
kadmin.local -q "addprinc -randkey postgres/xldd4edn05.swacorp.com@PIVOTALHDDEV.SWACORP.COM"
kadmin.local -q "addprinc -randkey postgres/xldd4edn06.swacorp.com@PIVOTALHDDEV.SWACORP.COM"
kadmin.local -q "addprinc -randkey postgres/xldd4edn07.swacorp.com@PIVOTALHDDEV.SWACORP.COM"
kadmin.local -q "addprinc -randkey postgres/xldd4edn08.swacorp.com@PIVOTALHDDEV.SWACORP.COM"

kadmin.local -q "addprinc -randkey pxf/xldd4edn05.swacorp.com@PIVOTALHDDEV.SWACORP.COM"
kadmin.local -q "addprinc -randkey pxf/xldd4edn06.swacorp.com@PIVOTALHDDEV.SWACORP.COM"
kadmin.local -q "addprinc -randkey pxf/xldd4edn07.swacorp.com@PIVOTALHDDEV.SWACORP.COM"
kadmin.local -q "addprinc -randkey pxf/xldd4edn08.swacorp.com@PIVOTALHDDEV.SWACORP.COM"

# Create the keytabs for both hawq and pxf

kadmin.local -q "xst -k /tmp/hawq.node3.service.keytab postgres@PIVOTALHDDEV.SWACORP.COM postgres/xldd4ehwq03.swacorp.com@PIVOTALHDDEV.SWACORP.COM HTTP/xldd4ehwq03.swacorp.com@PIVOTALHDDEV.SWACORP.COM"
kadmin.local -q "xst -k /tmp/hawq.node4.service.keytab postgres@PIVOTALHDDEV.SWACORP.COM postgres/xldd4ehwq04.swacorp.com@PIVOTALHDDEV.SWACORP.COM HTTP/xldd4ehwq04.swacorp.com@PIVOTALHDDEV.SWACORP.COM"
kadmin.local -q "xst -k /tmp/hawq.node5.service.keytab postgres@PIVOTALHDDEV.SWACORP.COM postgres/xldd4edn05.swacorp.com@PIVOTALHDDEV.SWACORP.COM HTTP/xldd4edn05.swacorp.com@PIVOTALHDDEV.SWACORP.COM"
kadmin.local -q "xst -k /tmp/hawq.node6.service.keytab postgres@PIVOTALHDDEV.SWACORP.COM postgres/xldd4edn06.swacorp.com@PIVOTALHDDEV.SWACORP.COM HTTP/xldd4edn05.swacorp.com@PIVOTALHDDEV.SWACORP.COM"
kadmin.local -q "xst -k /tmp/hawq.node7.service.keytab postgres@PIVOTALHDDEV.SWACORP.COM postgres/xldd4edn07.swacorp.com@PIVOTALHDDEV.SWACORP.COM HTTP/xldd4edn05.swacorp.com@PIVOTALHDDEV.SWACORP.COM"
kadmin.local -q "xst -k /tmp/hawq.node8.service.keytab postgres@PIVOTALHDDEV.SWACORP.COM postgres/xldd4edn08.swacorp.com@PIVOTALHDDEV.SWACORP.COM HTTP/xldd4edn05.swacorp.com@PIVOTALHDDEV.SWACORP.COM"

kadmin.local -q "xst -k /tmp/pxf.node5.service.keytab pxf/xldd4edn05.swacorp.com@PIVOTALHDDEV.SWACORP.COM HTTP/xldd4edn05.swacorp.com@PIVOTALHDDEV.SWACORP.COM"
kadmin.local -q "xst -k /tmp/pxf.node6.service.keytab pxf/xldd4edn06.swacorp.com@PIVOTALHDDEV.SWACORP.COM HTTP/xldd4edn06.swacorp.com@PIVOTALHDDEV.SWACORP.COM"
kadmin.local -q "xst -k /tmp/pxf.node7.service.keytab pxf/xldd4edn07.swacorp.com@PIVOTALHDDEV.SWACORP.COM HTTP/xldd4edn07.swacorp.com@PIVOTALHDDEV.SWACORP.COM"
kadmin.local -q "xst -k /tmp/pxf.node8.service.keytab pxf/xldd4edn08.swacorp.com@PIVOTALHDDEV.SWACORP.COM HTTP/xldd4edn08.swacorp.com@PIVOTALHDDEV.SWACORP.COM"

# Distribute the hawq keytab

scp /tmp/hawq.node3.service.keytab xldd4ehwq03.swacorp.com:/etc/security/keytabs/hawq.service.keytab
scp /tmp/hawq.node4.service.keytab xldd4ehwq04.swacorp.com:/etc/security/keytabs/hawq.service.keytab
scp /tmp/hawq.node5.service.keytab xldd4edn05.swacorp.com:/etc/security/keytabs/hawq.service.keytab
scp /tmp/hawq.node6.service.keytab xldd4edn06.swacorp.com:/etc/security/keytabs/hawq.service.keytab
scp /tmp/hawq.node7.service.keytab xldd4edn07.swacorp.com:/etc/security/keytabs/hawq.service.keytab
scp /tmp/hawq.node8.service.keytab xldd4edn08.swacorp.com:/etc/security/keytabs/hawq.service.keytab

scp /tmp/pxf.node5.service.keytab xldd4edn05.swacorp.com:/etc/security/keytabs/pxf.service.keytab
scp /tmp/pxf.node6.service.keytab xldd4edn06.swacorp.com:/etc/security/keytabs/pxf.service.keytab
scp /tmp/pxf.node7.service.keytab xldd4edn07.swacorp.com:/etc/security/keytabs/pxf.service.keytab
scp /tmp/pxf.node8.service.keytab xldd4edn08.swacorp.com:/etc/security/keytabs/pxf.service.keytab


# Change the user/group permissions of the installed keytab

ssh xldd4ehwq03.swacorp.com chown gpadmin:gpadmin /etc/security/keytabs/hawq.service.keytab
ssh xldd4ehwq04.swacorp.com chown gpadmin:gpadmin /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn05.swacorp.com chown gpadmin:gpadmin /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn06.swacorp.com chown gpadmin:gpadmin /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn07.swacorp.com chown gpadmin:gpadmin /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn08.swacorp.com chown gpadmin:gpadmin /etc/security/keytabs/hawq.service.keytab

ssh xldd4edn05.swacorp.com chown pxf:hadoop /etc/security/keytabs/pxf.service.keytab
ssh xldd4edn06.swacorp.com chown pxf:hadoop /etc/security/keytabs/pxf.service.keytab
ssh xldd4edn07.swacorp.com chown pxf:hadoop /etc/security/keytabs/pxf.service.keytab
ssh xldd4edn08.swacorp.com chown pxf:hadoop /etc/security/keytabs/pxf.service.keytab

# Change the permissions on the installed keytabs

ssh xldd4ehwq03.swacorp.com chmod 400 /etc/security/keytabs/hawq.service.keytab
ssh xldd4ehwq04.swacorp.com chmod 400 /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn05.swacorp.com chmod 400 /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn06.swacorp.com chmod 400 /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn07.swacorp.com chmod 400 /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn08.swacorp.com chmod 400 /etc/security/keytabs/hawq.service.keytab

ssh xldd4edn05.swacorp.com chmod 400 /etc/security/keytabs/pxf.service.keytab
ssh xldd4edn06.swacorp.com chmod 400 /etc/security/keytabs/pxf.service.keytab
ssh xldd4edn07.swacorp.com chmod 400 /etc/security/keytabs/pxf.service.keytab
ssh xldd4edn08.swacorp.com chmod 400 /etc/security/keytabs/pxf.service.keytab

# Remove temporary keytabs

rm /tmp/hawq.node3.service.keytab
rm /tmp/hawq.node4.service.keytab
rm /tmp/hawq.node5.service.keytab
rm /tmp/hawq.node6.service.keytab
rm /tmp/hawq.node7.service.keytab
rm /tmp/hawq.node8.service.keytab

rm /tmp/pxf.node5.service.keytab
rm /tmp/pxf.node6.service.keytab
rm /tmp/pxf.node8.service.keytab
rm /tmp/pxf.node7.service.keytab
                                  
