#backend stuff

## Preparation

### Seeds tasks
- csv:dump

## Controllers

### Task
  Name |Routes       | Descriptions              | Cached
  ---: |---:         | :-----                    | :---:
  list |`/task/list` | All tasks' ids with names | O
  show |`/task/[:id]`| Show task data by given id| O
  sweep |`/task/sweep`| Clear task cached by #show | -
- `Session`
- `User`

### Cache schema
- TODO

### Session ref
- http://www.soryy.com/blog/2014/apis-with-devise/
- https://gist.github.com/danielgatis/5666941
- http://billpatrianakos.me/blog/2013/10/14/api-sessions-with-redis-in-rails/
- http://lucatironi.github.io/tutorial/2012/10/15/ruby_rails_android_app_authentication_devise_tutorial_part_one/
- https://gist.github.com/josevalim/fb706b1e933ef01e4fb6
- https://gist.github.com/jwo/1255275
- http://jimmyislive.tumblr.com/post/80440738483/architecture-of-a-single-page-app-with-a-rest-api

### APi ref
- http://collectiveidea.com/blog/archives/2013/06/13/building-awesome-rails-apis-part-1/
- http://www.amberbit.com/blog/2014/2/19/building-and-documenting-api-in-rails/
- http://codedecoder.wordpress.com/2013/02/21/sample-rest-api-example-in-rails/ 

- test
  - http://matthewlehner.net/rails-api-testing-guidelines/
