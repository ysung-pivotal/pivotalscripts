# Create the service principals for both hawq and pxf using "kadmin.local" command from 
# the KDC server as the root user. Note hawq service princpals will be created using the 
# postgres user identiy. This is hawq requirement and can not be changed

addprinc -randkey postgres@PIVOTALHDDEV.SWACORP.COM
addprinc -randkey postgres/xldd4ehwq03.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM
addprinc -randkey postgres/xldd4ehwq04.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM
addprinc -randkey postgres/xldd4edn05.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM
addprinc -randkey postgres/xldd4edn06.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM
addprinc -randkey postgres/xldd4edn07.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM
addprinc -randkey postgres/xldd4edn08.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM

addprinc -randkey pxf/xldd4edn05.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM
addprinc -randkey pxf/xldd4edn06.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM
addprinc -randkey pxf/xldd4edn07.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM
addprinc -randkey pxf/xldd4edn08.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM

# Create the keytabs for both hawq and pxf

ktadd -norandkey -k /tmp/hawq.node3.service.keytab postgres@PIVOTALHDDEV.SWACROP.COM postgres/xldd4ehwq03.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM HTTP/xldd4ehwq03.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM
ktadd -norandkey -k /tmp/hawq.node4.service.keytab postgres@PIVOTALHDDEV.SWACROP.COM postgres/xldd4ehwq04.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM HTTP/xldd4ehwq04.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM
ktadd -norandkey -k /tmp/hawq.node5.service.keytab postgres@PIVOTALHDDEV.SWACROP.COM postgres/xldd4edn05.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM HTTP/xldd4edn05.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM
ktadd -norandkey -k /tmp/hawq.node6.service.keytab postgres@PIVOTALHDDEV.SWACROP.COM postgres/xldd4edn06.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM HTTP/xldd4edn05.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM
ktadd -norandkey -k /tmp/hawq.node7.service.keytab postgres@PIVOTALHDDEV.SWACROP.COM postgres/xldd4edn07.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM HTTP/xldd4edn05.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM
ktadd -norandkey -k /tmp/hawq.node8.service.keytab postgres@PIVOTALHDDEV.SWACROP.COM postgres/xldd4edn08.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM HTTP/xldd4edn05.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM

ktadd -norandkey -k /tmp/pxf.node5.service.keytab pxf/xldd4edn05.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM HTTP/xldd4edn05.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM
ktadd -norandkey -k /tmp/pxf.node6.service.keytab pxf/xldd4edn06.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM HTTP/xldd4edn06.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM
ktadd -norandkey -k /tmp/pxf.node7.service.keytab pxf/xldd4edn07.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM HTTP/xldd4edn07.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM
ktadd -norandkey -k /tmp/pxf.node8.service.keytab pxf/xldd4edn08.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM HTTP/xldd4edn08.SWACORP.COM@PIVOTALHDDEV.SWACROP.COM

# Distribute the hawq keytab

scp /tmp/hawq.node3.service.keytab xldd4ehwq03.SWACORP.COM:/etc/security/keytabs/hawq.service.keytab
scp /tmp/hawq.node4.service.keytab xldd4ehwq04.SWACORP.COM:/etc/security/keytabs/hawq.service.keytab
scp /tmp/hawq.node5.service.keytab xldd4edn05.SWACORP.COM:/etc/security/keytabs/hawq.service.keytab
scp /tmp/hawq.node6.service.keytab xldd4edn06.SWACORP.COM:/etc/security/keytabs/hawq.service.keytab
scp /tmp/hawq.node7.service.keytab xldd4edn07.SWACORP.COM:/etc/security/keytabs/hawq.service.keytab
scp /tmp/hawq.node8.service.keytab xldd4edn08.SWACORP.COM:/etc/security/keytabs/hawq.service.keytab

scp /tmp/pxf.node5.service.keytab xldd4edn05.SWACORP.COM:/etc/security/keytabs/pxf.service.keytab
scp /tmp/pxf.node6.service.keytab xldd4edn06.SWACORP.COM:/etc/security/keytabs/pxf.service.keytab
scp /tmp/pxf.node7.service.keytab xldd4edn07.SWACORP.COM:/etc/security/keytabs/pxf.service.keytab
scp /tmp/pxf.node8.service.keytab xldd4edn08.SWACORP.COM:/etc/security/keytabs/pxf.service.keytab

# Change the user/group permissions of the installed keytab

ssh xldd4ehwq03.SWACORP.COM chown gpadmin:gpadmin /etc/security/keytabs/hawq.service.keytab
ssh xldd4ehwq04.SWACORP.COM chown gpadmin:gpadmin /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn05.SWACORP.COM chown gpadmin:gpadmin /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn06.SWACORP.COM chown gpadmin:gpadmin /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn07.SWACORP.COM chown gpadmin:gpadmin /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn08.SWACORP.COM chown gpadmin:gpadmin /etc/security/keytabs/hawq.service.keytab

ssh xldd4edn05.SWACORP.COM chown pxf:hadoop /etc/security/keytabs/pxf.service.keytab
ssh xldd4edn06.SWACORP.COM chown pxf:hadoop /etc/security/keytabs/pxf.service.keytab
ssh xldd4edn07.SWACORP.COM chown pxf:hadoop /etc/security/keytabs/pxf.service.keytab
ssh xldd4edn08.SWACORP.COM chown pxf:hadoop /etc/security/keytabs/pxf.service.keytab

# Change the permissions on the installed keytabs

ssh xldd4ehwq03.SWACORP.COM chmod 400 /etc/security/keytabs/hawq.service.keytab
ssh xldd4ehwq04.SWACORP.COM chmod 400 /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn05.SWACORP.COM chmod 400 /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn06.SWACORP.COM chmod 400 /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn07.SWACORP.COM chmod 400 /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn08.SWACORP.COM chmod 400 /etc/security/keytabs/hawq.service.keytab

ssh xldd4edn05.SWACORP.COM chmod 400 /etc/security/keytabs/pxf.service.keytab
ssh xldd4edn06.SWACORP.COM chmod 400 /etc/security/keytabs/pxf.service.keytab
ssh xldd4edn07.SWACORP.COM chmod 400 /etc/security/keytabs/pxf.service.keytab
ssh xldd4edn08.SWACORP.COM chmod 400 /etc/security/keytabs/pxf.service.keytab

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