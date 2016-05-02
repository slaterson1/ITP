# Insidethepark API
	
	Welcome to Insidethepark, where you can plan the baseball roadtrip of a lifetime!

## General Info

### Authorization

 All authorized requests unless otherwise mentioned require
 an "**Auth-Token**" header to be present. Users are assigned an
 Auth Token during account creation.

### Errors

 Any request that fails to be processed will contain an "errors"
 key in the returned JSON describing the problem.

## Routes

#### POST /signup

  This creates a new user
  Params:
    * first: string
    * last: string
    * email: string
    * password: string

  Returns 201 Created on Success and 422 Unprocessable Entity in case fof failure.

  **Request:**

  ```
  {
     "email": "bob@email.com"
     "password": "password"
  }
  ```

  **Response:**

  ```
  {
    "user": {
     "email": "bob@email.com",
       "auth_token": "7774743beeb3c26dfdd80213ba1b9097"
    }
  }
  ```
#### POST /login

  This logs in your user
   Params:
   	* email: string
   	* password: string

   	* header: Auth-Token

   Returns 200 OK on Success and 401 Unauthorized if no user found or incorrect user data.

   **Request:**

   ```
   {
   	"username": "bob@email.com"
      "password": "password"
   }
   ```

   **Response:**

   ```
   {
     "user": {
      "username": "bob@email.com",
        "auth_token": "7774743beeb3c26dfdd80213ba1b9097"
     }
   }
   
   ```
#### POST /firstgamedata

	This retrieves all home game data for the date requested
	 Params:
	  * local_datetime: string

	Returns 200 OK on Success and 422 Unprocessable Entity if params missing or incorrect.
	
	**Request**

	``` 
	{
	 "local_datetime": "02/21/2016"
	}
	```

	**Response**

	```
	{
	events: [
	{	links: [ ],
		id: 2932648,
		stats: {
				listing_count: 243,
				average_price: 9,
				lowest_price_good_deals: 4,
				lowest_price: 4,
				highest_price: 58
			},
			title: "San Diego Padres at San Francisco Giants",
			announce_date: "2015-11-17T00:00:00",
			score: 0.805671,
			date_tbd: false,
			type: "mlb",
			datetime_local: "2016-04-27T12:45:00",
			visible_until_utc: "2016-04-27T23:45:00",
			time_tbd: false,
			taxonomies: [
				{
					parent_id: null,
					id: 1000000,
					name: "sports"
				},
				{
					parent_id: 1000000,
					id: 1010000,
					name: "baseball"
				},
				{
					parent_id: 1010000,
					id: 1010100,
					name: "mlb"
				}
			],
		performers: [
			{
				image: "https://chairnerd.global.ssl.fastly.net/images/performers-landscape/san-francisco-giants-233640/22/huge.jpg",
				primary: true,
				images: {
					huge: "https://chairnerd.global.ssl.fastly.net/images/performers-landscape/san-francisco-giants-233640/22/huge.jpg"
			},
			has_upcoming_events: true,
			id: 22,
			stats: {
				event_count: 140
			},
			score: 0.798777,
			taxonomies: [
				{
					parent_id: null,
					id: 1000000,
					name: "sports"
				},
				{
					parent_id: 1000000,
					id: 1010000,
					name: "baseball"
				},
				{
					parent_id: 1010000,
					id: 1010100,
					name: "mlb"
				}
			],
			type: "mlb",
			short_name: "Giants",
			home_venue_id: 22,
			slug: "san-francisco-giants",
			divisions: [
				{
					display_name: "National League",
					short_name: null,
					division_level: 1,
					display_type: "League",
					taxonomy_id: 1010100,
					slug: null
				},
				{
					display_name: "National League West",
					short_name: "NL West",
					division_level: 2,
					display_type: "Division",
					taxonomy_id: 1010100,
					slug: "national-league-west"
				}
			],
			home_team: true,
			name: "San Francisco Giants",
			url: "https://seatgeek.com/san-francisco-giants-tickets"
		},
		{
			away_team: true,
			stats: {
			event_count: 141
		},
		name: "San Diego Padres",
		short_name: "Padres",
		divisions: [
			{
				display_name: "National League",
				short_name: null,
				division_level: 1,
				display_type: "League",
				taxonomy_id: 1010100,
				slug: null
			},
			{
				display_name: "National League West",
				short_name: "NL West",
				division_level: 2,
				display_type: "Division",
				taxonomy_id: 1010100,
				slug: "national-league-west"
			}
		],
		url: "https://seatgeek.com/san-diego-padres-tickets",
		type: "mlb",
		image: "https://chairnerd.global.ssl.fastly.net/images/performers-landscape/san-diego-padres-df46d4/24/huge.jpg",
		home_venue_id: 24,
		slug: "san-diego-padres",
		score: 0.65535,
		images: {
			huge: "https://chairnerd.global.ssl.fastly.net/images/performers-landscape/san-diego-padres-df46d4/24/huge.jpg"
		},
		taxonomies: [
			{
				parent_id: null,
				id: 1000000,
				name: "sports"
			},
			{
				parent_id: 1000000,
				id: 1010000,
				name: "baseball"
			},
			{
				parent_id: 1010000,
				id: 1010100,
				name: "mlb"
			}
		],
		has_upcoming_events: true,
		id: 24
	}
],
url: "https://seatgeek.com/padres-at-giants-tickets/4-27-2016-san-francisco-california-at-t-park/mlb/2932648",
created_at: "2015-11-17T00:00:00",
venue: {
	city: "San Francisco",
	name: "AT&T Park",
	extended_address: "San Francisco, CA 94107",
	url: "https://seatgeek.com/venues/at-t-park/tickets",
	country: "US",
	display_location: "San Francisco, CA",
	links: [ ],
	slug: "at-t-park",
	state: "CA",
	score: 0.92324,
	postal_code: "94107",
	location: {
		lat: 37.7784,
		lon: -122.391
	},
	address: "24 Willie Mays Plaza",
	timezone: "America/Los_Angeles",
	id: 22
},
short_title: "Padres at Giants",
datetime_utc: "2016-04-27T19:45:00",
datetime_tbd: false
}
	}
	```