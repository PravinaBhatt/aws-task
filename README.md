Create Server on AWS and run checker script to validate its liveliness
======================================================================

# Goal

Script the creation of a web server, and a script to check the server is up.

# Prerequisites

You will need an AWS account. Create one if you don't own one already. You can use free-tier resources for this test.

# The Task

You are required to set up a new server in AWS. It must:

* Be publicly accessible.
* Run Nginx.
* Serve a `/version.txt` file, containing only static text representing a version number, for example:

```
1.0.6
```

# Create the server.

Steps to create server on AWS and run Nginx with custom static file:
1. Create IAM service under AWS Management Console: This step is used to create IAM group, user, roles, policies and other access configurations 
NOTE: Steps a, b and c are not part of server creating steps, but it is mandatory for creating an applications in org and allow/limit users 
a. Make sure to set up security policies first by managing account settings under “Security Status”. And save all the imp credentials like Multi-factor Authentication, Access keys, Cloud key pairs (will be used in later steps) and other certificates.
b. Create user group for your desired task/app_code.
c. Add users to the above created group who can be able to access its associated resources.
d. Create IAM role for instance creation on AWS management console (This is mandatory step for server creation performed in later steps).

2. Create EC2 instance on AWS Console: This step is used to create instance with required instance base image, type, storage, group and other settings for creation of server.
a. Launch instance from console.
b. Select base image for instance machine. 
c.  Select type.
d. Configure details like network, subnet, IAM role (refer step 1.c) or you can leave it as default.
e. Add storage, tag and security group if needed else just hit “Review and Launch”.
f. When you will launch the instance, pop-up option will ask to enter ec2 cloud key pair. This option usually display default key pair, if you have one created already (refer step 1.a). Else you need to create one first and follow step 1 to get instance created.

3. Set inbound rules for EC2 instances (under AWS management console): This step is used to specify the type of traffic our EC2 instance can be managed to handle for example: http, https or SSH and limit them as per required settings.
a. Edit inbound rules
b. Configure inbound rules with required network traffic details that your instances are expected. For example: Only certain IP can access EC2 instance via SSH, then set the rule under SSH type with custom IP option and add IP range.

4. Launch and install nginx on created instance.
a. Connect instance as browser-based SSH connection (We can also try SSH into instance).
b. Once you connect as ec2-user, you can see console of ec2 instance machine. 
c. Set new password for root user > sudo password root
d. Try updating yum > sudo yum update
e. Install nginx > sudo yum install nginx
f. Start & Enable nginx service > sudo systemctl start nginx / sudo systemctl enable nginx
g. Check nginx status > sudo systemctl status nginx
h. Check on browser if nginx is up and running > curl localhost / accessing public DNS in browser
5. Replace nginx homepage with custom static file: Usually when nginx service is launched on any machine it will display custom index.html content on browser. This is configured in /etc/nginx/nginx.conf file in linux machines. We can tweak the file location in config file and make custom content displayed on nginx homepage. 
a. Create version.txt file containing custom data.
b. Locate nginx config file: In this example, as we are using linux machine this file can be seen under /etc/nginx/nginx.conf
c. Replace server section with 
server {
root	/;
       
location / {
try_files $uri /nginx/repos/version.txt;
}

d. The above tweak in server file location will display content of file “version.txt” at nginx homepage now as we swapped the content with index.html
e. Restart nginx service > sudo systemctl restart nginx
f. Check nginx service status > sudo systemctl status nginx
i. Check content of browser/ local host: curl localhost / accessing public DNS in browser


