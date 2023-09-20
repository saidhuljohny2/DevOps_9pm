import os 
import sys
from selenium import webdriver  
from selenium.webdriver.common.keys import Keys  
from selenium.webdriver.chrome.options import Options  
from selenium.webdriver.chrome.service import Service

chrome_options = Options()  
chrome_options.add_argument("--headless")  
chrome_options.binary_location = '/usr/bin/google-chrome'

url="http://"+sys.argv[1]+":82/devopsIQ/";
print("Testing Website: "+url)

service = Service(executable_path="/usr/local/bin/chromedriver")
driver = webdriver.Chrome(service=service, options=chrome_options) 

driver.get(url);
expectedTitle = "Cloudtrain Website";
actualTitle = driver.title;
print(actualTitle);
if actualTitle == expectedTitle:
    print("Website Title Expected: "+ expectedTitle);
    print("Website Title Actual: "+ actualTitle);
    print("TEST PASSED!");
else:
    print("Website Title Expected: "+ expectedTitle);
    print("Website Title Actual: "+ actualTitle);
    print("TEST FAILED!");
driver.close()
