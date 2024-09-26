managed;
strict ( 2 );

define behavior for zi_bookData "alias <alias_name>
implementation in class zbp_i_bookdata unique
persistent table zbooks
lock master
authorization master ( instance )
etag master changedat
early numbering
{
  create;
  update;
  delete;
  field ( readonly ) Bookid;
  association _bookallot { create; }
  association _defaulters { create; }

  mapping for zbooks{
  Bookid = bookid;
  Bookname = bookname;
  Bookauthor = bookauthor ;
  Quantity = quantity;
  status = status;
  lastchangedat = lastchangedat;
  changedat = changedat;
  }
}

define behavior for zi_bookallotment "alias <alias_name>
implementation in class zi_bp_bookAllot unique
persistent table zbookallotment
lock dependent by _bookdata
authorization dependent by _bookdata
"etag master <field_name>
early numbering
{
  update;
  delete;
  field ( readonly  ) Bookids, Bookallotmentids;
  field (readonly:update) Studentids;
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

define behavior for zi_defaulterdata "alias <alias_name>
implementation in class zi_bp_defaulter unique
persistent table zdefaulters
lock dependent by _book
authorization dependent by _book
"etag master <field_name>
early numbering
{
  update;
  delete;
  field ( readonly ) Bookids, Studentids, Defaulterid;
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