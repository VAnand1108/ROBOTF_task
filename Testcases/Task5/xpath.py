
deals_section =   "//span[@class='a-truncate-cut'][normalize-space()='Blockbuster deals with exchange']"
products  =  '//div[@class="a-section dcl-product-detail"]'
discount_amount_xpath = "(//div[@class='a-section dcl-product-detail']//span[contains(text(),'% off')])[{index}]"
discount_new_path  =  "//div[@class='a-section dcl-product-detail']//span[text()='{text}% off']/ancestor::div[@class='a-section dcl-product-detail']"
price_xpath   = '({deals_section}//span[@class="a-price-whole"])[{index}]'
product_title_xpath  = "//span[@id='productTitle']"
product_price =  "//div[@id='corePriceDisplay_desktop_feature_div']//span[@class='a-price-whole']"
new_discount_path =    "//div[@id='corePriceDisplay_desktop_feature_div']//span[contains(text(),'%')]"

# n = "//div[contains(@class,'a-section dcl-product-detail')]//span[text()='{text}% off']/ancestor::div[@class='a-section dcl-product-detail']"