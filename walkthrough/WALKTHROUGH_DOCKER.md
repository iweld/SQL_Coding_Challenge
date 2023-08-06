## Shaker's SQL Analytics Code Challenge
### PostgreSQL Project

**Author**: Jaime M. Shaker

**Email**: jaime.m.shaker@gmail.com

**Website**: https://www.shaker.dev

**LinkedIn**: https://www.linkedin.com/in/jaime-shaker/ 

This project is an opportunity to flex your SQL skills and prepare for the role of a Data Analyst.  This project was inspired by the [Braintree Analytics Code Challenge](https://github.com/AlexanderConnelly/BrainTree_SQL_Coding_Challenge_Data_Analyst) and was created to strengthen your SQL knowledge.

:exclamation: If you find this repository helpful, please consider giving it a :star:. Thanks! :exclamation:

This repository contains all of the necessary files, data and directories for running a PostgresSQL server in a Docker Container.  The only prerequisite is that you should already have Docker Desktop installed and running on your computer.

 https://www.docker.com/products/docker-desktop/

 Once we have `Docker desktop` installed and running, to begin this project, we must have Docker download an Image of Postgres and start running the Postgres container.

 Using your terminal (Powershell/Bash/ect...) and cd (changed directory) to where this project is located.  To ensure you are in the correct directory, you can use the command

 `ls -al`

 Your results should look something similar to this.

 ![alt text](../images/terminal_1.PNG)

 As mentioned before, in the same directory as the `docker-compose.yaml` file, create an empty directory/file folder named '`db`'. This is where the PostgreSQL container will store internal data and keep your data persistent.
 * This directory's path is in the `.gitignore` file which is why it is not included in this repository.

 Once you are in the same directory as the `docker-compose.yaml` file, run this command to start the Docker container.

 `docker-compose up -d`

* The `-d` portion of the command allows the container to run in the background.
 * If this is the first time running this command, this will download the required Docker image and create a PostgreSQL container which may take a few minutes.  Once it is complete and running, your terminal should look something like this.
 * After the initial install, the next time you run   `docker-compose up -d`, the Docker container will fire right up as long as the image hasn't been deleted.

  ![alt text](../images/terminal_2.PNG)

If you are using PGAdmin or DBeaver, create a connection to the now running  PostgreSQL server.
* Database Name: `sql_coding_challenge`
* Username: `postgres`
* Password: `postgres`

Alternatively, if you are using [psql](https://gist.github.com/Kartones/dd3ff5ec5ea238d4c546), use these commands in your terminal to connect to the database:
* `docker exec -ti sql_coding_challenge psql -U postgres`
* `\c sql_coding_challenge`

To stop the Docker container:
* Using the command line, cd into the same directory as the `docker-compose.yaml` file and run the command...
* `docker-compose down`
* You can also use the Docker Desktop GUI to stop the container.

The `docker-compose down` command will stop the container until the next time you start it back up using the command: 
*  `docker-compose up -d`
 
Now that we have our PostgreSQL server up and running, click the link below and let's start creating tables and inserting data.

 Go to [WALKTHROUGH_BUILD](WALKTHROUGH_BUILD.md)

:exclamation: If you found the repository helpful, please consider giving it a :star:. Thanks! :exclamation:



