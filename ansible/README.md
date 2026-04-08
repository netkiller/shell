ansible
=======

Netkiller ansible playbook

# Install ansible

	yum install -y ansible
	git clone https://github.com/oscm/ansible.git

## Config hosts
	vim /etc/ansible/hosts
	
	Example:
	
	192.168.1.100
	192.168.1.110

## Test 

	# ansible 192.168.1.100 -m ping
	192.168.1.100 | success >> {
		"changed": false, 
		"ping": "pong"
	}
