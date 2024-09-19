" Behavoiur Definition --> Managed  --> on Interface View --> book data

managed implementation in class zbp_i_bookdata unique;
strict ( 2 );

define behavior for zi_bookData //alias <alias_name>
persistent table zbooks
lock master
authorization master ( instance )
etag master lastchangedat
{
  create;
  update;
  delete;
  field ( readonly ) Bookid;
  association _bookallot { create; }
  association _defaulters { create; }
}

define behavior for zi_bookallotment //alias <alias_name>
persistent table zbookallotment
lock dependent by _bookdata
authorization dependent by _bookdata
//etag master <field_name>
{
  update;
  delete;
  field ( readonly : update ) Bookallotmentids, Studentids;
  field ( readonly ) Bookids;
  association _bookdata;
  mapping for zbookallotment
    {
      Bookallotmentids = bookallotmentids;
      Bookids          = bookids;
      Studentids       = studentids;
      allotmentDate    = allotment_date;
      SubmissionDate   = submission_date;
    }
}

define behavior for zi_defaulterdata //alias <alias_name>
persistent table zdefaulters
lock dependent by _book
authorization dependent by _book
//etag master <field_name>
{
  update;
  delete;
  field ( readonly : update ) Defaulterid;
  field ( readonly ) Bookids, Studentids;
  association _book;
  mapping for zdefaulters
    {
      Defaulterid  = defaulterid;
      Bookids      = bookids;
      Currencycode = currencycode;
      Studentids   = studentids;
      Penalty      = penalty;
    }
}