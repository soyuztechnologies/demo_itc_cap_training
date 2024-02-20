using { mycapapp.db.master, mycapapp.db.transaction } from '../db/mydb';


service colleageservice {

    entity StudentSet as projection on master.student;
    entity ClassSet as projection on master.class;
    entity BookSet as projection on master.books;
    entity SubsSet as projection on transaction.subs;

}