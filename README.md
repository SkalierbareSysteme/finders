# Welcome to Finders


## Run Finders

To run this repository, follow these steps:

1. Make sure that you have set up SSH correctly in GitLab.
2. Clone the repository: `git clone --recurse-submodules git@github.com:SkalierbareSysteme/finders.git`
3. Navigate into the folder: `cd finders`
4. Create a docker shared network once before the first start-up: `docker network create finders-network`
5. Run `docker compose up`

## Some notes

- Sometimes, a service could crash on the first time running `docker compose up`. If that happens, just stop all services and try again.
- To run only some services, comment/uncomment entries in `docker-compose.yml`.
- If not all submodules are up to date, use `git submodule update --remote --merge` to update them.
