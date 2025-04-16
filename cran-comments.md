## R CMD check results

0 errors | 0 warnings | 0 note

* This is a patch for this issue raising from CRAN:

══ Failed tests ════════════════════════════════════════════════════════════════
── Error ('test-doApiQuery.R:2:3'): A query of more than 20000 records ─────────
&lt;curl_error_couldnt_resolve_host/curl_error/error/condition&gt;
Error in `curl::curl_fetch_memory(url, handle = handle)`: Could not resolve hostname [hubeau.eaufrance.fr]: Could not resolve host: hubeau.eaufrance.fr

skip_on_cran has been added on such tests depending on network connections.
