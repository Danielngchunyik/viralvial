<pre>
__     ___           _  __     ___       _
\ \   / (_)_ __ __ _| | \ \   / (_) __ _| |
 \ \ / /| | '__/ _` | |  \ \ / /| |/ _` | |
  \ V / | | | | (_| | |   \ V / | | (_| | |
   \_/  |_|_|  \__,_|_|    \_/  |_|\__,_|_|
</pre>

[![Circle CI](https://circleci.com/gh/vltlabs/viral-vial.svg?style=svg)](https://circleci.com/gh/vltlabs/viral-vial)

[![Code Climate](https://codeclimate.com/repos/546b1c05695680464c016d17/badges/3a143515d2030fa9e0a4/gpa.svg)](https://codeclimate.com/repos/546b1c05695680464c016d17/feed)
[![Test Coverage](https://codeclimate.com/repos/546b1c05695680464c016d17/badges/3a143515d2030fa9e0a4/coverage.svg)](https://codeclimate.com/repos/546b1c05695680464c016d17/feed)

## Overview

Pending

## Quickstart
Clone the repo and bundle

    git clone https://github.com/vltlabs/viral-vial.git
    cd viral-vial
    bundle install

Setting up `database.yml` based on your needs. (Use the default settings if you're not sure what to change)

    cp config/database.yml.sample config/database.yml

### Using `application.yml` file

[figaro](https://github.com/laserlemon/figaro "figaro") loads environment variables on an application-basis. Follow the instructions to use it

1. "figaro install" creates a commented config/application.yml file and adds it to your .gitignore.

2. Ask the project administrator for the env values. (If applicable)

Create the database and migrate

    rake db:create
    rake db:migrate

Start the server

    rails s

## Testing

Use `guard` for automated testing. To start:

    guard

### Release

This project is using [Git Tagging](http://git-scm.com/book/en/Git-Basics-Tagging) to manage production releases.

Add a version number to a commit in `master` by doing:

    git tag -a v1.2.3 -m '<your_message_goes_here>'

Then run

    git push --tags
