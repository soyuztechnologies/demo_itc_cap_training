namespace mycapapp.db;
using { mycapapp.reuse as reuse } from './reuse';
using { cuid, managed, temporal } from '@sap/cds/common';


context master {
    
    entity student: reuse.address {
        key studentId: reuse.Guid;
        name: String(255);
        gender: String(1);
        rollNo: Int64;
        class: Association to one class;
    };

    entity class {
        key id: reuse.Guid;
        className: String(10);
        teacher: String(64);
    };

    entity books {
        key id: reuse.Guid;
        bookName: localized String(10);
        author: String(64);
    };

}

context transaction {
    
    entity subs : cuid, temporal, managed {
        //key id: reuse.Guid;
        student_id: Association to one master.student;
        book_id: Association to one master.books;
    }

}