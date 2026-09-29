UPDATE snippets
SET content = REPLACE(content, E'\\n', E'\n')
WHERE visibility = 'DEMO'
  AND content LIKE '%\\n%';
