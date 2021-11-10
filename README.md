# The Swift Package Index

Find the best Swift libraries and frameworks that support the [Swift Package Manager](https://swift.org/package-manager/).

## Reconciliation, Ingestion, and Analysis

The command processes that fetch and parse package metadata are broken up into three separate commands.

1. **Reconciliation**: Fetch the package list and reconcile it with the database, adding or deleting rows in the `packages` table.
2. **Ingestion**: Fetch GitHub (or in the future, other hosting services) metadata for a set of package candidates returned by `Package.fetchCandidates(app.db, for: .ingestion, limit: 10) ` and create or update rows in the `repositories` table.
3. **Analysis**: Clone or pull the full git history for a set of package candidates returned by `Package.fetchCandidates(app.db, for: .analysis, limit: 10) ` and create or replace rows in `versions` and `products`.

## Running this project

The `Makefile` defines a set of useful targets to get up and running. The default environment variables they use are defined in `.env.testing.template` and `.env.development.template`. Before running any of the services, copy these files removing the `.template` extension and review their content in case your setup deviates from the default.

With that taken care of, make sure you have [Docker](https://www.docker.com/products/docker-desktop) installed and running, and then run:

```
make db-up
```

This will bring up two Postgres database docker containers (one for development, the other for the tests). Then, run:

```
make migrate
```

This will set up the schema (or migrate it, if you've made changes) on the development database.

```
make run
```

This will bring up a local development server.

```
make serve-front-end
```
This will serve the frontend. 


## Running the project from Xcode

Alternatively, you can open the `Package.swift` file in Xcode and run the server from there. However, it's important to set a custom working directory before running. To do this, navigate to the **Product** | **Scheme** | **Edit Scheme...** menu or press ⌘+<. Select the **Run** scheme action and select the **Options** tab. Finally, check the **Working Directory** checkbox and enter the directory where you have this source code checked out.

## Resetting the database

You can reset the database to a clean slate by tearing down the containers by running:

```
make db-reset
```

This command will *destroy* both the development, and test docker containers. Recreate them, and finally migrate the development database.

## Running an end-to-end test

Once you're all set up, run:

```
make test-e2e
```

This will kick off a local test run of the server update process (reconciliation, ingestion, and analysis) processing just *one* package. This is a good way to verify everything is working.

## Running ingestion locally

The `ingest-loop.sh` script can serve as a simple way to run a full ingestion cycle:

```
make reset        # clear dev db
make reconcile    # import package list
./scripts/ingest-loop.sh  # ingest metadata for 100 packages, pause for 10 sec, repeat
```

If you want to run ingestion for anything other than a cursory test, you'll need authenticated API calls. To do this, set a `GITHUB_TOKEN` environment variable to a [generated personal token](https://github.com/settings/tokens) which has the `public_repo` and `repo:status` scopes.

## Running analysis locally

You can run the analysis step locally by running

```
make analyze
```

This will run the analysis stage for one package (`--limit 1`).

NB: The analysis step will check out repositories to your local file system, by default into a directory `SPI-checkouts` in your project folder. You can change this location by setting the environment variable `CHECKOUTS_DIR` to another path.

## API poking

NB: The API is currently disabled. Uncomment the api routes in `Sources/routes.swift` to re-enable them.

You can poke at the API using [Rester](https://github.com/finestructure/Rester) by running the Restfile `test.restfile`:

```
rester restfiles/test.testfile
```

This does not replace testing but helps with API exploration and integration testing.

## Running the full stack locally

The application stack is defined in the `app.yml` docker compose file. The only other required component is the database, which can be brough up via `make db-up-dev` and populated via the processing steps or a database dump.

If you connect to a locally running database, either one brought up via `make db-up-dev` or one running directly on your machine, make sure to specify the `DATABASE_HOST` variable as `host.docker.internal`, which is the hostname of the machine running docker as seen from within a container and automatically configured by docker's networking.

Set up any of the other required environment variables in an `.env` file and run

```
env VERSION=2.47.11 docker-compose -f app.yml up -d
```

to bring up the full stack. The `VERSION` variable references a tag name or a git sha. You can either rely on docker pulling a previously built image from the registry or build and tag a version you want to run locally:

```
$ make docker-build
No VERSION provided, defaulting to d64a881019662aced6fa0a3748b754dffa9fad29
docker build -t registry.gitlab.com/finestructure/swiftpackageindex:d64a881019662aced6fa0a3748b754dffa9fad29 .
Sending build context to Docker daemon  536.1MB
...
```

Use the logged `VERSION` for the `docker-compose` command.

Note that this will launch quite a number of services defined in `app.yml`, including the services that continuously process packages. In order to limit this to just the Vapor app, run

```
env VERSION=... docker-compose -f app.yml up -d server
```
