vagrant-roller
==============

vagrant-roller is a very simple project, it provides an automated way of installing the [Apache Roller](http://roller.apache.org/) blog software on to a Virtual Machine.

### How?
Using the awesome tool that is [Vagrant](http://www.vagrantup.com/) and a sprinkling of [Ansible](http://www.ansible.com/home) configuration.

### What is it useful for?

vagrant-roller has 3 main purposes:

1. To provide a quick and easy means to test drive Roller - useful for people who are interested in trying Roller but don't want to go through the process of installing and configuring it manually.
2. To provide a convenient and sandboxed way to author and test Roller themes. 
3. To provide some Ansible code with which a Roller installation may be automated.

### How do I use it?

Getting your install up and running is dead easy and can be done in just a few minutes.

* Install [Vagrant](http://www.vagrantup.com/)
* Install [Ansible](http://www.ansible.com/home)
* Download the [zipped vagrant-roller repo](https://github.com/eddgrant/vagrant-roller/archive/master.zip) and unzip to a convenient location
* Open a shell in the vagrant-roller folder and execute the command `vagrant up`
* Wait... The complete install typically takes approx 3 - 10 minutes to complete (this will depend somewhat on your internet connection) so now is the perfect time to go and make that brew you've been thinking about. Vagrant will keep you updated as it progresses, don't worry if it appears to stop for a few seconds here and there as it provisions the VM. 

To give you an idea how easy this can be the process is shown below for Ubuntu (13.04 64 bit)

    sudo apt-get install -y vagrant ansible
    wget https://github.com/eddgrant/vagrant-roller/archive/master.zip
    unzip master.zip
    cd vagrant-roller-master
    vagrant up
    # Wait until vagrant has started up and then go to http://www.localhost:8080/roller

### How do I access Roller?

Once your install has completed navigate to [http://localhost:8080/roller](http://localhost:8080/roller) (unless you have changed the deployed context root in which case replace 'roller' with the value you have set). From this point in you'll be able to create new users, create Blogs etc. New users may find the [user guide](http://www.apache.org/dist/roller/roller-5/v5.0.3/docs/roller-user-guide.pdf) helpful

### vagrant-roller anatomy:
* Most aspects of the install are configurable (context root, database name, password etc). Anything that is configurable can be set in `ansible/roles/roller/vars/main.yml`
* The version of Roller that gets deployed can be set to either `4.0.1` or `5.0.3`. This is configured in the `roller_version` Ansible variable.
* The roller 5.0.3 war can be found in the `ansible/roles/roller/files` directory.

### Broken?
I've hosed my Roller installation, how do I destroy and re-install it from scratch?
That's easy, just execute the command `vagrant destroy -f && vagrant up` and you'll be back up and running in just a few minutes. Do be warned though that this will delete any data you've created (blog posts etc).

Questions, issues and contributions welcome. Note however I can't do anything about any bugs in the Roller or Vagrant products themselves, for that you'll need to raise an issue in their respective mailing lists or issue trackers [(Roller)](https://issues.apache.org/jira/browse/ROL), [(Vagrant)](https://github.com/mitchellh/vagrant/issues). I can however respond to issues in the vagrant-roller Ansible code so please feel free to raise any that you spot (or just to ask any questions).

Enjoy!

Edd



