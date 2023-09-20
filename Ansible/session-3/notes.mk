# folder structure
└── project
    ├── deploy_webserver.yml
    └── webservers
        ├── README.md
        ├── defaults
        │   └── main.yml
        ├── files
        │   └── index.html
        ├── handlers
        │   ├── main.yml
        │   └── webserver_handlers.yml
        ├── meta
        │   └── main.yml
        ├── tasks
        │   ├── configure_webserver.yml
        │   ├── deploy_webpage.yml
        │   ├── install_webserver.yml
        │   └── main.yml
        ├── templates
        │   └── webserver.conf.j2
        ├── tests
        │   ├── inventory
        │   └── test.yml
        └── vars
            └── main.yml

1. create project folder
2. ansible-galaxy init webservers # it creates role webservers and its empty structure

3. defaults/main.yml :
---
# defaults file for webservers
# defaults/main.yml
webserver_package: apache2  # You can change this to the web server of your >
webserver_service: apache2  # Adjust this to match your web server
webpage_source: files/index.html

4. files/index.html :
               
<!DOCTYPE html>
<html>
<head>
    <title>My Web Page</title>
</head>
<body>
    <h1>Welcome to My Web Page</h1>
    <p>This is a sample webpage.</p>
</body>
</html>

5. handlers/main.yml :
# Import handlers for the webserver role.
- import_tasks: webserver_handlers.yml

6. handlers/webserver_handlers.yml :
# handlers/webserver_handlers.yml
- name: Restart Web Server
  service:
    name: "{{ webserver_service }}"
    state: restarted

7. tasks/main.yml : 
# tasks/main.yml

# Import the task to install the web server.
- import_tasks: install_webserver.yml

# Import the task to configure the web server.
- import_tasks: configure_webserver.yml

# Import the task to deploy the webpage.
- import_tasks: deploy_webpage.yml

8. tasks/configure_webserver.yml :
# tasks/configure_webserver.yml
---
- name: Copy Web Server Configuration
  template:
    src: webserver.conf.j2
    dest: /etc/{{ webserver_service }}/sites-available/default

- name: Ensure Web Server Config is Enabled
  file:
    src: /etc/{{ webserver_service }}/sites-available/default
    dest: /etc/{{ webserver_service }}/sites-enabled/default
    state: link

- name: Remove Default Web Root
  file:
    path: /var/www/html/index.html
    state: absent

9. tasks/deploy_webpage.yml :
# tasks/deploy_webpage.yml
---
- name: Deploy Webpage
  copy:
    src: "{{ webpage_source }}"
    dest: /var/www/html/index.html

10. tasks/install_webserver.yml :
# tasks/install_webserver.yml
---
- name: Install Web Server
  apt:
    name: "{{ webserver_package }}"
    state: present
  become: true

11. templates/webserver.conf.j2 :
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html
</VirtualHost>

12. tests/test.yml  :
---
- hosts: webservers
  remote_user: root
  roles:
    - webservers

12. Create a Playbook: Create a playbook (e.g., deploy_webserver.yml) that specifies the hosts and includes your webserver role. 

Here's an example playbook:
# deploy_webserver.yml
- hosts: your_target_hosts
  become: true  # Use if you need superuser privileges
  roles:
    - webservers

13. to run the playbook : 
	ansible-playbook deploy_webserver.yml

sample run steps looks like :

		ubuntu@master:~/project$ ansible-playbook deploy_webserver.yml

		PLAY [slave] *******************************************************************

		TASK [Gathering Facts] *********************************************************
		ok: [slave]

		TASK [webservers : Install Web Server] *****************************************
		ok: [slave]

		TASK [webservers : Copy Web Server Configuration] ******************************
		ok: [slave]

		TASK [webservers : Ensure Web Server Config is Enabled] ************************
		ok: [slave]

		TASK [webservers : Remove Default Web Root] ************************************
		ok: [slave]

		TASK [webservers : Deploy Webpage] *********************************************
		changed: [slave]

		PLAY RECAP *********************************************************************
		slave   : ok=6    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
