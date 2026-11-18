# VUA-SEN307 Lab 4: Referential Integrity Notes

**Name:** Chris-Derique Ehizo  
**Matric Number:** VUG/SEN/24/12878  
**Course:** VUA-SEN307 Database Systems  

In Part 4, attempting to delete the `Library and Information Science` record from the `Department` table triggered **Error 1451: Cannot delete or update a parent row: a foreign key constraint fails**[cite: 16]. MySQL refused the deletion because a child record (`Transfer Student`, matric `20239999`) in the `Student` table still referenced that department's `dept_id`, and deleting the parent row would create an orphaned foreign key reference[cite: 15, 16]. I resolved this safely by first executing an `UPDATE` statement to reassign `Transfer Student` to the `Software Engineering` department before re-running the `DELETE` statement on `Department`[cite: 16]. Alternatively, if the business rules required automatic cleanup or nullification upon parent deletion, the foreign key constraint on `Student` could have been defined with `ON DELETE CASCADE` (to delete dependent student rows automatically) or `ON DELETE SET NULL` (to set their `dept_id` to `NULL`).