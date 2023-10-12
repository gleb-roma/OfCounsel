## Create postgres db from CL schema
sh```
sudo -u postgres createuser django
sudo -u postgres createdb courtlistener
sudo -u  schema-2023-07-31.sql
```

## Provide privileges to user
In psql (`sudo -u postgres psql`):
sh```
grant all privileges on database courtlistener to taylor;
```

## Import opinions data
In psql (`sudo -u postgres psql`):
```
COPY public.search_opinion (id, date_created, date_modified, author_str, per_curiam, joined_by_str,
	       type, sha1, page_count, download_url, local_path, plain_text, html,
	       html_lawbox, html_columbia, html_anon_2020, xml_harvard,
	       html_with_citations, extracted_by_ocr, author_id, cluster_id) FROM '/home/taylor/Projects/ofcounsel/research-copilot/data/opinions-2023-07-31.csv' WITH (FORMAT csv, ENCODING utf8, header);
```


```
alter user taylor createdb; 
```
then create the db with own user with file access then

```
\copy public.search_opinion FROM '/home/taylor/Projects/ofcounsel/research-copilot/data/opinions-2023-07-31.csv' with (FORMAT csv, ENCODING utf8, header, FORCE_NOT_NULL (*));
```


```
\copy public.search_opinion (id, date_created, date_modified, author_str, per_curiam, joined_by_str,
	       type, sha1, page_count, download_url, local_path, plain_text, html,
	       html_lawbox, html_columbia, html_anon_2020, xml_harvard,
	       html_with_citations, extracted_by_ocr, author_id, cluster_id) FROM '/home/taylor/Projects/ofcounsel/research-copilot/data/opinions-2023-08-31.csv' WITH (FORMAT csv, ENCODING utf8, header);
```

12/31/22: (same)
```
\copy public.search_opinion (
	       id, date_created, date_modified, author_str, per_curiam, joined_by_str,
	       type, sha1, page_count, download_url, local_path, plain_text, html,
	       html_lawbox, html_columbia, html_anon_2020, xml_harvard,
	       html_with_citations, extracted_by_ocr, author_id, cluster_id
	   ) FROM '/home/taylor/Projects/ofcounsel/research-copilot/data/opinions-2022-12-31.csv' WITH (FORMAT csv, ENCODING utf8, HEADER);
```

errored earlier:
```
courtlistener-# \copy public.search_opinion (
               id, date_created, date_modified, author_str, per_curiam, joined_by_str,
               type, sha1, page_count, download_url, local_path, plain_text, html,
               html_lawbox, html_columbia, html_anon_2020, xml_harvard,
               html_with_citations, extracted_by_ocr, author_id, cluster_id
           ) FROM '/home/taylor/Projects/ofcounsel/research-copilot/data/opinions-2022-12-31.csv' WITH (FORMAT csv, ENCODING utf8, HEADER);
ERROR:  unterminated CSV quoted field
CONTEXT:  COPY search_opinion, line 15509795: "4544092,2020-06-25 17:13:53.973335+00,2022-03-09 10:53:56.197499+00,"",f,"",010combined,7f7afce897da..."
```

(?<=")"|"{(?=")


partial
```
\copy public.search_opinion (id, date_created, date_modified, author_str, per_curiam, joined_by_str,
	       type, sha1, page_count, download_url, local_path, plain_text, html,
	       html_lawbox, html_columbia, html_anon_2020, xml_harvard,
	       html_with_citations, extracted_by_ocr, author_id, cluster_id) FROM '/home/taylor/Projects/ofcounsel/research-copilot/data/opinions-2023-08-31_0.csv' WITH (FORMAT csv, ENCODING utf8, header);
```

in hexedit at position 0xFE4F28A66/0x34DF156F2B:
```
..</pre>","f",,"4763744"."4544092","2020-06-25 17:13:53.973335+00
```
period instead of newline?
also:
```
"f",,"4763745"."4544093","2020-06-25 17:13:54.280243+00","2022
```
So I found "\." at 0xFE4A73BF9/0x34DF156F2B, which may be causing the error: https://www.postgresql.org/message-id/10837.1403211919%40sss.pgh.pa.us
* Can try with regular COPY instead, seems to be a \copy problem...


opinions cited
`SET session_replication_role = 'replica';` disable fk constraints (otherwise fails: `Key (citing_opinion_id)=(4342547) is not present in table "search_opinion"`)
```

		 \copy public.search_opinionscited (id,depth,cited_opinion_id,citing_opinion_id) FROM '/home/taylor/Projects/ofcounsel/research-copilot/data/citation-map-2023-08-31.csv' WITH (FORMAT csv, ENCODING utf8, header);
```
`SET session_replication_role = 'origin';` reenable fk constraints



streaming data directly into db:
```maybe doesnt work
wget -O - https://storage.courtlistener.com/bulk-data/courts-2023-08-31.csv.bz2 > /dev/null | bzip2 -d - | psql -d courtlistener -c '\copy search_court FROM STDIN WITH (FORMAT csv, ENCODING utf8, HEADER)'
```
```
wget -O - https://storage.courtlistener.com/bulk-data/courts-2023-08-31.csv.bz2 > /dev/null | bzip2 -d - | psql -d courtlistener -c '\copy search_court (id,pacer_court_id,pacer_has_rss_feed,pacer_rss_entry_types,fjc_court_id,date_modified,in_use,has_opinion_scraper,has_oral_argument_scraper,position,citation_string,short_name,full_name,url,start_date,end_date,jurisdiction,notes) FROM STDIN WITH (FORMAT csv, ENCODING utf8, HEADER)'
```

```
\copy search_opinion_2 (
	       id, date_created, date_modified, author_str, per_curiam, joined_by_str,
	       type, sha1, page_count, download_url, local_path, plain_text, html,
	       html_lawbox, html_columbia, html_anon_2020, xml_harvard,
	       html_with_citations, extracted_by_ocr, author_id, cluster_id
	   ) FROM '/home/taylor/Projects/ofcounsel/research-copilot/data/opinions-2023-08-31.csv' WITH (FORMAT csv, ENCODING utf8, HEADER);
```




TODO:
[x] search_court
[ ] search_opinioncluster
[ ] search_docket
[ ] postgres vacuum

failed clusters
```
wget -O - https://storage.courtlistener.com/bulk-data/opinion-clusters-2023-08-31.csv.bz2 > /dev/null | bzip2 -d - | psql -d courtlistener -c 'COPY search_opinioncluster FROM STDIN WITH (FORMAT csv, ENCODING utf8, HEADER)'
```
ERROR:  invalid input syntax for type timestamp with time zone: "Eichaedson"               
CONTEXT:  COPY search_opinioncluster, line 7, column date_modified: "Eichaedson"  

```
wget -O - https://storage.courtlistener.com/bulk-data/opinion-clusters-2023-08-31.csv.bz2 > /dev/null | bzip2 -d - | psql -d courtlistener -c 'COPY search_opinioncluster (
	       id, date_created, date_modified, judges, date_filed,
	       date_filed_is_approximate, slug, case_name_short, case_name,
	       case_name_full, scdb_id, scdb_decision_direction, scdb_votes_majority,
	       scdb_votes_minority, source, procedural_history, attorneys,
	       nature_of_suit, posture, syllabus, headnotes, summary, disposition,
	       history, other_dates, cross_reference, correction, citation_count,
	       precedential_status, date_blocked, blocked, filepath_json_harvard, docket_id,
	       arguments, headmatter
	   ) FROM STDIN WITH (FORMAT csv, ENCODING utf8, HEADER)'
``` worked but had foreign key constraint errors, better to just dl once...


to do clusters
```
COPY search_opinioncluster (
	       id, date_created, date_modified, judges, date_filed,
	       date_filed_is_approximate, slug, case_name_short, case_name,
	       case_name_full, scdb_id, scdb_decision_direction, scdb_votes_majority,
	       scdb_votes_minority, source, procedural_history, attorneys,
	       nature_of_suit, posture, syllabus, headnotes, summary, disposition,
	       history, other_dates, cross_reference, correction, citation_count,
	       precedential_status, date_blocked, blocked, filepath_json_harvard, docket_id,
	       arguments, headmatter
	   ) FROM '/home/taylor/Projects/ofcounsel/research-copilot/data/opinion-clusters-2023-08-31.csv' WITH (FORMAT csv, ENCODING utf8, HEADER);
```


doing dockets 
```
COPY search_docket (
	       id, date_created, date_modified, source, appeal_from_str,
	       assigned_to_str, referred_to_str, panel_str, date_last_index, date_cert_granted,
	       date_cert_denied, date_argued, date_reargued,
	       date_reargument_denied, date_filed, date_terminated,
	       date_last_filing, case_name_short, case_name, case_name_full, slug,
	       docket_number, docket_number_core, pacer_case_id, cause,
	       nature_of_suit, jury_demand, jurisdiction_type,
	       appellate_fee_status, appellate_case_type_information, mdl_status,
	       filepath_local, filepath_ia, filepath_ia_json, ia_upload_failure_count, ia_needs_upload,
	       ia_date_first_change, view_count, date_blocked, blocked, appeal_from_id, assigned_to_id,
	       court_id, idb_data_id, originating_court_information_id, referred_to_id
	   ) FROM '/home/taylor/Projects/ofcounsel/research-copilot/data/dockets-2023-08-31.csv' WITH (FORMAT csv, ENCODING utf8, HEADER);
```ERROR:  insert or update on table "search_docket" violates foreign key constraint "search_do_assigned_to_id_185a002e3102ceb_fk_people_db_person_id"
DETAIL:  Key (assigned_to_id)=(9006) is not present in table "people_db_person".
-> replica mode


```fjc
COPY recap_fjcintegrateddatabase (
	       id, date_created, date_modified, dataset_source, office,
	       docket_number, origin, date_filed, jurisdiction, nature_of_suit,
	       title, section, subsection, diversity_of_residence, class_action,
	       monetary_demand, county_of_residence, arbitration_at_filing,
	       arbitration_at_termination, multidistrict_litigation_docket_number,
	       plaintiff, defendant, date_transfer, transfer_office,
	       transfer_docket_number, transfer_origin, date_terminated,
	       termination_class_action_status, procedural_progress, disposition,
	       nature_of_judgement, amount_received, judgment, pro_se,
	       year_of_tape, nature_of_offense, version, circuit_id, district_id
	   ) FROM '/home/taylor/Projects/ofcounsel/research-copilot/data/fjc-integrated-database-2023-08-31.csv' WITH (FORMAT csv, ENCODING utf8, HEADER);
```


```
wget -O - 
https://storage.courtlistener.com/bulk-data/dockets-2023-08-31.csv.bz2 > /dev/null | bzip2 -d - | psql -d courtlistener -c 'COPY search_docket FROM STDIN WITH (FORMAT csv, ENCODING utf8, HEADER)'
```




# Metabase UI
```
docker pull metabase/metabase:latest
docker run -d -p 3000:3000 --network host --name metabase metabase/metabase
```


