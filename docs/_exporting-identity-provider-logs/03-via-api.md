---
title: Via API
order: 3
duration: 1
last_updated: 15 April, 2026
---

If you have not done so already, please [Setup to use the API](/log-into-federation-manager/04-using-the-api) to get started.
{: .callout-info }

- use the identity providers api endpoint to find the ID of the identity provider you would like to get the logs of <https://manager.test.aaf.edu.au/api/identity_providers>.

- Once you have the id of the identity provider you would like the logs of provide it to the logs endpoint <https://manager.test.aaf.edu.au/api/identity_providers/{ID}/logs>.

- You must request `date_start` and `date_end`  with millisecond epochs, use <https://www.epochconverter.com/> then multiple it by 1000.
- The logs endpoint will only return a maximum of 1000 logs at a time, this means even if you asked for 1 month of logs it may only return part of the furthest day.
- In the response there is an etag this will represent the next `date_start` epoch checkpoint for scanning up the logs.
- Simply continue to request logs given the same `date_end` epoch while using each etag returned until `date_start >= date_end` or no results are returned anymore.
