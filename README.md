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

u
---

To run the application you need

* Ruby version 3.2.1

* Docker 

* Configuration

* Database - sqlite  used

--- 

Deployment instructions

docker build --tag moviereview .

docker run -p 3000:3000 moviereview
