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
    IN_FILENAME = sys.argv[1]
    print("Ripping file: "+IN_FILENAME)

    if not Path(IN_FILENAME).is_file():
        print(IN_FILENAME+" is not a file.")
        exit(1)

    #Get contents
    IN_FILE = open(IN_FILENAME, 'r')
    HTML_DOC = IN_FILE.read()
    IN_FILE.close()

    SOUP = BeautifulSoup(HTML_DOC, 'html.parser')

    #Add elements to new soup
    NEWSOUP = BeautifulSoup("<html></html>", 'html.parser')

    #Add Title
    NEWSOUP.html.append(NEWSOUP.new_tag("head"))
    try:
        NEWSOUP.head.append(SOUP.title)
    except ValueError as identifier:
        NEWSOUP.head.append(NEWSOUP.new_tag("title"))
        NEWSOUP.head.title.append(IN_FILENAME)

    #Add new article
    NEWSOUP.html.append(NEWSOUP.new_tag("body"))
    try:
        NEWSOUP.body.append(SOUP.article)
    except ValueError as identifier:
        print("No article tag found, abrting.")
        exit(1)

    #Prepare output file
    OUT_FILE = open(IN_FILENAME, 'w')
    OUT_FILE.write(str(NEWSOUP))
    OUT_FILE.close()

    # print(NEWSOUP.prettify())
    print("Done.")
