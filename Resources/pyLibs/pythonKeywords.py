import uuid
import random
import json
import os
from datetime import datetime
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.firefox import GeckoDriverManager
from webdriver_manager.microsoft import EdgeChromiumDriverManager
from webdriver_manager.opera import OperaDriverManager


def get_driver_path(browser='chrome'):
    os.environ['WDM_LOCAL'] = '1'  # Use local cache directory
    if browser.lower() == "chrome":
        driver_path = ChromeDriverManager().install()
    elif browser.lower() == "firefox":
        driver_path = GeckoDriverManager().install()
    elif browser.lower() == "edge":
        driver_path = EdgeChromiumDriverManager().install()
    elif browser.lower() == "opera":
        driver_path = OperaDriverManager().install()
    else:
        raise ValueError(f"Unsupported browser: {browser}")

    print(f"{browser.capitalize()} driver path: {driver_path}")
    return driver_path

def launch_firefox_browser():
    driver_path = get_driver_path('firefox')
    driver = webdriver.Firefox(executable_path=driver_path)
    return driver

def generateGuid():
    guid = uuid.uuid4()
    return str(guid)

def randomPhnNumber():
    phnNumber = random.randint(1000000000, 9999999999)
    return phnNumber

def gettime_utcticks():
    return str(int(datetime.datetime.now(tz=pytz.utc).timestamp() * 1000))

def generateEmail():
    return "specflow" + gettime_utcticks() + "@test.com"

def read_request_payload(filepathName):
    file = open(filepathName, 'r')
    jsonfile = file.read()
    json_content = json.loads(jsonfile)
    return json_content

def executeDBQuery(DBHost, DBUser, DBPass, DBName, sqlQuery):
    conn = pymssql.connect(DBHost, DBUser, DBPass, DBName)
    cursor = conn.cursor()
    print("Connected to {} Database".format(DBName))
    cursor.execute(sqlQuery)
    data = []
    for row in cursor:
        data.append(row[0])
        print(row[0])
    return data
    conn.close()
    print("Disconnected {} Database".format(DBName))
