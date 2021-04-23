#Add a new customer to the CUSTOMER table
INSERT INTO CUSTOMER VALUES (NULL, 'Summers', 'Jill', 'jill.summers@gmail.com',
							NULL, '724-555-0001', '22 Elm', 'Greensburg', 'PA', '15601-0001');
                            
#Add a new seminar
INSERT INTO SEMINAR VALUES (NULL, 'Closet Remodeling for Under $100', '2021-04-24', '12:00:00',
							'Convention Center');
                            
#Enroll Jill Summers into the new seminar
SELECT * FROM SEMINAR_CUSTOMER;
INSERT INTO SEMINAR_CUSTOMER VALUES (7, 13);
SELECT * FROM SEMINAR_CUSTOMER;

#Show the Firstnames and Lastnames of people enrolled in the new seminar using a Subquery
SELECT firstName, lastName 
FROM CUSTOMER
WHERE CustomerID = (SELECT CustomerID
					FROM SEMINAR_CUSTOMER
					WHERE SeminarID = 7); 

#Produce a report of the new seminar with all information about the seminar and 
#all information about customers enrolled in that seminar - Here we use a join statement after the where
SELECT *
FROM SEMINAR, CUSTOMER, SEMINAR_CUSTOMER
WHERE  SEMINAR.SeminarID = SEMINAR_CUSTOMER.SeminarID
AND CUSTOMER.CustomerID = SEMINAR_CUSTOMER.CustomerID
AND SEMINAR.SeminarID = 7;

#Enroll CustomerID 3 into the new Seminar
INSERT INTO SEMINAR_CUSTOMER VALUES (7, 3); 
SELECT * FROM SEMINAR_CUSTOMER;

#Showing names of all people enrolled in the new Seminar
SELECT firstName, lastName 
FROM CUSTOMER
WHERE CustomerID IN (SELECT CustomerID
					FROM SEMINAR_CUSTOMER
					WHERE SeminarID = 7); 

#Enroll CustomerID 4 into the new Seminar
INSERT INTO SEMINAR_CUSTOMER VALUES (7, 4);

#Get a report only stating Seminar Title, Location, First Name and Last Name
SELECT SeminarTitle, Location, firstName, lastName
FROM SEMINAR, CUSTOMER, SEMINAR_CUSTOMER
WHERE SEMINAR.SeminarID = SEMINAR_CUSTOMER.SeminarID
AND   CUSTOMER.CustomerID = SEMINAR_CUSTOMER.CustomerID
AND   SEMINAR.SeminarID = 7;

#Show the number of people enrolled in the new Seminar
SELECT COUNT(*) AS Enrollment
FROM SEMINAR_CUSTOMER
WHERE SeminarID = 7;

#Show a count of all people enrolled in any seminar
SELECT COUNT(*) AS AllEnrollment
FROM SEMINAR_CUSTOMER;

#Show a count of all people enrolled in ANY seminar with budget in the title
SELECT COUNT(*) AS Enrollment
FROM SEMINAR_CUSTOMER, SEMINAR
WHERE SeminarTitle LIKE '%Budget%'
AND SEMINAR.SeminarID = SEMINAR_CUSTOMER.SeminarID;
#The AND above is the connection of the keys

#Show a count of all people enrolled in EACH seminar with budge in the title
SELECT SeminarTitle, COUNT(*) AS Enrollment
FROM SEMINAR_CUSTOMER, SEMINAR
WHERE SeminarTitle LIKE '%Budget%'
AND SEMINAR.SeminarID = SEMINAR_CUSTOMER.SeminarID
GROUP BY SeminarTitle;

#Change the new Seminar time to 11:00:00
UPDATE SEMINAR
SET SeminarTime = '11:00:00'
WHERE SeminarID = 7;

#Change Jill Summers phone number
UPDATE CUSTOMER
SET PHONE = '724-555-2222'
WHERE CustomerID = 13;

#Remove Jill Summers from the CUSTOMER table

#This does not work because this appears as a foreing key elsewhere
#This would go against Referntial Integrity constraints
DELETE FROM CUSTOMER
WHERE CustomerID = 13; 

#We could remove the seminar information first then do above
#Foreign keys should be removed first

#Remove Jill from the Seminar enrollments
DELETE FROM SEMINAR_CUSTOMER
WHERE CustomerID = 13;

#edit the SEMINAR_CUSTOMER table change the Foreign Key of CustomerID
#to Cascading Deletes - This deletes a customer and their enrollments
#You have to go to the table information and change the on delete information for Customer
#from RESTRICT to CASCADE

#Add Jill Summers back as a Customer
INSERT INTO CUSTOMER VALUES (13, 'Summers', 'Jill', 'jill.summers@gmail.com',
							 NULL, '724-555-0011', '22 Elm St', 
							'Greensburg', 'PA', '15601-0001');

#Add Jill Summers enrollments
INSERT INTO SEMINAR_CUSTOMER VALUES (1,13);
INSERT INTO SEMINAR_CUSTOMER VALUES (7,13);

#Show seminar enrollments for Jill
SELECT * 
FROM SEMINAR_CUSTOMER 
WHERE CustomerID = 13;
#You could use a subquery here to pull these enrollments up by her name
SELECT *
FROM SEMINAR_CUSTOMER
WHERE CustomerID = (SELECT CustomerID
					FROM CUSTOMER
					WHERE FirstName = 'Jill' AND LastName = 'Summers');
#Remember you can use = because there is only 1 Jill Summers but if there was more then 1 then
#you should use IN

#Remove Jill from the CUSTOMER table again
DELETE FROM CUSTOMER
WHERE CustomerID = 13; 
#This works now due to the cascading deleting 

#Delete Seminar 7
DELETE FROM SEMINAR
WHERE SeminarID = 7;
#Here we seen an issue with the customers who are enrolled in this seminar
#The DBMS does not let you do this

#Show the details for invoice 35001
SELECT *
FROM INVOICE
WHERE InvoiceNumber = 35001;

#Show the detials for invoice 35001 and the LINE_ITEM data
SELECT *
FROM INVOICE, LINE_ITEM
WHERE INVOICE.InvoiceNumber = 35001
AND INVOICE.InvoiceNumber = LINE_ITEM.InvoiceNumber;

#SHow the detials of invoice 35001 and its LINE_ITEM including PRODUCT description
SELECT *
FROM INVOICE, LINE_ITEM, PRODUCT
WHERE INVOICE.InvoiceNumber = 35001
AND INVOICE.InvoiceNumber = LINE_ITEM.InvoiceNumber
AND PRODUCT.ProductNumber = LINE_ITEM.ProductNumber;

#Show only the LineNumber, ProductNumber, ProductDescription, Quantity,
#UnitPrice, and Total
SELECT LINE_ITEM.LineNumber, LINE_ITEM.ProductNumber, ProductDescription,
LINE_ITEM.Quantity, LINE_ITEM.UnitPrice, LINE_ITEM.Total
FROM INVOICE, LINE_ITEM, PRODUCT
WHERE INVOICE.InvoiceNumber = 35001
AND INVOICE.InvoiceNumber = LINE_ITEM.InvoiceNumber
AND PRODUCT.ProductNumber = LINE_ITEM.ProductNumber;
