# Working routes
### Creator Index
- /api/v1/creators

### Creator Show
- /api/v1/creators/***CREATOR_ID***


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