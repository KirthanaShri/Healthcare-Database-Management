USE PARAWORLD;


-- Selecting patients who have not used any service
SELECT * FROM PATIENT 
WHERE P_ID NOT IN (SELECT P.P_ID FROM PATIENT P 
				   JOIN BILL B 
				   ON P.P_ID = B.P_ID);



-- Selecting delivery person who has delivered maximum orders- Retrieving name of delievry agent??
SELECT ds_ssn,count(ds_ssn) as TotalNo_Delivered_Orders
FROM ORDERS
GROUP BY ds_ssn
ORDER BY count(ds_ssn) desc
LIMIT 3;

-- Selecting top 3 delivery agent who has delivered maximum no of orders overall
SELECT *
FROM DELIVERY_STAFF
HAVING ds_ssn = (SELECT ds_ssn
				FROM ORDERS
				GROUP BY ds_ssn
				ORDER BY count(ds_ssn) desc
				LIMIT 1
);

-- Retrieving details of all laboratories have performed atleast 10 lab tests
SELECT * 
FROM LABORATORY L
WHERE 10<(SELECT count(*) 
		  FROM LAB_TEST LT
		  WHERE L.laboratory_id = LT.laboratory_id);


-- Display the diagnosis of patients with age greater than 40
SELECT P.P_ID, P.NAME, C.DIAGNOSIS 
FROM PATIENT P 
JOIN CONSULTATION C 
ON P.P_ID = C.P_ID 
WHERE P.AGE>40;


-- RETRIEVING Patient records who has ordered in pharmacy more than 4 times



-- Retrieving service_name and count of each type that has service charge more than average service charge
SELECT service_name, count(service_name) as Service_Count
FROM BILL
GROUP BY service_name
;


SELECT service_name,count(service_name) as Service_Count
FROM BILL
WHERE bill_id = ANY(SELECT bill_id 
					FROM BILL
					WHERE total_charge > (SELECT avg(total_charge) FROM BILL))
GROUP BY service_name;

-- RETRIEVING PATIENTS WHO CAN DONATE BLOOD TODAY
SELECT * FROM PATIENT
WHERE Datediff(CURDATE(),last_donation)>120;




