import os
import re
import json
import requests
import soupselect
from bs4 import BeautifulSoup

soupselect.monkeypatch()

scraper_dir = os.path.dirname(os.path.realpath(__file__))
urls_file = open(scraper_dir + '/urls.txt', 'r')

recipes = []
id_re = re.compile('/recipes/(?P<id>[\d]+)/.+')

for url in urls_file:
    url = url.strip()

    r = requests.get(url)
    soup = BeautifulSoup(r.text)

    recipes.append({
        'id': id_re.search(url).group('id'),
        'title': soup.findSelect('h1.article')[0].text.strip(),
        'teaser': soup.findSelect('.recipe-summary .summary')[0].text.strip(),
        'imageUrl': soup.findSelect('.articleImage .photo')[0]['src'],
        'url': url
    })

print(json.dumps(recipes))
