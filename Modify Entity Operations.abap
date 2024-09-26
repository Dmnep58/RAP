""""""""""""""""""""""""""""""""""""""""""""" Value tab """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"1. modify entity for the single instance.
method modfiy_entity.
    modify entity zi_bookData
    create from value #( ( %cid = 'CID1'  %data-Bookauthor = 'Pawan' %data-Bookname = 'CRS' %data-Quantity = 123
                            %control-Bookauthor = if_abap_behv=>mk-on
                            %control-Bookname = if_abap_behv=>mk-on
                            %control-Quantity = if_abap_behv=>mk-on  )
                        )
                        failed final(lt_final)
                        MAPPED FINAL(lt_mapped)
                        REPORTED FINAL(lt_reported).

    if lt_mapped is NOT INITIAL.
        out->write( lt_mapped ).
        out->write( lt_final ).
        out->write( lt_reported ).
    else.
        commit Entities.
    endif.
endmethod.


" 2. Modify Entity For Many Entities. --> by association.
METHOD modify_entities.
    MODIFY ENTITY zi_bookData
    CREATE FROM VALUE #( ( %cid = 'cid1'  %data-Bookauthor = 'Pawan' %data-Bookname = 'CRS' %data-Quantity = 123
                            %control-Bookauthor = if_abap_behv=>mk-on
                            %control-Bookname = if_abap_behv=>mk-on
                            %control-Quantity = if_abap_behv=>mk-on  )
                        )
    CREATE BY \_bookallot
            FROM VALUE #( ( %cid_ref = 'cid1'
                        %target = VALUE #(  (  %cid = 'cid11'
                                                Studentids = '123'
                                                %control-Studentids = if_abap_behv=>mk-on ) )
                        ) )
                        FAILED FINAL(lt_final)
                        MAPPED FINAL(lt_mapped)
                        REPORTED FINAL(lt_reported).

    IF lt_final IS NOT INITIAL.
        out->write( lt_final ).
    ELSE.
        COMMIT ENTITIES.
    ENDIF.
ENDMETHOD.


" 3. Delete entity from the table. --> delete parent along with child entities
METHOD modify_delete.
    MODIFY ENTITY zi_bookData
    DELETE FROM VALUE #( ( %key-Bookid = '12'  ) )
                        FAILED FINAL(lt_final)
                        MAPPED FINAL(lt_mapped)
                        REPORTED FINAL(lt_reported).

    IF lt_final IS NOT INITIAL.
        out->write( lt_final ).
    ELSE.
        COMMIT ENTITIES.
    ENDIF.
ENDMETHOD.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""" Auto Fill """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"1. Auto  fill CID with fields_tab.
method auto_fill.
    MODIFY ENTITY zi_bookData
    CREATE AUTO FILL CID WITH VALUE #( (
                                    %data-Bookauthor = 'Devi Prasad'
                                    %data-Bookname = 'Practice Book'
                                    %control-Bookauthor = if_abap_behv=>mk-on
                                    %control-Bookname = if_abap_behv=>mk-on ) )
                        FAILED FINAL(lt_final)
                        MAPPED FINAL(lt_mapped)
                        REPORTED FINAL(lt_reported).

    IF lt_final IS NOT INITIAL.
        out->write( lt_final ).
    ELSE.
        COMMIT ENTITIES.
    ENDIF.
ENDMETHOD.


"2.  [Auto  fill CID] Update FIELDS ( field1 field2 ) with fields_tab
" in this way we need not to pass the control structure.
METHOD auto_fill_cid.

    MODIFY ENTITIES OF zi_bookData
    ENTITY zi_bookData
    UPDATE FIELDS ( Bookauthor )
    WITH VALUE #( ( %key-Bookid = '13'
                    %data-Bookauthor = 'Practice Book'
                ) )
    FAILED FINAL(lt_final).

    IF lt_final IS NOT INITIAL.
        out->write( lt_final ).
    ELSE.
        COMMIT ENTITIES.
    ENDIF.
ENDMETHOD.

" 3. [Auto  fill CID] Update FIELDS ( field1 field2 ) with fields_tab --> multiple entities --> long form
" do update and delete in single modigy entity
METHOD multiple_operation_entities.
    MODIFY ENTITIES OF zi_bookData
    ENTITY zi_bookData
    UPDATE FIELDS ( Bookauthor )
    WITH VALUE #( ( %key-Bookid = '13'
                    %data-Bookauthor = 'Practice Book'
                ) )
    ENTITY zi_bookData
    DELETE FROM VALUE #( ( Bookid = '1234' ) )
    FAILED FINAL(lt_final).

    IF lt_final IS NOT INITIAL.
        out->write( lt_final ).
    ELSE.
        COMMIT ENTITIES.
    ENDIF.
ENDMETHOD.


"3. [Auto  fill CID] SET FIELDS ( field1 field2 ) with fields_tab.
method set_update_fields.

    MODIFY ENTITY zi_bookData
    UPDATE SET FIELDS WITH VALUE #( ( %key-Bookid = '13'
                                        %data-Bookauthor = 'Practice Book'
                                    ) )
    FAILED FINAL(lt_final).

    IF lt_final IS NOT INITIAL.
        out->write( lt_final ).
    ELSE.
        COMMIT ENTITIES.
    ENDIF.
    endmethod.
