
# oc-tool

  

##### oc-tool is tool for creating WordPress environment on OpenShift

  

## Introduction

  

This tool is a result of project task of Introduction to DevOps course. Goal of this project was to create a tool that will automatically create Wordpress container and container that will hold WordPress database within existing OpenShift project for specific user. For reverse proxy purposes I had to run Nginx container. For simulating realistic environments we needed to create two deployments like this one that would be used for production and one for testing purposes both with same functionality.

  
  

## Solution

  

I solved this task by creating two OpenShift projects, one called **wordpress-production** and the other **wordpress-test**. Each set of WordPress bundle is deployed by using two yaml files. One for deploying WordPress and database and one for deploying Nginx reverse proxy. oc-tool script and asks user for a name for whom script will create environment.

[![](https://i.imgur.com/hDVzvpd.png)](https://i.imgur.com/hDVzvpd.png)

## deployment.yml

  

This configuration is used to deploy WordPress website and MySQL database.

Using this configuration will deploy following in two projects:

  

#### Persistent volume claim
For providing storage tha will be used for storing data within WordPress container 1 gigabyte in size

#### Deployment
OpenShift deployment object will create a pod with two containers one running WordPress using `bitnami/wordpress:latest` image and one running MySQL database using `registry.redhat.io/rhel8/mysql-80` image. For setting up containers I set environment variables. Pod is deployed with one replica set.

#### Service
To provide connection for Nginx reverse proxy service object is deployed.


## nginx.yml
Configuration files used to deploy Nginx reverse proxy. To do that it will create following

#### ConfigMap
Using ConfigMap object I specified server block configuration will be inserted into Nginx container.

#### Deployment
Deployment object for creating Nginx pod with mounted Nginx configuration specified in ConfigMap. For container image I used `docker.io/bitnami/nginx:latest`. Pod is deployed with one replica set.

#### Service
Service object is used to provided connection to Nginx reverse proxy within cluster

#### Route
For making WordPress accessible to the Internet I create OpenShift Route object.

## oc-tool.sh
Finally for deploying all previous specified object I create bash script that asks for a name to whom this WordPress set will be deployed or whose set will be deleted. Since OpenShift cluster doesn't have dynamic templating engine to replace strings within script I use envsubst command.

[![](https://i.imgur.com/L6JQSVP.png)](https://i.imgur.com/L6JQSVP.png)


## How to use script
To use this script you have create project object in OpenShift cluster using web console or using following commands

    oc new-project wordpress-test
    oc new-project wordpress-production

after cloing the repo you have add execute permission to the file and you are ready to go

    chmod +x oc-tool.sh
	./oc-tool.sh
