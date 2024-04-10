# Platform BE
 Welcome to Platform BE! 

### Purpose 
 Platform consolidates content from your favorite creators into one easily accessible “platform”, simplifying how users discover and engage with their favorite content and creators without having to navigate multiple sites.

### Description
This back-end repository powers Platform's front-end application, integrating YouTube and Twitch APIs and scraping Twitter to aggregate content from your favorite creators seamlessly. The relevant video data and additional content is compiled and sent off to the FE using the endpoints specified below. 

### Current Versions
  Platform BE is currently on `V1` and is meant to be used in tandem with [Platform's FE](https://github.com/2310-social-media-aggregator/frontend)

### Tech Stack
  Platform BE is built on `Ruby 3.2.2` and `Rails 7.1.3.2`
  Some notable gems and additions:
  - [Farady (2.9.0)](https://lostisland.github.io/faraday/#/) for external API consumption with Rails
  - [OpenTelemetry](https://www.honeycomb.io/) via `Honeycomb` for response time and error observability 
  - [Simplecov](https://github.com/simplecov-ruby/simplecov) for testing coverage visibility
  - [CORS](https://github.com/cyu/rack-cors) for easy connection with Platform's typescript FE
  - [JSON API serializer](https://github.com/jsonapi-serializer/jsonapi-serializer) for convenient serialization of endpoint data into standard JSON formatting
  - [Open3](https://github.com/ruby/open3) for use with Twitter web scraping
  - Platform uses Rails built in [caching functionality](https://guides.rubyonrails.org/caching_with_rails.html) to cache content up to an hour for faster response times

## Steps to Install Platform BE
  1. Clone `Platform BE` down to your local server. 
  ```
    git clone git@github.com:2310-social-media-aggregator/backend.git
  ```
  2. Cd into the newly created directory `/backend`

  3. To create and migrate Platform's BE database, run:
  ```
    rails db:{create,migrate}
  ``` 
  4. To ensure all gems are installed and up to date, from the command line run:
  ```
    bundle install
  ```

### Test Coverage
   - to view test coverage using the `simplecov` gem, run the full test suite `bundle exec rspec` from the root directory. Then run `open coverage/index.html` in the command line

### Challenges
- *Consumption of Twitter's API*. Twitter's API service has recently become harder to utilize and is quite costly. To solve this problem, we decided to implement web scraping to retrieve tweets from content creators.
- *Slow response times for large data sets*. We deployed an observability tool, Honeycomb, to expose our most significant performance bottlenecks. With that information, we implemented caching using Rails built in storage and caching tools, reducing response times by 95%.

### Contributors
- Dylan Perry: [GitHub](https://github.com/dylan-perry), [LinkedIn](https://www.linkedin.com/in/dylanperry/)
- Quin Nordmark: [GitHub](https://github.com/n0rdie), [LinkedIn](https://www.linkedin.com/in/quinnordmark/)
- Isaac Mitchell: [GitHub](https://github.com/tmitchellisaac), [LinkedIn](https://www.linkedin.com/in/isaac-mitchell-877272286/)
- Dana Zack: [GitHub](https://github.com/dana-zack), [LinkedIn](https://www.linkedin.com/in/danazack/)
- Edward Gavin Garcia: [GitHub](https://github.com/EGavinG), [LinkedIn](https://www.linkedin.com/in/egavingarcia/)
- Matthew Shindel: [GitHub](https://github.com/MatthewShindel), [LinkedIn](https://www.linkedin.com/in/mshindel/)






# JSON Contract

## User Endpoints

### User Show

GET `/api/v1/users/user_id`

will return: 
(the ID in the `follows` is the `creator_id`)
```
{
  "data": {
    "id": 44,
    "type": "user",
    "attributes": {
      "name": "User Name"
      "follows": [
        {
          "id": 12,
          "name": "Creator Name"
        },
        {
          "id": 13,
          "name": "Creator Name"
        }
      ]
    }
  }
}
```

### Create a User

POST `/users`

with json body:

```
{
  "name": "Thomas the Tank Engine"
}
```

will create a user and return:


```
{
  "data": {
    "id": "2",
    "type": "user",
    "attributes": {
      "name": "Thomas the Tank Engine",
      "follows": []
    }    
  }
}
```

### Delete a User


DELETE `/users/1`

will delete a User resource and return and empty `204` response

## Creator Endpoints


### Creator Show

GET `/api/v1/creators/creator_id`

will return:

```
{
    "data": {
        "id": 12 (null at moment, working on it),
        "type": "creator_aggregation",
        "attributes": {
            "name": "ZFG",
            "youtube_videos": [
                {
                    "id": "v-S-oXltLGY",
                    "image": "https://i.ytimg.com/vi/v-S-oXltLGY/hqdefault.jpg",
                    "publishedAt": "2024-02-27T03:20:10Z",
                    "title": "Majora&#39;s Mask Randomizer - February 19th 2024"
                },
                {
                    "id": "tTlv1GO1jws",
                    "image": "https://i.ytimg.com/vi/tTlv1GO1jws/hqdefault.jpg",
                    "publishedAt": "2024-02-27T03:19:40Z",
                    "title": "Majora&#39;s Mask Randomizer - February 16th 2024"
                },
                {
                    "id": "yiFVunlhK1Y",
                    "image": "https://i.ytimg.com/vi/yiFVunlhK1Y/hqdefault.jpg",
                    "publishedAt": "2024-02-27T03:20:19Z",
                    "title": "Majora&#39;s Mask Randomizer - February 23rd 2024"
                },
                {
                    "id": "ULqw1UW9d_4",
                    "image": "https://i.ytimg.com/vi/ULqw1UW9d_4/hqdefault.jpg",
                    "publishedAt": "2024-02-27T03:20:50Z",
                    "title": "Majora&#39;s Mask 2v1 vs @NinanininVT  and @BatAtVideoGames -  February 24th 2024"
                },
                {
                    "id": "lMn5g_K--GA",
                    "image": "https://i.ytimg.com/vi/lMn5g_K--GA/hqdefault.jpg",
                    "publishedAt": "2024-02-27T03:19:52Z",
                    "title": "Majora&#39;s Mask Randomizer - February 17th 2024"
                }
            ],
            "twitch_videos": [
                {
                    "id": "2100415767",
                    "title": "Majora's Mask Randomizer - No Logic and no starting items",
                    "published_at": "2024-03-24T19:54:27Z",
                    "image": "https://static-cdn.jtvnw.net/cf_vods/d1m7jfoe9zdc1j/250dc318e19581f58b64_zfg1_42444153433_1711310062//thumb/thumb0-%{width}x%{height}.jpg"
                },
                {
                    "id": "2098300556",
                    "title": "Majora's Mask Randomizer - No Logic and no starting items",
                    "published_at": "2024-03-22T19:19:52Z",
                    "image": "https://static-cdn.jtvnw.net/cf_vods/d2nvs31859zcd8/b34fe3a30a896b8ae433_zfg1_43873415179_1711135187//thumb/thumb0-%{width}x%{height}.jpg"
                },
                {
                    "id": "2096513754",
                    "title": "Majora's Mask Randomizer with enemies randomized",
                    "published_at": "2024-03-20T20:18:05Z",
                    "image": "https://static-cdn.jtvnw.net/cf_vods/d2nvs31859zcd8/4ec8f9e58698d909dca5_zfg1_43860356251_1710965880//thumb/thumb0-%{width}x%{height}.jpg"
                },
                {
                    "id": "2094644583",
                    "title": "Majora's Mask Randomizer with everything randomized",
                    "published_at": "2024-03-18T20:00:43Z",
                    "image": "https://static-cdn.jtvnw.net/cf_vods/d2nvs31859zcd8/47bd79407c67f621fa95_zfg1_43846917963_1710792038//thumb/thumb0-%{width}x%{height}.jpg"
                },
                {
                    "id": "2092737221",
                    "title": "Majora's Mask Randomizer with everything randomized",
                    "published_at": "2024-03-16T19:53:15Z",
                    "image": "https://static-cdn.jtvnw.net/cf_vods/d1m7jfoe9zdc1j/31ff66e0be8089e26863_zfg1_50648550989_1710618791//thumb/thumb0-%{width}x%{height}.jpg"
                }
            ]
        }
    }
}
```

### Creator Index


GET `/creators`

will return:

```
{
    "data": {
        "id": null,
        "type": "creator_index",
        "attributes": {
            "creators": [
                {
                    "name": "ZFG",
                    "id": 1
                },
                {
                    "name": "Aztecross",
                    "id": 2
                }
            ]
        }
    }
}
```

### Creators Create

POST `/creators`

with json body of:

```
{ 
  "name": "ZFG"
  "youtube_handle": "UC1qsXgdSxJnQG1wy2Gnvuqw"
  "twitch_handle": "8683614"
}
```

create a `Creator` and return:

```
{
    "data": {
        "id": 12,
        "type": "creator_aggregation",
        "attributes": {
            "name": "ZFG",
            "youtube_videos": [],
            "twitch_videos": []
        }
    }
}
```

### Creators Update

PATCH `/creators`

with json body of:

```
{ 
  "name": "ZFG"
  "youtube_handle": "UC1qsXgdSxJnQG1wy2Gnvuqw"
  "twitch_handle": "updated_handle"
}
```

create a `Creator` and return:

```
{
    "data": {
        "id": 12,
        "type": "creator_aggregation",
        "attributes": {
            "name": "ZFG",
            "youtube_videos": []
            "twitch_videos": []
        }
    }
}
```

### Delete a Creator

DELETE `/creators/1`

will delete the `Creator` resource and return a `204` response code

## Follows Endpoints

### Create a Follows

POST `/api/v1/users/1/follows`


with a json body of:
```
{
  "creator_id": "1"
}
```
will create a follows for that user with the creator_id and return:
```
{
    "success": "Follow added successfully"
}
```
##  we want it to eventually return:
will create a `follows` for the user and will return:

```
{
  "data": {
    "id": "1",
    "type": "follows",
    "attributes": {
      "created_at": "2024-03-23T23:44:54.048822+00:00"
      "creator_name": "Creator Name"
    },
    "relationships": {
      "user": {
        "data": {
          "id": "44",
          "type": "user"
        }
      },
      "creator": {
        "data": {
          "id": "12",
          "type": "creator"
        }
      }
    }
  }
}

```

### Delete a Follows

DELETE `/users/user_id/follows/follow_id`

will delete a `follows` resource and return:


```
{ "success": "follows successfully deleted"}
```





# Non-MVP endpoints (not ready yet)

- edit a user - x
- creator create - x
- creator update - x
- creator delete - x


### Edit a User

PATCH `/users/1`

with json body of:
```
{
  "name": "Gloria Timesnap"
}
```

will update the information and return:

```
{
  "data": {
    "user": {
      "id": 44,
      "name": "Gloria Timesnap",
      "follows": []
    }
  }
}
```
