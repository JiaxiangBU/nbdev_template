library(tidyverse)
library(fs)
if (!dir.exists("code"))
    dir.create("code")
df <- fs::dir_info("../dev_history/refs") %>% select(path) %>%
    filter(
        path %>% str_detect("Makefile") | path %>% str_detect("\\.R$") |
            path %>% str_detect("commit")
    ) %>%
    filter(path %>% basename() %>% str_detect("dev|mutiple|public", negate = TRUE))

for (i in df$path) {
    print(i)
    if (str_detect(i, "commit.Rmd")) {
        file_copy(i, ".", overwrite = TRUE)
    } else if (str_detect(i, "Makefile")) {
        file_copy(i, ".", overwrite = TRUE)
    } else {
        file_copy(i, "code/", overwrite = TRUE)
    }
}
git2r::add(path = "code")
git2r::add(path = "Makefile")
git2r::add(path = "commit.Rmd")
git2r::commit(message = 'add Makefile family')
