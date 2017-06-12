gzip
=====

	ssi on;
    ssi_silent_errors on;
    ssi_types application/javascript text/javascript text/css application/json application/xml;
    ssi_value_length 256;
    server_names_hash_bucket_size 128;
    client_header_buffer_size 32k;
    large_client_header_buffers 4 32k;