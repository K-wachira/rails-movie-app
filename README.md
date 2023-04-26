# Movie Store.


On top of the [omdbapi](https://www.omdbapi.com/), my web application Movie Review enables users to search for movies/tv shows and games, lets users like, Add to Watch List or mark a movie as seen. 
Users also can create acounts and log back in to interact with previously saved data. 

The following infomation is saved with (CRUD)

* User name 
* User email 
* Password Digest 

---
* imdb movie ID 
* Poster Url 
* Title 
* Rating 
* If movie is watched, liked or added to watch list 
* Record creation, and upsert dates


--- 
The application handle adding and removing of records from the database as well as authenticating users. 

The application is created using Bootstrap for a basic UI 

---

To run the application you need

* Ruby version [3.2.1](https://www.ruby-lang.org/en/news/2023/02/08/ruby-3-2-1-released/). 
    Can be installed with [rvm](http://rvm.io/) using `rvm install 3.2.1`

* [Docker](https://docs.docker.com/) and [Docker-Compose](https://docs.docker.com/compose/)

* Database - postgresql used (relational database due to the transactional nature of the application)

* Keys. 
    create a .env file in the root dir of the project and add the following

    ```
        POSTGRES_HOST=db
        POSTGRES_DB=movie-app
        POSTGRES_USER=init
        POSTGRES_PASSWORD=1234
        RAILS_MASTER_KEY=0c5f162e3316ea202f0e0fa6ab7fb1df
        RAILS_ENV=production
    ```
--- 

Deployment instructions

To run the application you have need docker installed and running. 
navigate to the route folder of the applicationa and run the following command

`docker-compose build && docker-compose up`


The application can then be accessed on `http://0.0.0.0:3000/` 


Note, 
If you have applications(eg postgresql ) running on port 5432 modify `docker-compose.yml`'s 

```
    ports:
      - "5432:5432"
```

to 


```
    ports:
      - "5431:5432"

```

or to a port that is not in use


Port 3000 should also not be in use on your local machine


## Additional Features that would improve the application.

- Cache data locally or on the db to avoid hitting the API with dublicate queries over time. 
- Imlement advanced filtering search queries Done
- 
