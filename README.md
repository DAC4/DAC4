# DAC4

## Live test instance
A live test instance is available at http://dac.ribesg.fr/ and will stay available until 2015-03-01.

## Builds
Find DAC4.war and the DAC4 VM at http://ci.ribesg.fr/browse/DAC ([Direct link to latest VM](http://ci.ribesg.fr/browse/DAC-VM/latestSuccessful/artifact/shared/VM/dac4.vmdk))

## Howto

### Compile project into ``.war`` file
Requires:
* Maven 2/3
````bash
mvn
````

### Run tests against a live test instance
#### On a headless system (Tested on Ubuntu Server 14.04)
Requires:
* Maven 2/3
* Mozilla Firefox installed at default location
* Xvfb installed
````bash
mvn -DskipTests=false -Dtrocbox.test.instanceUrl=http://example.com/ -Dtrocbox.test.display=:20
````
#### On a system with GUI (Tested on Windows 8.1 x64 and Ensimag's CentOS)
Requires:
* Maven 2/3
* Mozilla Firefox installed at default location
````bash
mvn -DskipTests=false -Dtrocbox.test.instanceUrl=http://example.com/
````
Works great from an IDE by just launching the Selenium test suite (without maven) when providing following VM argument:
````bash
-Dtrocbox.test.instanceUrl=http://example.com/
````
(Tested in IntelliJ IDEA 14).

### Into the VM
Glassfish and MySQL should start at the VM startup.
After starting the VM, login as vagrant user (password being vagrant).
#### Deploying a DAC4.war
Download the DAC4.war file to ``/home/vagrant`` then run the following command:
````bash
./glassfish4/glassfish/bin/asadmin --user=admin --passwordfile pwd --interactive=false deploy --force=true DAC4.war
````
Make sure you've got the ``pwd`` file in ``/home/vagrant`` containing ``AS_ADMIN_PASSWORD=admin``.
#### Resetting the MySQL Database
Download the ``reset.sql`` file available in this repository under ``./sql/``, then launch the following command:
````bash
mysql -u root -proot < reset.sql
````
