
#!/bin/bash


#set default write log to cmdlog.log
echo " config log history "

cp /etc/profile cat /etc/profile.bk
echo "export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local6.debug \"[[\$(echo \$SSH_CLIENT | cut -d\" \" -f1)] # \$(whoami) ] # \$(history 1 | sed \"s/^[ ]*[0-9]\+[ ]*//\" )\"'" >> /etc/profile
echo 'export HISTTIMEFORMAT="%d/%m/%y %T "' >> /etc/profile



# create file cmdlog.log
touch /var/log/cmdlog.log

echo " config rsyslog"


# edit /etc/rsyslog to writelog to cmdlog.log
cat >> /etc/rsyslog.conf << EOF
#==========update RULES========
auth.*  /var/log/auth.log
daemon.*-/var/log/daemon.log
local6.*-/var/log/cmdlog.log
EOF

source /etc/profile
#restart rsyslog
systemctl restart rsyslog


echo " DONE "
