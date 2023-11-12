# CashCompass backend

## Description

This is the backend and REST api of the CashCompass. More information can be found in the [Wiki](https://github.com/SE-TINF22B2/G1-CashCompass/wiki)

## Installation

`npm install`

## Running the app

# Local development
To start the server locally, there are two options. Make sure you have [Node.js](https://nodejs.org/en), [Docker](https://www.docker.com/) and [docker-compose](https://docs.docker.com/compose/) installed.

### Production mode
If you only want to consume the NestJS api and dont want to make changes to it, you can just spin up the two containers (NestJS api and postgresSQL instance) via `npm run start:docker` to view the logs or via `npm run start:docker:bg` to run it in the background.

### Development mode
If you want to develop and make changes to the api, its enough to only run the database container via `npm run start:db`. The NestJS application can be started with `npm run start:dev` to start it in watch mode, so every time nest notices a change, it restarts.
