" Behavoiur Definition --> projection  --> on consumption View --> book data

projection;
strict ( 2 );

define behavior for zc_bookdata "alias <alias_name>
use etag
{
use create;
use update;
use delete;

use association _bookallot { create; }
use association _defaulters { create; }
}

define behavior for Zc_BOOKALLOTMENT "alias <alias_name>
{use update;
use delete;

use association _bookdata;
}

define behavior for ZC_DEFAULTERDATA "alias <alias_name>
{
use update;
use delete;

use association _book;
}