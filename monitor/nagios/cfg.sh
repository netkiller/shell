#!/bin/bash

cat > /srv/nagios-4.0.8/etc/servers/commands.cfg <<'EOD'
# 'check_nrpe' command definition
define command{
        command_name    check_nrpe
        command_line    $USER1$/check_nrpe -H $HOSTADDRESS$ -t 30 -c $ARG1$
        }
define command{
        command_name    check_nrpe_args
        command_line    $USER1$/check_nrpe -H $HOSTADDRESS$ -t 30 -c $ARG1$ -a $ARG2$
        }

# 'notify-host-by-sms' command definition
define command{
        command_name    notify-host-by-sms
        command_line    /srv/sms/alert $CONTACTPAGER$ "Host: $HOSTNAME$\nState: $HOSTSTATE$\nAddress: $HOSTADDRESS$\nInfo: $HOSTOUTPUT$\n\nDate/Time: $SHORTDATETIME$\n"
        }

# 'notify-service-by-sms' command definition
define command{
        command_name    notify-service-by-sms
        command_line    /srv/sms/alert $CONTACTPAGER$ "State: $SERVICESTATE$\nService: $SERVICEDESC$\nHost: $HOSTALIAS$\nAddress: $HOSTADDRESS$\nTime: $SHORTDATETIME$\nInfo:\n$SERVICEOUTPUT$"
        }

# 'check_http' command definition
define command{
        command_name    check_http_url
        command_line    $USER1$/check_http -H '$HOSTADDRESS$' -I '$HOSTADDRESS$'  -u '$ARG1$'
        }
define command{
        command_name    check_http_url_string
        command_line    $USER1$/check_http -H '$HOSTADDRESS$' -I '$HOSTADDRESS$' -u '$ARG1$' -s '$ARG2$'
        }
define command{
        command_name    check_http_url_status
        command_line    $USER1$/check_http -H '$HOSTADDRESS$' -I '$HOSTADDRESS$' -u '$ARG1$' -e '$ARG2$'
        }     
define command{
        command_name    check_http_status
        command_line    $USER1$/check_http -H '$HOSTADDRESS$' -I '$HOSTADDRESS$' -e '$ARG1$'
        }
define command{
        command_name    check_http_port
        command_line    $USER1$/check_http -H '$HOSTADDRESS$' -I '$HOSTADDRESS$'  -p '$ARG1$'
        }
define command{
        command_name    check_http_port_status
        command_line    $USER1$/check_http -H '$HOSTADDRESS$' -I '$HOSTADDRESS$'  -p '$ARG1$' -e '$ARG2$'
        }

#check mysql 
define command{ 
        command_name check_mysql 
        command_line $USER1$/check_mysql -H $HOSTADDRESS$ -u $ARG1$ -p $ARG2$ -d $ARG3$
}
define command{
        command_name check_mysql_slave
        command_line $USER1$/check_mysql -H $HOSTADDRESS$ -u $ARG1$ -p $ARG2$ -d $ARG3$ -S
}

EOD

cat > /srv/nagios-4.0.8/etc/servers/hostgroups.cfg <<'EOD'
define hostgroup{
    hostgroup_name      Database
    alias               Database Server
    members             *
}
define hostgroup{
    hostgroup_name      Web
    alias               Web Server
    members             *
}
define hostgroup{
    hostgroup_name      Cache
    alias               Cache Server
    members             *
}
EOD

cat > /srv/nagios-4.0.8/etc/servers/templates.cfg <<'EOD'
define contact{
        name                            management-contact    	; The name of this contact template
        service_notification_period     overtime			; service notifications can be sent anytime
        host_notification_period        overtime			; host notifications can be sent anytime
        service_notification_options    w,u,c,r,f,s		; send notifications for all service states, flapping events, and scheduled downtime events
        host_notification_options       d,u,r,f,s		; send notifications for all host states, flapping events, and scheduled downtime events
        service_notification_commands   notify-service-by-email,notify-service-by-sms	; send service notifications via email
        host_notification_commands      notify-host-by-email,notify-host-by-sms	; send host notifications via email
        register                        0       		; DONT REGISTER THIS DEFINITION - ITS NOT A REAL CONTACT, JUST A TEMPLATE!
        }

define contact{
        name                            developer-contact    	; The name of this contact template
        service_notification_period     workday			; service notifications can be sent anytime
        host_notification_period        workday			; host notifications can be sent anytime
        service_notification_options    w,u,c,r,f,s		; send notifications for all service states, flapping events, and scheduled downtime events
        host_notification_options       d,u,r,f,s		; send notifications for all host states, flapping events, and scheduled downtime events
        service_notification_commands   notify-service-by-email	; send service notifications via email
        host_notification_commands      notify-host-by-email	; send host notifications via email
        register                        0       		; DONT REGISTER THIS DEFINITION - ITS NOT A REAL CONTACT, JUST A TEMPLATE!
        }

define contact{
        name                            tester-contact    	; The name of this contact template
        service_notification_period     workday			; service notifications can be sent anytime
        host_notification_period        workday			; host notifications can be sent anytime
        service_notification_options    w,u,c,r,f,s		; send notifications for all service states, flapping events, and scheduled downtime events
        host_notification_options       d,u,r,f,s		; send notifications for all host states, flapping events, and scheduled downtime events
        service_notification_commands   notify-service-by-email,notify-service-by-sms	; send service notifications via email
        host_notification_commands      notify-host-by-email,notify-host-by-sms	; send host notifications via email
        register                        0       		; DONT REGISTER THIS DEFINITION - ITS NOT A REAL CONTACT, JUST A TEMPLATE!
        }

define contact{
        name                            administrator-contact    	; The name of this contact template
        service_notification_period     24x7			; service notifications can be sent anytime
        host_notification_period        24x7			; host notifications can be sent anytime
        service_notification_options    w,u,c,r,f,s		; send notifications for all service states, flapping events, and scheduled downtime events
        host_notification_options       d,u,r,f,s		; send notifications for all host states, flapping events, and scheduled downtime events
        service_notification_commands   notify-service-by-email,notify-service-by-sms	; send service notifications via email
        host_notification_commands      notify-host-by-email,notify-host-by-sms	; send host notifications via email
        register                        0       		; DONT REGISTER THIS DEFINITION - ITS NOT A REAL CONTACT, JUST A TEMPLATE!
        }

# Linux host definition template - This is NOT a real host, just a template!

define host{
        name                            flexible-server
        use                             generic-host
        check_period                    24x7
        check_interval                  1
        retry_interval                  1
        max_check_attempts              10
        check_command                   check-host-alive
        notification_period		        24x7
        notification_interval           120
        notification_options            d,u,r
        contact_groups                  admins, technology
        register                        0
        }

# Flexible service definition template - This is NOT a real service, just a template!

define service{
        name                            flexible-service
        use                             generic-service
        max_check_attempts              3
        normal_check_interval           1
        retry_check_interval            1
	    contact_groups					admins, technology
        register                        0
	    }
EOD
# check_interval * normal_check_interval = 检查次数

cat > /srv/nagios-4.0.8/etc/servers/timeperiods.cfg <<'EOD'
define timeperiod{
        timeperiod_name workday
        alias           Normal Work Hours
        monday          09:00-18:00
        tuesday         09:00-18:00
        wednesday       09:00-18:00
        thursday        09:00-18:00
        friday          09:00-18:00
        }
define timeperiod{
        timeperiod_name overtime
        alias           Work Hours and Overtime
        monday          09:00-22:00
        tuesday         09:00-22:00
        wednesday       09:00-22:00
        thursday        09:00-22:00
        friday          09:00-22:00
        }

EOD
