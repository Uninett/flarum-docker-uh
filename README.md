Image on [Docker Hub](https://hub.docker.com/r/uninettno/dataporten-flarum/)

# Flarum & Dataporten Docker Image

The image features PHP/Nginx/Flarum, with:

- The [Dataporten extension] (https://packagist.org/packages/uninett/flarum-ext-auth-dataporten), which allows users to login using Dataporten from UNINETT
- [Norwegian translation extension](https://packagist.org/packages/pladask/flarum-ext-norwegian-bokmal)
- Command-line installation of Flarum with YAML config file (see below) 
- No need to create DB ahead of time (the config file takes care of that)
- OR run a container with ENVs pointing to an existing Flarum (DB) installation

Note 1: Built to work with Flarum `v0.1.0-beta.5`.
Note 2: By design, the image does not come with MySQL installed - it should use an external DBMS.
Note 3: Although the image is adapted to suit higher education in Norway, the workflow (and Dataporten OAuth extension) may be useful to others wanting to create something similar.

## Installation

Grab the image from Docker Hub: `docker pull uninettno/dataporten-flarum` (alt. you can build the image from this repo).

Note that, while Flarum is contained within the image, it has not been installed (i.e. configured).

Create a file that contains your environment variables. Should look something like this 

```
BASE_URL=http://localhost
DB_HOST=DB_HOSTNAME
DB_NAME=DB_NAME
DB_UNAME=DB_USERNAME 
DB_PW=DB_USER_PASSWORD
ADMIN_UNAME=ADMIN_USERNAME
ADMIN_PW=ADMIN_PASSWORD
ADMIN_MAIL=ADMIN_MAIL_ADDRESS
SITE_NAME=FLARUM_SITE_NAME
DATAPORTEN_CLIENTID=DATAPORTEN_CLIENT_ID
DATAPORTEN_CLIENTSECRET=DATAPORTEN_CLIENT_SECRET
```

### To run a fresh install of Flarum

Run a new container:

> docker run -d -p 80:80 --env-file=env.list --name flarum uninettno/dataporten-flarum

## Dataporten login

Go to the URL of your Flarum installation and log in as admin with the admin credentials:

- Menu `Admin->Administration`
- Page `Extensions`
- Enable extension Dataporten (and optionally Norwegian translation extension)
    - Double-check that the Client ID and Client Secret are entered in the extension's Settings
- Log out and back in again - notice that Dataporten Login now is an option in the login window :)

The redirect URI for your client should be the URI to your Flarum site, plus `/auth/dataporten`.

More info about Dataporten in the [Dataporten extension readme on GitHub](https://github.com/skrodal/flarum-ext-auth-dataporten).


## Useful Docker commands

Stop [and remove] the container:
    
> docker stop flarum [&& docker rm flarum]

Start a stopped container named 'flarum':
    
> docker start flarum

Enter the running container:
    
> docker exec -ti flarum bash

Change terminal (e.g. to fix Nano)

> export TERM=xterm
