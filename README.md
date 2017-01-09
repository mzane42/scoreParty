# ScoreParty Api

Simple APi project to save your video games score connected with [scoreParty-angular](https://github.com/mzane42/scoreParty-angular)  the project include :
* Oauth2 authentication via Facebook.
* CRUD to save score games
* Get friends Facebook 
* etc ...

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

* Ruby 2.2.6 or newer
* Rails 4.2 or newer

### Installing

A step by step series of examples that tell you have to get a development env running

First, install gems required with : 

~~~bash
bundle install
~~~

Then, create the database :

~~~bash
rake db:create
~~~

Then, run migration :

~~~bash
rake db:migration
~~~

Finally, seed the database with video games (Fifa, StreetFighter, Hearthstone etc...)  :

~~~bash
rake db:seed
~~~


## Running the server :
**Note:** the client side will run on port 3000

~~~bash
rails server -p 3001
~~~


## Client side :

Go to [scoreParty-angular](https://github.com/mzane42/scoreParty-angular) to install the client.

## Author

* **Zane Anis** - [mzane42](https://github.com/mzane42)
