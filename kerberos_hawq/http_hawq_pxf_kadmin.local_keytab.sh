#!/bin/bash

#add spnego keytabs
######add other nodes here######
##other nodes???
kadmin.local -q "ktadd -norandkey -k /tmp/spnego.node3.service.keytab HTTP/xldd4ehwq03.swacorp.com@PIVOTALHDDEV.SWACROP.COM"
kadmin.local -q "ktadd -norandkey -k /tmp/spnego.node4.service.keytab HTTP/xldd4ehwq04.swacorp.com@PIVOTALHDDEV.SWACROP.COM"
kadmin.local -q "ktadd -norandkey -k /tmp/spnego.node5.service.keytab HTTP/xldd4edn05.swacorp.com@PIVOTALHDDEV.SWACROP.COM"
kadmin.local -q "ktadd -norandkey -k /tmp/spnego.node6.service.keytab HTTP/xldd4edn06.swacorp.com@PIVOTALHDDEV.SWACROP.COM"
kadmin.local -q "ktadd -norandkey -k /tmp/spnego.node7.service.keytab HTTP/xldd4edn07.swacorp.com@PIVOTALHDDEV.SWACROP.COM"
kadmin.local -q "ktadd -norandkey -k /tmp/spnego.node8.service.keytab HTTP/xldd4edn08.swacorp.com@PIVOTALHDDEV.SWACROP.COM"

#add hawq keytabs
kadmin.local -q "ktadd -norandkey -k /tmp/hawq.node3.service.keytab postgres@PIVOTALHDDEV.SWACROP.COM postgres/xldd4ehwq03.swacorp.com@PIVOTALHDDEV.SWACROP.COM HTTP/xldd4ehwq03.swacorp.com@PIVOTALHDDEV.SWACROP.COM"
kadmin.local -q "ktadd -norandkey -k /tmp/hawq.node4.service.keytab postgres@PIVOTALHDDEV.SWACROP.COM postgres/xldd4ehwq04.swacorp.com@PIVOTALHDDEV.SWACROP.COM HTTP/xldd4ehwq04.swacorp.com@PIVOTALHDDEV.SWACROP.COM"
kadmin.local -q "ktadd -norandkey -k /tmp/hawq.node5.service.keytab postgres@PIVOTALHDDEV.SWACROP.COM postgres/xldd4edn05.swacorp.com@PIVOTALHDDEV.SWACROP.COM HTTP/xldd4edn05.swacorp.com@PIVOTALHDDEV.SWACROP.COM"
kadmin.local -q "ktadd -norandkey -k /tmp/hawq.node6.service.keytab postgres@PIVOTALHDDEV.SWACROP.COM postgres/xldd4edn06.swacorp.com@PIVOTALHDDEV.SWACROP.COM HTTP/xldd4edn06.swacorp.com@PIVOTALHDDEV.SWACROP.COM"
kadmin.local -q "ktadd -norandkey -k /tmp/hawq.node7.service.keytab postgres@PIVOTALHDDEV.SWACROP.COM postgres/xldd4edn07.swacorp.com@PIVOTALHDDEV.SWACROP.COM HTTP/xldd4edn07.swacorp.com@PIVOTALHDDEV.SWACROP.COM"
kadmin.local -q "ktadd -norandkey -k /tmp/hawq.node8.service.keytab postgres@PIVOTALHDDEV.SWACROP.COM postgres/xldd4edn08.swacorp.com@PIVOTALHDDEV.SWACROP.COM HTTP/xldd4edn08.swacorp.com@PIVOTALHDDEV.SWACROP.COM"

#add pxf keytabs
kadmin.local -q "ktadd -norandkey -k /tmp/pxf.node5.service.keytab pxf/xldd4edn05.swacorp.com@PIVOTALHDDEV.SWACROP.COM HTTP/xldd4edn05.swacorp.com@PIVOTALHDDEV.SWACROP.COM"
kadmin.local -q "ktadd -norandkey -k /tmp/pxf.node6.service.keytab pxf/xldd4edn06.swacorp.com@PIVOTALHDDEV.SWACROP.COM HTTP/xldd4edn06.swacorp.com@PIVOTALHDDEV.SWACROP.COM"
kadmin.local -q "ktadd -norandkey -k /tmp/pxf.node7.service.keytab pxf/xldd4edn07.swacorp.com@PIVOTALHDDEV.SWACROP.COM HTTP/xldd4edn07.swacorp.com@PIVOTALHDDEV.SWACROP.COM"
kadmin.local -q "ktadd -norandkey -k /tmp/pxf.node8.service.keytab pxf/xldd4edn08.swacorp.com@PIVOTALHDDEV.SWACROP.COM HTTP/xldd4edn08.swacorp.com@PIVOTALHDDEV.SWACROP.COM"

# Distribute the http keytab
###other nodes???
scp /tmp/spnego.node3.service.keytab xldd4ehwq03.swacorp.com:/etc/security/keytabs/spnego.service.keytab
scp /tmp/spnego.node4.service.keytab xldd4ehwq04.swacorp.com:/etc/security/keytabs/spnego.service.keytab
scp /tmp/spnego.node5.service.keytab xldd4edn05.swacorp.com:/etc/security/keytabs/spnego.service.keytab
scp /tmp/spnego.node6.service.keytab xldd4edn06.swacorp.com:/etc/security/keytabs/spnego.service.keytab
scp /tmp/spnego.node7.service.keytab xldd4edn07.swacorp.com:/etc/security/keytabs/spnego.service.keytab
scp /tmp/spnego.node8.service.keytab xldd4edn08.swacorp.com:/etc/security/keytabs/spnego.service.keytab

# Distribute the hawq keytab
scp /tmp/hawq.node3.service.keytab xldd4ehwq03.swacorp.com:/etc/security/keytabs/hawq.service.keytab
scp /tmp/hawq.node4.service.keytab xldd4ehwq04.swacorp.com:/etc/security/keytabs/hawq.service.keytab
scp /tmp/hawq.node5.service.keytab xldd4edn05.swacorp.com:/etc/security/keytabs/hawq.service.keytab
scp /tmp/hawq.node6.service.keytab xldd4edn06.swacorp.com:/etc/security/keytabs/hawq.service.keytab
scp /tmp/hawq.node7.service.keytab xldd4edn07.swacorp.com:/etc/security/keytabs/hawq.service.keytab
scp /tmp/hawq.node8.service.keytab xldd4edn08.swacorp.com:/etc/security/keytabs/hawq.service.keytab

# Distribute the pxf keytab
scp /tmp/pxf.node5.service.keytab xldd4edn05.swacorp.com:/etc/security/keytabs/pxf.service.keytab
scp /tmp/pxf.node6.service.keytab xldd4edn06.swacorp.com:/etc/security/keytabs/pxf.service.keytab
scp /tmp/pxf.node7.service.keytab xldd4edn07.swacorp.com:/etc/security/keytabs/pxf.service.keytab
scp /tmp/pxf.node8.service.keytab xldd4edn08.swacorp.com:/etc/security/keytabs/pxf.service.keytab

# Change the user/group permissions of the spnego keytab
###other nodes????
ssh xldd4ehwq03.swacorp.com chown root:hadoop /etc/security/keytabs/spnego.service.keytab
ssh xldd4ehwq04.swacorp.com chown root:hadoop /etc/security/keytabs/spnego.service.keytab
ssh xldd4edn05.swacorp.com chown root:hadoop /etc/security/keytabs/spnego.service.keytab
ssh xldd4edn06.swacorp.com chown root:hadoop /etc/security/keytabs/spnego.service.keytab
ssh xldd4edn07.swacorp.com chown root:hadoop /etc/security/keytabs/spnego.service.keytab
ssh xldd4edn08.swacorp.com chown root:hadoop /etc/security/keytabs/spnego.service.keytab

# Change the user/group permissions of the hawq keytab
ssh xldd4ehwq03.swacorp.com chown gpadmin:gpadmin /etc/security/keytabs/hawq.service.keytab
ssh xldd4ehwq04.swacorp.com chown gpadmin:gpadmin /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn05.swacorp.com chown gpadmin:gpadmin /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn06.swacorp.com chown gpadmin:gpadmin /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn07.swacorp.com chown gpadmin:gpadmin /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn08.swacorp.com chown gpadmin:gpadmin /etc/security/keytabs/hawq.service.keytab


# Change the user/group permissions of the pxf keytab
ssh xldd4edn05.swacorp.com chown pxf:hadoop /etc/security/keytabs/pxf.service.keytab
ssh xldd4edn06.swacorp.com chown pxf:hadoop /etc/security/keytabs/pxf.service.keytab
ssh xldd4edn07.swacorp.com chown pxf:hadoop /etc/security/keytabs/pxf.service.keytab
ssh xldd4edn08.swacorp.com chown pxf:hadoop /etc/security/keytabs/pxf.service.keytab

# Change the permissions on http keytabs
###other nodes?
ssh xldd4ehwq03.swacorp.com chmod 440 /etc/security/keytabs/spnego.service.keytab
ssh xldd4ehwq04.swacorp.com chmod 440 /etc/security/keytabs/spnego.service.keytab
ssh xldd4edn05.swacorp.com chmod 440 /etc/security/keytabs/spnego.service.keytab
ssh xldd4edn06.swacorp.com chmod 440 /etc/security/keytabs/spnego.service.keytab
ssh xldd4edn07.swacorp.com chmod 440 /etc/security/keytabs/spnego.service.keytab
ssh xldd4edn08.swacorp.com chmod 440 /etc/security/keytabs/spnego.service.keytab

# Change the permissions on hawq keytabs
ssh xldd4ehwq03.swacorp.com chmod 400 /etc/security/keytabs/hawq.service.keytab
ssh xldd4ehwq04.swacorp.com chmod 400 /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn05.swacorp.com chmod 400 /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn06.swacorp.com chmod 400 /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn07.swacorp.com chmod 400 /etc/security/keytabs/hawq.service.keytab
ssh xldd4edn08.swacorp.com chmod 400 /etc/security/keytabs/hawq.service.keytab

# Change the permissions on pxf keytabs
ssh xldd4edn05.swacorp.com chmod 400 /etc/security/keytabs/pxf.service.keytab
ssh xldd4edn06.swacorp.com chmod 400 /etc/security/keytabs/pxf.service.keytab
ssh xldd4edn07.swacorp.com chmod 400 /etc/security/keytabs/pxf.service.keytab
ssh xldd4edn08.swacorp.com chmod 400 /etc/security/keytabs/pxf.service.keytab
