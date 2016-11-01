postconf -e "default_destination_concurrency_limit = 5"
postconf -e "queue_run_delay = 1h"
postconf -e "maximal_queue_lifetime = 1d"