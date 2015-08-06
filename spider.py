#!/usr/bin/env python3

from bs4 import BeautifulSoup
import urllib.request
import csv

def fetch():
    url = "http://botzone.org" 
    while True:
        try:
            soup = BeautifulSoup(urllib.request.urlopen(url, timeout=5), "html.parser")
            break
        except:
            print('R')
    table = soup.find_all('table', class_="table table-hover table-striped")[1]
    for tr in table.find_all('tr')[1:]:
        tds = tr.find_all('td')
        dom_scores = tr.find_all('div', class_='score pull-right')
        dom_users = tr.find_all('a', class_='smallusername')
        dom_bots = tr.find_all('a', class_='botname nonpublic')
        print(dom_scores)
        print(dom_users)
        print(dom_bots)

        time = tds[0].string.strip()
        game = tds[0].string.strip()
        bot0 = dom_bots[0].string.strip()
        bot1 = dom_bots[1].string.strip()
        score0 = int(dom_scores[0].string.strip())
        score1 = int(dom_scores[1].string.strip())
        
        print(time, game, bot0, bot1, score0, score1)

    #count = 0
    #print('%s: ' % output, end='')
    #with open(output, 'w') as csvfile:
    #    writer = csv.writer(csvfile)
    #    for tr in soup.find('table', id='YKTabCon2_10').find_all('tr')[1:]:
    #        try:
    #            tds = tr.find_all('td')
    #            name = tds[0].string.strip()
    #            gender = tds[1].string.strip()
    #            province = tds[2].string.strip()
    #            writer.writerow([name, gender, province])
    #            count += 1
    #        except:
    #            print('tds', tds, end='')
    #print(count)

fetch()