select 'plain_text', count(plain_text) from search_opinion where plain_text <> ''
union
select 'html', count(html) from search_opinion where html <> ''
union
select 'html_lawbox', count(html_lawbox) from search_opinion where html_lawbox <> ''
union
select 'html_columbia', count(html_columbia) from search_opinion where html_columbia <> ''
union
select 'html_with_citations', count(html_with_citations) from search_opinion where html_with_citations <> ''
union
select 'html_anon_2020', count(html_anon_2020) from search_opinion where html_anon_2020 <> ''
union
select 'xml_harvard', count(xml_harvard) from search_opinion where xml_harvard <> ''
union
select 'author_str', count(author_str) from search_opinion where author_str <> ''
union
select 'joined_by_str', count(joined_by_str) from search_opinion where joined_by_str <> ''
union
select 'type', count(type) from search_opinion where type <> ''
union
select 'sha1', count(sha1) from search_opinion where sha1 <> ''
union
select 'download_url', count(download_url) from search_opinion where download_url <> ''
union
select 'local_path', count(local_path) from search_opinion where local_path <> ''


