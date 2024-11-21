url = "https://help.yahoo.com/kb/account"
browser = "chrome"
Attribute = "innerText"


manage_acc = '//a[text()="Manage account settings"]'

count  = '//div[@id="help-articles"]/article'
title_name =    '(//div[@id="help-articles"]/article/a/h1)[{index}]'
text  =  '(//div[@id="help-articles"]/article/a/p)[{name}]'
next_page=    "//a[contains(text(),'Next')]"
prev_page =   "//a[contains(text(),'Prev')]"

help_center =  "//a[contains(text(),'Back to Help Central')]"

get_change_in_title  =  "//div[@id='help-articles']/article/a/h1[contains(text(),'Change') or contains(text(),'change')]"
change_in_title_dy =  "(//div[@id='help-articles']/article/a/h1[contains(text(),'Change') or contains(text(),'change')])[{titles}]"


