# Plordle API

A .NET 9 API that interacts with a MongoDB database for player data. Has been containerized and deployed to AWS


## Features
- Can seed the database from a CSV 
- Picks a new random player each day based on the date (will change based on the time zone of where the API is run)
- Has endpoints to pull the daily player as well as a random player from the database
- Can be run directly by itself, in a Docker container, or bundled with a MongoDB Container via Docker Compose
