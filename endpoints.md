# Endpoints

## Dogs

#### `GET /api/v1/`
- 20 per page
##### Optional Query Params:
- `page={integer}`

 ```json
 {
  "data": [
    {
      "id": "1",
      "type": "dog",
      "attributes": {
        "name": "Zoey",
        "size": "small",
        "age": 7,
        "breed": "Appenzeller",
        "vaccinated": "false",
        "sex": "Male",
        "trained": "yes",
        "user_id": 2,
        "description": "blep"
      }
    },
    {
      "id": "2",
      "type": "dog",
      "attributes": {
        "name": "Charlie",
        "size": "small",
        "age": 25,
        "breed": "Labrador",
        "vaccinated": "true",
        "sex": "Female",
        "trained": "no",
        "user_id": 2,
        "description": "11/10"
      }
    }
  ]
}
 ```

#### `GET /api/v1/user_dogs`
##### Requried Query Params:
 - `user_id={integer}`
```json
 {
  "data": [
    {
      "id": "5",
      "type": "dog",
      "attributes": {
        "name": "Duke",
        "size": "large",
        "age": 25,
        "breed": "Dachshund",
        "vaccinated": "true",
        "sex": "Male",
        "trained": "no",
        "user_id": 1,
        "description": "thicc doggo"
      }
    },
    {
      "id": "13",
      "type": "dog",
      "attributes": {
        "name": "Annie",
        "size": "medium",
        "age": 1,
        "breed": "English Setter",
        "vaccinated": "true",
        "sex": "Female",
        "trained": "no",
        "user_id": 1,
        "description": "long boi"
      }
    }
  ]
}
```

#### `POST /api/v1/dogs`
##### Required Body Content:
```json
{
  "user_id": "{integer}",
  "size": "{small, medium, large}",
  "breed": "{string}",
  "age": "{integer}",
  "sex": "{string}",
  "description": "{string}",
  "vaccinated": "{true, false}",
  "trained": "{yes, no}"
}
```

#### `GET /api/v1/dogs/:id`
```json
{
  "data": {
    "id": "1",
    "type": "dog_with_playdates",
    "attributes": {
      "name": "Zoey",
      "size": "small",
      "age": 7,
      "breed": "Appenzeller",
      "vaccinated": "false",
      "sex": "Male",
      "trained": "yes",
      "user_id": 2,
      "description": "blep",
      "accepted_play_dates": [],
      "pending_play_dates": []
    }
  }
}
```
## Play Dates

#### `GET /api/v1/play_dates`
##### Required Query Parameters:
- `user_id={integer}`
```json
{
  "data": [
    {
      "id": "4",
      "type": "play_date",
      "attributes": {
        "location_id": "MWFGHr6NOg7pAoLgbgFdsQ",
        "date": "2021-11-11",
        "time": "2000-01-01T13:36:00.000Z",
        "invite_status": "pending"
      },
      "relationships": {
        "creator_dog": {
          "data": {
            "id": "5",
            "type": "dog"
          }
        },
        "invited_dog": {
          "data": {
            "id": "1",
            "type": "dog"
          }
        }
      }
    }
  ]
}
```

#### `POST /api/v1/play_dates`
##### Required Body Content:
```json
{
  "object": {
    "date": "{year-month-day}",
    "time": "{hour-minute-timezone}",
    "invited_dog_id": "{integer}",
    "creator_dog_id": "{integer}",
    "location_id": "{string}"
  }
}
```

#### `GET /api/v1/play_date/:id`
```json
{
  "data": {
    "id": "4",
    "type": "play_date",
    "attributes": {
      "location_id": "MWFGHr6NOg7pAoLgbgFdsQ",
      "date": "2021-11-11",
      "time": "2000-01-01T13:36:00.000Z",
      "invite_status": "accepted"
    },
    "relationships": {
      "creator_dog": {
        "data": {
          "id": "5",
          "type": "dog"
        }
      },
      "invited_dog": {
        "data": {
          "id": "1",
          "type": "dog"
        }
      }
    }
  }
}
```

#### `PATCH /api/v1/play_date/:id`
##### Required Body Content:
```json
{
  "status": "{accepted, rejected}"
}
```

## Yelp Locations

#### `GET /api/v1/yelp_locations`
#### Required Query Params:
- `location={string}`
  - City name or zip code
```json
{
  "data": [
    {
      "id": "No2VmMM6QchZSYtCk6k0vQ",
      "name": "DP Dough",
      "address": "1228 E Colfax Ave, Denver, CO 80218",
      "phone": "(303) 839-9663",
      "rating": 3.5,
      "categories": [
        "Pizza",
        "Italian"
      ],
      "image_url": "https://s3-media1.fl.yelpcdn.com/bphoto/MBkGfvYy-rTgO8tVuYzdQQ/o.jpg"
    },
    {
      "id": "RTvR4W7K-59xFFZAUTMTbQ",
      "name": "Lucky Noodles",
      "address": "1201 E Colfax Ave, Ste 102, Denver, CO 80218",
      "phone": "(720) 917-1000",
      "rating": 4.5,
      "categories": [
        "Thai",
        "Noodles",
        "Coffee & Tea"
      ],
      "image_url": "https://s3-media4.fl.yelpcdn.com/bphoto/uoXE8rVcYAV4R6njOCxrpw/o.jpg"
    }
  ]
}
```

#### `GET /api/v1/yelp_location`
##### Required Query Params:
- `location_id={string}`
```json
{
  "data": {
    "id": "No2VmMM6QchZSYtCk6k0vQ",
    "name": "DP Dough",
    "address": "1228 E Colfax Ave, Denver, CO 80218",
    "phone": "(303) 839-9663",
    "rating": 3.5,
    "categories": [
      "Pizza",
      "Italian"
    ],
    "image_url": "https://s3-media1.fl.yelpcdn.com/bphoto/MBkGfvYy-rTgO8tVuYzdQQ/o.jpg"
  }
}
```
