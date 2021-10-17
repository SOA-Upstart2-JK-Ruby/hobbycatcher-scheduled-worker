# Facebook API Client

Gather useful information from Facebook pages API (v12.0).

## Resources

- PageInfo
- Review
- Post

## Elements

- PageInfo
  - id
  - name
  - category
  - profile (picture url)
  - followers
  - rating
  - website
  - location
  - about
  - list of reviews
  - list of posts
- Review
  - review_date
  - sentiment (positive/negative)
  - comment
- Post
  - post_id
  - post_date
  - content

## Entities
These are objects that are important to the project, following my own naming conventions:

Format: "own naming" ("fb objects naming")

- PageInfo
  - profile ('picture')
  - followers ('followers_count')
  - rating ('overall_star_rating')
  - about ('about' & 'description')
  - list of reviews ('ratings')
- Review
  - review_date ('created_time')
  - sentiment ('recommendation_type')
  - comment ('review_text')
- Post
  - post_id ('id')
  - post_date ('date')
  - content ('message')
