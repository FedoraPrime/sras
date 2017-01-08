SRAS -- An Asset Server for OpenSimulator
=========================================

NOTICE
------

On 12-18-2014, coyled declared the SRAS system abandonware. Recently as of Ruby 2.0 people have had issues installing, as several dependencies require Ruby 2.0 or greater but some of the commands used had been depreciated as of 2.0 (it's noted that File.exists was depreciated at 2.1 but we get the error with anything 2.0 or above). I've decided to take up this project & tinker with it in my spare time since this system is still used by so many grids out there. Please note this should be considered an ALPHA build, but seems to be stable.


Features
--------

 * Asset de-duplication
 * Compressed asset storage on disk
 * Ability to disable serving of specific assets without deleting


Install
-------

The packages of Ruby shipping with Ubuntu don't include built-in zlib
support.  I prefer using RVM [ http://rvm.beginrescueend.com/ ]
anyway.

Built & tested with Ruby v1.9.2.

Install via:

    $ gem install sras

then copy the following text into ``/etc/sras/sras.conf`` or
``~/.srasrc`` and edit as appropriate: ::

    sras:
        production:
            default_asset_dir: /srv/sras
            port: 8003
            log_file: /var/log/sras.log
            pid_file: /tmp/sras.pid

    mysql:
        production:
            adapter: mysql
            host: localhost
            username: sras
            password: sras
            database: sras


Running
-------

Then just:

    $ sras start

to start a single instance.  In a production environment you would
likely want to run several instances behind a reverse proxy like
Nginx.

To see additional options:

    $ sras --help


Testing
-------

To test asset creation:

    $ curl -d @test/test.asset -X POST -w '%{http_code}\n' \
        http://yourserver.example.com:8003/assets/

You should get a 200 HTTP response, have an entry in your assets
table, and have a file contain the asset data on disk.

To test retrieval of that asset:

    $ curl -X GET -w '%{http_code}\n' \
        http://yourserver.example.com:8003/assets/0193663d-44e4-4e6e-9a1c-8dd2febc5fc5/data 


Mailing List
------------

For SRAS-related announcements and discussion feel free to join the
low-volume mailing list.  You can join the list by submitting the form
at https://lists.sourceforge.net/lists/listinfo/sras-list

Mailing list members can email the list via
sras-list@lists.sourceforge.net

List archives can be found at
http://sourceforge.net/mailarchive/forum.php?forum_name=sras-list
