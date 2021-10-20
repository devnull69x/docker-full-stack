# [docker-full-stack](https://github.com/gerekper/docker-full-stack) #
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.

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


| Function      | Navigational  |  Public    | Admin     | Create    | Update    | Delete
| :------------ | :------:      | :------:   | :------:  | :------:  | :------:  | :------:
| Robots.txt    |  :o:          |  :o:       | :o:       | :o:       | :o:       | :o:
| Humans.txt    |  :o:          |  :o:       | :o:       | :o:       | :o:       | :o:
| Robot Logs    |  :o:          |  :x:       | :o:       | :x:       | :x:       | :o:
| Agents        |  :o:          |  :x:       | :o:       | :o:       | :o:       | :o:
| Robot Traps   |  :o:          |  :o:       | :o:       | :o:       | :o:       | :o:

## TODO ##
- Create Navigation
- Consolidate all working modules

## Thanks ##

* [Alexey Bobkov and Samuel Georges](http://octobercms.com) for OctoberCMS.
* [Scott Bedard](https://github.com/scottbedard) for HasMany Widget.
* [Saifur Rahman Mohsin](https://github.com/SaifurRahmanMohsin/) for Txt Generator.
* [James Healey](https://github.com/jayhealey) for Robots class/Service Provider.
* [Nick Gejadze](https://github.com/ngfw) for PHP Recipe Library and Generator