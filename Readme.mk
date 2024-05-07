# 크롤링 코드
```python
from bs4 import BeautifulSoup
import requests
try:
    response = requests.get("https://kormedi.com/healthnews/")
    html = response.text
    soup = BeautifulSoup(html, "html.parser")
    div = soup.find('div', attrs={'class': 'listing'})

    headlines_summary = div.find_all('div', attrs={'class': 'post-summary'})
    headlines = div.find_all('div', attrs={'class': 'article_thumbnail'})

    title_list = []
    summary_list = []
    url_list = []
    img_list = []

    for summary in headlines_summary:
        summary_list.append(summary.text.strip())


    for headline in headlines:
        title_list.append(headline.find('a')['title'])

        url_list.append(headline.find('a')['href'])

        img = headline.find('a')['data-bg']
        img = img.rstrip('.webp')
        img = img.lstrip('https://cdn.kormedi.com')

        img_list.append('https://cdn.kormedi.com/' + img)

    news_list = []

    for title, summary, img, url in zip(title_list, summary_list, img_list, url_list):
        news_dict = {'title': title,
                    'summary': summary,
                    'img': img,
                    'url': url}
        news_list.append(news_dict)
except:
    print('실패')

print(news_list)
```
