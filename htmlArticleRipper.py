#!/usr/bin/env python3

""""
Rips the first <article> tag out of an html file.
Used to read articles from saved html pages on a Kindle.
"""

import sys
from pathlib import Path
from bs4 import BeautifulSoup

if __name__ == '__main__':
  #Get filename
  infilename = sys.argv[1]
  
  if not Path(infilename).is_file():
    exit(1) 

  #Get contents
  infile = open(infilename, 'r')
  html_doc = infile.read()
  infile.close()

  soup = BeautifulSoup(html_doc, 'html.parser')

  #Add elements to new soup
  newsoup = BeautifulSoup("<html></html>", 'html.parser')

  #Add Title
  newsoup.html.append(newsoup.new_tag("head"))
  #TODO: Modify title
  newsoup.head.append(soup.title)

  # #Add Styles
  # stylelinks = soup.find_all('link')
  # print(len(stylelinks))
  # for element in stylelinks:
  #   if element.get('id') is not None and element.get('id').startswith('twentythirteen'):
  #     print(element.get('id'))
  #     newsoup.head.append(element)

  #Edit Article
  newsoup.html.append(newsoup.new_tag("body"))
  the_article = soup.article

  #Removing undesirables
  try:
    the_article.find('div', { "class" : "twitter-share" } ).decompose()
  except Exception as e:
    pass #It is not there
  
  try:
    the_article.find('p', { "class" : "bawpvc-ajax-counter" } ).decompose()
  except Exception as e:
    pass #It is not there
  
  try:
    the_article.find('footer').decompose()
  except Exception as e:
    pass #It is not there 
  
  try:
    the_article.find('div', { "class" : "entry-meta" }).decompose()
  except Exception as e:
    pass #It is not there  
  
  #Add new article
  newsoup.body.append(the_article)

  #Prepare output file
  # outfile = open("out.html", 'w')
  outfile = open(infilename, 'w')
  outfile.write(str(newsoup))
  outfile.close()

  # print(newsoup.prettify())