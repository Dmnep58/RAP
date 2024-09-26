"1. read entity --> with all fields

METHOD read_entity.
    " read a single entity association and store it in a table Result and store failed in Table Failed
    READ ENTITY zi_bookData
        ALL FIELDS WITH VALUE #(  ( %key-Bookid = '12' )
                                    ( %key-Bookid = '12' ) )
        RESULT DATA(lt_rentity)
        FAILED DATA(lt_fentity).
    
    IF lt_fentity IS NOT INITIAL.
        out->write( 'Read Entity Failed' ).
    ENDIF.
    " fetch and show the data.
    out->write( lt_rentity ).
ENDMETHOD.


"2.  read entity by association --> with all fields
METHOD read_by_association.

    " read a single entity association and store it in a table Result and store failed in Table Failed
    READ ENTITY zi_bookData by \_bookallot
        ALL FIELDS WITH VALUE #(  ( %key-Bookid = '12' ) )
        RESULT DATA(lt_rentity)
        FAILED DATA(lt_fentity).
    
    IF lt_fentity IS NOT INITIAL.
        out->write( 'Read Entity Failed' ).
    ENDIF.
    " fetch and show the data.
    out->write( lt_rentity ).
ENDMETHOD.



"3.  read entities --> with all fields
METHOD read_entities.
    ENTITY zi_bookData ALL FIELDS WITH value #( ( %key-Bookid = '12' ) )
    RESULT DATA(lt_entity)

    ENTITY zi_bookallotment ALL FIELDS WITH value #( ( %key-Bookallotmentids = '12'
                                                        %key-Bookids = '001' ) )
    RESULT DATA(lt_rentity)
    FAILED DATA(lt_fentity).

    IF lt_fentity IS NOT INITIAL.
        out->write( 'Read Entity Failed' ).
    ENDIF.

    " fetch and show the data.
    out->write( lt_entity ).
    out->write( lt_rentity ).
ENDMETHOD.



"4. read entites --> with dynamic reads.
METHOD dynamicForm_read.
    *  dynamic read
        DATA: it_optab            TYPE abp_behv_retrievals_tab,
            it_book             TYPE TABLE FOR READ IMPORT zi_bookData,
            it_book_result      TYPE TABLE FOR READ RESULT zi_bookData,
            it_bookallot        TYPE TABLE FOR READ IMPORT zi_bookData\_bookallot,
            it_bookallot_result TYPE TABLE FOR READ RESULT zi_bookData\_bookallot,
            it_book_link type table for read link zi_bookData\_bookallot.
    
        "Parent Entity
        it_book = VALUE #( ( %key-Bookid = '12'
                            %control = VALUE #( Bookid = if_abap_behv=>mk-on
                                                Bookauthor = if_abap_behv=>mk-on
                                                Bookname = if_abap_behv=>mk-on ) ) ).
        "Child Entity
        it_bookallot = VALUE #( ( %key-Bookid = '12'
                            %control = VALUE #( Bookallotmentids = if_abap_behv=>mk-on
                                                Studentids = if_abap_behv=>mk-on
                                                AllotmentDate = if_abap_behv=>mk-on ) ) ).
        " filling the table --> Dynamic EML
        it_optab = VALUE #( ( op = if_abap_behv=>op-r-read
                            entity_name = 'ZI_BOOKDATA' "read main entity
                            instances = REF #( it_book )
                            results = REF #( it_book_result ) )
                            ( op = if_abap_behv=>op-r-read_ba
                            entity_name = 'ZI_BOOKDATA'
                            sub_name = '_BOOKALLOT' " associated entity
                "full: Optional flag; specifies if all target instances are to be retrieved
                            full = abap_true
                            instances = REF #( it_bookallot )
                            results = REF #( it_bookallot_result )
                "links: Reference to internal table holding the key pairs of the source and target
                            links = REf #( it_book_link ) ) ).
    
    
        READ ENTITIES operations it_optab FAILED data(lt_failed).
    
    " Error Handling and Output
        IF lt_failed IS NOT INITIAL.
        out->write( 'Read Failed' ).
    
        " Enhanced error logging for failure details
        LOOP AT lt_failed INTO DATA(failed_entry).
            out->write( failed_entry ).
        ENDLOOP.
        ELSE.
        out->write( it_book_result ).
        out->write( it_book ).
        out->write( it_bookallot ).
        out->write( it_bookallot_result ).
        ENDIF.
ENDMETHOD.
    