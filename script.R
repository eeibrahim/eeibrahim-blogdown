library(usethis)
library(blogdown)
library(devtools)

#hugo and theme install

blogdown::install_hugo()
blogdown::new_site(theme="theNewDynamic/gohugo-theme-ananke")

#stopped server so that I could then work on building site
blogdown::stop_server()
