CLASS lhc_zi_bookData DEFINITION INHERITING FROM cl_abap_behavior_handler.
    PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
        IMPORTING keys REQUEST requested_authorizations FOR zi_bookData RESULT result.

    METHODS generateBookNumber FOR NUMBERING
        IMPORTING entities FOR CREATE zi_bookData.

    METHODS BookALlotNumber FOR NUMBERING
        IMPORTING entities FOR CREATE zi_bookData\_bookallot.

    METHODS DefaulterNumber FOR NUMBERING
        IMPORTING entities FOR CREATE zi_bookData\_defaulters.

ENDCLASS.

CLASS lhc_zi_bookData IMPLEMENTATION.

    METHOD get_instance_authorizations.
    ENDMETHOD.

    METHOD generateBookNumber.
        "create a table reference
        DATA(lt_Entities) = entities.
        "check and delete the entities where the book id is not initial
        DELETE lt_entities WHERE Bookid IS NOT INITIAL.
        " Get the next number as per the requirement using the number range object.
        TRY.
            cl_numberrange_runtime=>number_get(
            EXPORTING
                nr_range_nr  = '01'   " counter ++ by 1
                object = '/DMO/TRV_M' "'ZBOOKID_R'   " number range object
                quantity = CONV #( lines( lt_entities ) ) " number of instance for Book
            IMPORTING
                number = DATA(lv_bookid_new) "New Book id
                returncode = DATA(lv_code)
                returned_quantity = DATA(lv_qty)
            ).
        CATCH cx_nr_object_not_found.
        CATCH cx_number_ranges INTO DATA(lo_error).
        " Find the failed and reported cases.
        LOOP AT lt_entities INTO DATA(ls_entities).
            APPEND VALUE #( %cid = ls_entities-%cid
                            %key = ls_entities-%key )
                            TO failed-zi_bookdata.

            APPEND VALUE #( %cid = ls_entities-%cid
                            %key = ls_entities-%key
                            %msg = lo_error )
                        TO reported-zi_bookdata.
        ENDLOOP.
        EXIT.
    ENDTRY.
        "Check that number of lines = returned quantity
        " e.g interval is not sufficient for the number like 199 + 1 = 200 but the range is up to 199 then
        " for that we use the Assert Keyword.
        ASSERT lv_qty = lines(  lt_entities ).
        DATA(lv_curr_bookid) =  lv_bookid_new - lv_qty.
        " append the new entry in the mapped table .
        LOOP AT lt_entities INTO ls_entities.
        lv_curr_bookid = lv_curr_bookid + 1.
        APPEND VALUE #( %cid = ls_entities-%cid
                        bookid = lv_curr_bookid )
                        TO mapped-zi_bookdata.
        ENDLOOP.

    ENDMETHOD.


    " generating Book allotment id
    METHOD BookALlotNumber.

        DATA: max_id TYPE zbookallotids.

        READ ENTITIES OF zi_bookData IN LOCAL MODE
        ENTITY zi_bookData BY \_bookallot
        FROM CORRESPONDING #( entities )
        LINK DATA(lt_link_data).

        " loop over all unique %tky ( Bookid + BookallotIDs)
        LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entity>) GROUP BY <fs_entity>-Bookid.

        "get the highest book allotment id's from book allotment belonging to book allotment id's
        max_id = REDUCE zbookallotids(
                    INIT lv_max = 0" CONV zbookallotids( '0' )
                    FOR ls_link IN lt_link_data
                    USING KEY entity
                    WHERE ( source-Bookid = <fs_entity>-Bookid )
                    NEXT lv_max = COND zbookallotids(
                                    WHEN lv_max < ls_link-target-Bookallotmentids
                                    THEN ls_link-target-Bookallotmentids
                                    ELSE lv_max ) ).

        "get the highest book allotment id's from incoming entities
        max_id = REDUCE zbookallotids(
                    INIT lv_max1 = max_id
                    FOR ls_entity IN entities
                    USING KEY entity
                    WHERE ( bookid = <fs_entity>-Bookid )
                    FOR ls_bookallot IN ls_entity-%target
                    NEXT lv_max1 = COND zbookallotids(
                                    WHEN lv_max1 < ls_bookallot-Bookallotmentids
                                    THEN ls_bookallot-Bookallotmentids
                                    ELSE lv_max1 ) ).

        LOOP AT entities ASSIGNING FIELD-SYMBOL(<fls_entities>)
            USING KEY entity
            WHERE Bookid = <fs_entity>-Bookid.

            LOOP AT <fls_entities>-%target ASSIGNING FIELD-SYMBOL(<ls_bookallot>).

            IF <ls_bookallot>-Bookallotmentids IS INITIAL.
                max_id +=  1.
                APPEND CORRESPONDING #( <ls_bookallot> ) TO mapped-zi_bookallotment ASSIGNING FIELD-SYMBOL(<ls_new_bookallot>).
                <ls_new_bookallot>-Bookallotmentids = max_id.
            ENDIF.
            ENDLOOP.
        ENDLOOP.
        ENDLOOP.
    ENDMETHOD.


    " generate defaulter ids.
    METHOD defaulternumber.
    DATA : lv_max_defaulter TYPE zdefaulterids.

    READ ENTITIES OF zi_bookData IN LOCAL MODE
    ENTITY zi_bookData BY \_defaulters
    FROM CORRESPONDING #( entities )
    LINK DATA(lt_link_defaulters).

    " loop over all unique %tky ( Bookid + Defautlers IDs)
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<lfs_defaulter>) GROUP BY <lfs_defaulter>-Bookid.

        "get the highest book allotment id's from book allotment belonging to book allotment id's
        lv_max_defaulter = REDUCE zdefaulterids(
                            INIT lv_max = 0
                            FOR ls_link IN lt_link_defaulters
                            USING KEY entity
                            WHERE ( source-Bookid = <lfs_defaulter>-Bookid )
                            NEXT lv_max = COND zdefaulterids(
                                        WHEN lv_max < ls_link-target-Defaulterid
                                        THEN ls_link-target-Defaulterid
                                        ELSE lv_max ) ).

        "get the highest book defaulter id's from incoming entities
        lv_max_defaulter = REDUCE zdefaulterids(
                    INIT lv_max1 = lv_max_defaulter
                    FOR ls_entity IN entities
                    USING KEY entity
                    WHERE ( bookid = <lfs_defaulter>-Bookid )
                    FOR ls_bookdefaulter IN ls_entity-%target
                    NEXT lv_max1 = COND zdefaulterids(
                                    WHEN lv_max1 < ls_bookdefaulter-Defaulterid
                                    THEN ls_bookdefaulter-Defaulterid
                                    ELSE lv_max1 ) ).

        LOOP AT entities ASSIGNING FIELD-SYMBOL(<fls_entities>)
                    USING KEY entity
                        WHERE Bookid = <lfs_defaulter>-Bookid.
        LOOP AT <fls_entities>-%target ASSIGNING FIELD-SYMBOL(<ls_defaulter>).
            IF <ls_defaulter>-Defaulterid IS INITIAL.
                lv_max_defaulter +=  1.
                APPEND CORRESPONDING #( <ls_defaulter> ) TO mapped-zi_defaulterdata ASSIGNING FIELD-SYMBOL(<ls_new_defaulter>).
                <ls_new_defaulter>-Defaulterid = lv_max_defaulter.
            ENDIF.
        ENDLOOP.
        ENDLOOP.
    ENDLOOP.
    ENDMETHOD.

ENDCLASS.