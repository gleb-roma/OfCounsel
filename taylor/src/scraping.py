import json
from bs4 import BeautifulSoup

# file= open("row_9980.json")
# data= json.load(file)

def scrape_file(data):
  html= data["html_with_citations"]
  soup= BeautifulSoup(html, 'html.parser')
  # Clean up
  for lexis in soup.find_all("span", attrs={"class": "star-pagination"}):
    if "LEXIS" in lexis.get("pagescheme",""):
      lexis.extract()

  for span_tag in soup.find_all('span', {'normalizedcite': True}):
    span_tag.extract()

  fullcasename=soup.find("div", attrs={"class": "fullcasename"})
  fullcasename= fullcasename.text if fullcasename else ""
  shortcasename= soup.find("div", attrs={"class": "shortcasename"})
  shortcasename= shortcasename.text if shortcasename else ""
  docketnumber= soup.find("div", attrs={"class": "docketnumber"})
  docketnumber= docketnumber.text if docketnumber else ""
  party1= soup.find("div", attrs={"class": "shortcasename"})
  party1= party1.get("party1") if party1 else ""
  party2= soup.find("div", attrs={"class": "shortcasename"})
  party2= party2.get("party2") if party2 else ""
  courtname= soup.find("courtname")
  courtname= courtname.text if courtname else ""
  jurissystem= soup.find("jurissystem")
  jurissystem= jurissystem.attrs if jurissystem else {}
  decisionDates= soup.find("span", attrs={"name": "decisiondates"})
  if decisionDates:
    decisionDates= decisionDates.find().attrs
    decisionDates["datetext"]= soup.find("span", attrs={"name": "decisiondates"}).find().find().text
  else:
    decisionDates= {}
  citeforthisresource=soup.find("span", attrs={'class': "citeforthisresource"})
  citeforthisresource= citeforthisresource.find().text if citeforthisresource else ""
  citations=[]
  for cite in soup.find_all("span", attrs={"name": "citation"}):
    citations.append({"id": cite.get('id'), "refrencedCaseName": cite.text.replace('">', "")})
  
  courtsummary= soup.find('div', attrs={"class": "courtsummary"})
  courcites= []
  if courtsummary:
    for citation_span in courtsummary.find_all('span', {'name': "citation"}):
      id= citation_span.get('id')
      citation= citation_span.text.replace('">', "")
      html= str(citation_span)
      courcites.append({"ID":id, "citation": citation, "html": html})
    courtsummary= courtsummary.get_text(strip=True)
  else:
    courtsummary=""
  

  pages= [{
    "section": "Court Summary",
    "paragraphs": [
      {
        "paragraph_text": courtsummary,
        "citations": courcites
      }
    ],
    "footnotes": []
  }]
  paragraphs= soup.find('bodytext')
  if paragraphs:
    for paragraph_tag in paragraphs.find_all("p"):
      paginations=  paragraph_tag.find_all("span", attrs= {"class": "star-pagination"})
      for pagination in paginations:
        pagination.extract()
        # if "LEXIS" not in pagination.get("pagescheme"):
        #   pass
      if paragraph_tag.get_text(strip=True).isupper():
        pages.append({
          "Section": paragraph_tag.get_text(strip=True),
          "paragraphs": [],
          "footnotes": []
        })
      para_cites=[]
      for para_cite in paragraph_tag.find_all("span", attrs={"name": "citation"}):
        id= para_cite.get('id')
        citation= para_cite.get_text().replace('">', "")
        html= str(para_cite).replace("\"&gt;", "")
        para_cites.append({"ID":id, "citation": citation, "html": html})
      footnote_ref= paragraph_tag.find("a")
      if footnote_ref:
        footnote_id= footnote_ref.get("href")
        footnote= soup.find("div", attrs={"id": footnote_id[1:]})
        if footnote:
          footnote_para_ref= footnote.find("a")
          if footnote_para_ref:
            footnote_para_ref.extract()
          footnote_text= footnote.get_text()
          pages[len(pages)-1]["footnotes"].append({"text": footnote_text})
      pages[len(pages)-1]["paragraphs"].append({"paragraph_text":paragraph_tag.get_text(strip=True), "citations": para_cites})


  output_json= {
    "fullcasename": fullcasename,
    "shortcasename": shortcasename,
    "docketnumber": docketnumber,
    "parties": {
      "party1": party1,
      "party2": party2
    },
    "courtInfo": {
      "courtname": courtname,
      "jurisdiction": {
        "jurissystem": jurissystem
      }
    },
    "decisionDates": decisionDates,
    "citeforthisresource": citeforthisresource,
    "citations":citations,
    "caseContent": {
      "paginationscheme": citeforthisresource,
      "pages": pages
    }
  }
  return output_json