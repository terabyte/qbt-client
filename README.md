# QBT Client

this is an example of how you might distribute a binary copy of QBT to various
machines and keep it up to date.

You might optionally decide to check in a qbt-config file

You might write some scripts

You might have a cron job regularly fetch updates in this repo and run a deploy
command that builds and deploys some release package from your meta

# TO USE

Initial setup:

>     git clone <META_URL> meta
>     cp <QBT Config file> meta/qbt-config
>     echo "meta" > .qbt-meta-location

To update QBT:

>     bin/update-qbt.sh


