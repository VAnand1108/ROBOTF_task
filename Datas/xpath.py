amazon_title = '//a[@id="nav-logo-sprites"]'
searchbar= '//input[@id="twotabsearchtextbox"]'
# //span[text()=" mobile under 10000"]
mobile_search = '//div[@aria-label="5g mobile under 10000"]'


product_name = '//span[@class="a-size-medium a-color-base a-text-normal"]'
product_price = '//span[@class="a-price"]'

# no_of_phone = "//div[@data-cy='asin-faceout-container']"


phone_name_dynamic=   "(//div[@data-cy='title-recipe']//span[@class='a-size-medium a-color-base a-text-normal'])[{count}]"
phone_price_dynamic=    "(//span[@class='a-price']/span[@class='a-offscreen'])[{count}]"
phone_card =   "//div[@data-cy='asin-faceout-container']"
phone_card_dynamic ="(//div[@data-cy='asin-faceout-container'])[{count}]"




sort_by ="//span[@id='a-autoid-0-announce']"
high_to_low=    "//a[@id='s-result-sort-select_2']"
phone_name = ' (//div[@class="sg-col-20-of-24 s-result-item s-asin sg-col-0-of-12 sg-col-16-of-20 sg-col s-widget-spacing-small sg-col-12-of-16"]//h2//span)[{count}]'
phone_price =  "(//span[@class='a-price']/span[@class='a-offscreen'])[{count}]"
search_div =    "//div[@id='CardInstanceseioFRRb27Fj3Su1p16oSA']"
 



browser_url =   "https://www.browserstack.com/"
pricing_menu=    "//span[contains(text(),'Pricing')]//parent::a//parent::div"
team_tab  =  '(//div[@data-plan-name="live-team"])[2]/a'
user_dropdown  =  '(//div[contains(@class,"plans-switch-toggle")]//div//ul[@role="listbox" and @tabindex="-1"])[1]/li' 
user_dropdown_list_template = '(//div[@class="col-sm-6 col-md-4 col-lg-4 plans-switch-toggle"]//div//ul[@role="listbox" and @tabindex="-1"])[1]/li[{user_num}]'
price_text =   '(//div[@class="col-sm-6 col-md-4 col-lg-4 plans-switch-toggle"]//span[@class="amount"])[1]'
# @{users_list}    5    10    25    50  # Example list of user counts to check



attribite_name_xpath = "(//div[@class='_cDEzb_p13n-sc-css-line-clamp-3_g3dy1'] )[{count}]"
attribite_price_xpath ="//div[contains(text(),'{name}')]/parent::span/parent::a/parent::div//div[@class='a-row']//a[@role='link']"

mobile_label ="//div[@id='nav-xshop']//a[contains(@class,'')][normalize-space()='Mobiles']"
scroll_to_down = "//span[@id='DEAL_B09794YHBS-label']"

best_seller = "//span[@id='B09794YHBS-best-seller-label']"
page_title ="//img[@alt='Electronics']"


over_all_count = '//div[@class="zg-grid-general-faceout"]'

scroll_down ="//a[normalize-space()='2']"
page2 = "//ul[@class='a-pagination']//li/a[contains(text(),'2')]"
scroll_down2 ="//a[normalize-space()='2']"

second_page_cnt = '//div[@class="zg-grid-general-faceout"]'