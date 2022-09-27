<h1 align="center">Welcome to Music Mates 🎶</h1>
<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg?cacheSeconds=2592000" />
</p>

> A proof of concept web app to find friends to go to local concerts with based on your music listening history. It was built using Ruby on Rails, a Postgres database, HTML, Javascript, custom SCSS and and bootstrap as a frontend components library. It relies on the Spotify API for users' listening history and the Bandsintown API for concert data. It was made in 2 weeks and presented as a final project for batch #966 of the Le Wagon Web Development Bootcamp in Melbourne on September 23rd 2022.

### 📱 [View Live](https://www.music-mates.com)
Due to time constraints, this app is not responsive and was designed for mobile only, specifically iPhone X screen size.

### ✨ [Demo Walkthrough]
Youtube link with a video of us demonstrating the app will go here once it's available!

## Installation

🛠 Setting up the app:
>
```sh
bundle install
yarn install
yarn build --watch
rails db:create
rails db:migrate
rails db:seed
```

Running the app in development mode:
>
```sh
rails s
```
Open http://localhost:3000

Reload the page to see your edits.

To bypass the Spotify login page and login manually, just go directly to the url of any of the pages.

Check the seeds file for demo user logins.

After logging in, click the 'Check for new concerts' button on the Concerts Index to pull concert data from the Bandsintown API.

## Notes

A Spotify account is required to login to and use the live website.
Because Spotify considers the app to still be in development mode, currently only 25 Spotify users can login and use the app. These users must be explicitly added in the Spotify dashboard before they can authenticate with the app. If you’d like to access the live website, please let us know!

Access to the Bandsintown API was granted under a student license and will only be availble until December 15th 2022.

## Authors

👤 **Ben Schembri** [@benschem](https://github.com/benschem)

👤 **Micah Kim** [@lavithian](https://github.com/lavithian)

👤 **Tae Lee** [@taeleenz38](https://github.com/taeleenz38)

👤 **Chloe Farrell** [@chloefarrell](https://github.com/chloefarrell)

## Show your support

Give a ⭐️ if you liked this project!
