# [docker-full-stack](https://github.com/gerekper/docker-full-stack) #
not tested yet

## What is it ##
As the title says, it allows for consolidation of the modules in gerekper.asia arsenal

## Installation ##

#### Manual Installation ####
Some advanced users might prefer to use manually install the plugin. This can be done using the command line. CD into your OctoberCMS project folder and paste these commands. It will execute one after another:
```
cd plugins
mkdir -p devnull/main && cd $_
git clone https://github.com/gerekper/oc-main-plugin.git ./
composer update
```

Logout from your backend and login again. This will create the necessary tables for the plugin to work. You have now installed Devnull.Main! Enjoy!!!

## Features ###
- Manage navigation for devnull.robot
- Manage navigation for devnull.seo
- Manage navigation for devnull.cookies


| Function      | mgt/worker-server1    |  worker-server2   | 
| :------------ | :------:              | :------:          | 
| redis-master  |  :yes:                |  :no:       | 
| Humans.txt    |  :✓:          |  :o:       | 
| Robot Logs    |  :✓:          |  :x:       | 
| Agents        |  :o:          |  :x:       | 
| Robot Traps   |  :o:          |  :o:       | 

## TODO ##
- Create Navigation
- Consolidate all working modules

## Thanks ##

* [Alexey Bobkov and Samuel Georges](http://octobercms.com) for OctoberCMS.
* [Scott Bedard](https://github.com/scottbedard) for HasMany Widget.
* [Saifur Rahman Mohsin](https://github.com/SaifurRahmanMohsin/) for Txt Generator.
* [James Healey](https://github.com/jayhealey) for Robots class/Service Provider.
* [Nick Gejadze](https://github.com/ngfw) for PHP Recipe Library and Generator