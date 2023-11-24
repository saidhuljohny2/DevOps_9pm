## project structure 
project_directory/
├── apache_setup.yml
├── templates/
│   └── index.html.j2

Step 1: Create an Ansible Playbook
	- Create a new Ansible playbook file, e.g., apache_setup.yml, in your project directory. 
	- You can use nano text editor to create and edit this file.
	- copy code and paste

Step 2: Create the Jinja2 Template for index.html
	- Create an HTML template file named index.html.j2 inside a templates directory in your project directory.
	- first create templates directory and then create index.html.j2
	- This template file will be used to generate the sample website content.
	- copy code and paste

to run the playbook : apache_setup.yml
	- ansible-playbook apache_setup.yml
	- see all the tasks are getting succeeded
	- if failed = 0, which means configuration created in both servers

Testing:
	- You test your web server by accessing it via a web browser using its IP address
	- to check website : 
		- ipaddress:80
	- test

	code added

_______________________________________________________________________________________________________


getting started with ansible :
	https://docs.ansible.com/ansible/latest/getting_started/index.html
	
Verify the hosts in your inventory : 
	ansible all --list-hosts

Ping the managed nodes :
	ansible all -m ping

