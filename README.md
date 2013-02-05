vagrant-roller
==============

vagrant-roller is a very simple project, it provides an automated way of installing the [Apache Roller](http://roller.apache.org/) blog software on to a Virtual Machine.

### How?
Using the awesome tool that is [Vagrant](http://www.vagrantup.com/) and a sprinkling of [Puppet](https://puppetlabs.com/) configuration.

### What is it useful for?

vagrant-roller has 3 main purposes:

1. To provide a quick and easy means to test drive Roller - useful for people who are interested in trying Roller but don't want to go through the hassle of installing and configuring it manually.
2. To provide an convenient and sandboxed way to author and test Roller themes. 
3. To provide some Puppet code with which a Roller install may be automated.

### How do I use it?

Getting your install up and running is dead easy and can be done in just a few minutes.

* Install [Vagrant](http://www.vagrantup.com/)
* Download the zipped vagrant-roller repo and unzip to a convenient location
* Open a shell in the vagrant-roller folder and execute the command `vagrant up`
* Wait... The complete install typically takes a few minutes (about 3-4 on my laptop) so now is the perfect time to go and make that brew you've been thinking about

### How do I access Roller?

Once your install has completed navigate to [http://localhost:8080/roller]() (unless you have changed the deployed context root in which case replace 'roller' with the value you have set). From this point in you'll be able to create new users, create Blogs etc. New users may find the user guide helpful

### vagrant-roller anatomy:
* Most aspects of the install are configurable (context root, database name, password etc). Anything that is configurable can be set in `manifests/default.pp`
* The install uses just 3 puppet modules: `mysql`, `roller` and `tomcat` which can be found in the `modules` directory
* The roller 4.0.1 war can be found in the `modules/roller/files` directory.

### Broken?
I've hosed my Roller installation, how do I destroy and re-install it from scratch?
That's easy, just execute the command `vagrant destroy -f && vagrant up` and you'll be back up and running in just a few minutes.

### Any limitations?

Yes, currently vagrant-roller is only able to perform a Roller 4.0.1 install. I'm currently ironing out a few gremlins in getting Roller 5 working and will add that to the repo once sorted.

Questions, issues and contributions welcome. Note however I can't do anything about any bugs in the Roller or Vagrant products themselves, for that you'll need to raise an issue in their respective mailing lists or issue trackers [(Roller)](https://issues.apache.org/jira/browse/ROL), [(Vagrant)](https://github.com/mitchellh/vagrant/issues). I can however respond to issues in the vagrant-roller puppet code so please feel free to raise any that you spot.

Enjoy!

EdD



