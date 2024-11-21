random_mobile =   '//input[@value="{user}"]/parent::div'
# ${user}    redmi
price_xpath_template =   "//div[contains(@class,'rush-component s-featured-result-item')]//span[@class='a-price-whole'][normalize-space()='{}']"
product_count  =  '//div[@data-component-type="s-search-result"]'
product  =  '(//div[@data-component-type="s-search-result"])[{counts}]'
# ${Attribute}    innerText
product_tab=    '(//div[@data-component-type="s-search-result"]//h2[@class="a-size-mini a-spacing-none a-color-base s-line-clamp-2"]/a)[{link}]'
mobile_name =  " //span[@id='productTitle']"
mobile_title2 =   '//h1[@id="title"]'
mobile_price =   ' (//div[@data-component-type="s-search-result"]//span[@class="a-price-whole"])[{counts}]'
# ${commas}    ,
product_disc =   '//div[@id="corePriceDisplay_desktop_feature_div"]//span[@class="a-size-large a-color-price savingPriceOverride aok-align-center reinventPriceSavingsPercentageMargin savingsPercentage"]'
emi =   '//div[@id="inemi_feature_div"]//span[2]'

