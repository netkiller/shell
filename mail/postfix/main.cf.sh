postconf -e "default_process_limit = 5"
postconf -e "default_destination_concurrency_limit = 5"
postconf -e "smtpd_client_connection_count_limit = 5"
postconf -e "queue_run_delay = 1h"
postconf -e "maximal_queue_lifetime = 1d"

postconf -e "qmgr_message_active_limit = 5000"
