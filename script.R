title: dd
author: ''
date: '2021-10-07'
library(usethis)
library(blogdown)
library(devtools)

#hugo and theme install

blogdown::install_hugo()
blogdown::new_site(theme="theNewDynamic/gohugo-theme-ananke")

#stopped server so that I could then work on building site
blogdown::stop_server()

#did stuff in shell..committed files to github, then signed up
#through netlify

#note: netlify updates through git

#amended baseurl to netlify.app and then committed and pushed

#pictures were not showing, after amended base url I also
#update theme with the following link "github.com/theNewDynamic/gohugo-theme-ananke"
#changed theme to "ananke" the folder already in my themes folder 