/*QUESTION 1
List the name of each officer who has reported more than the average number of crimes officers have reported.
 */
SELECT  O.FIRST , O.LAST ,CO.OFFICER_ID  , COUNT(CO.OFFICER_ID) as "AMOUNT OF ARREST"
FROM CRIME_CHARGES CC JOIN  CRIME_OFFICERS CO 
ON CO.CRIME_ID = CC.CRIME_ID
JOIN OFFICERS O
ON CO.OFFICER_ID = O.OFFICER_ID
group by O.FIRST , O.LAST ,CO.OFFICER_ID 
HAVING COUNT(CO.OFFICER_ID) > ANY (SELECT AVG(COUNT(*))
                          FROM crime_charges GROUP BY CRIME_ID);
/*QUESTION 2 
List the names of all criminals who have committed less than average number of crimes and aren’t 
listed as violent offenders.


*/
SELECT C.CRIMINAL_ID , C.FIRST , C.LAST, CR.CRIME_ID
FROM CRIMINALS C JOIN CRIMES CR 
ON C.CRIMINAL_ID = CR.CRIMINAL_ID
WHERE C.V_STATUS = 'N'
AND CR.CRIME_ID < ANY (SELECT AVG(COUNT(*)) FROM CRIMES GROUP BY CRIME_ID);

/*QUESTION 3 
List appeal information for each appeal that has a less than average number of days between the filing and hearing dates.

*/

SELECT * 
FROM APPEALS
WHERE HEARING_DATE - FILING_DATE < ANY 
                                    ( SELECT AVG(HEARING_DATE - FILING_DATE) 
                                      FROM APPEALS);
/*QUESTION 4 */
SELECT S.PROB_ID , PO.FIRST ,PO.LAST , COUNT(CRIMINAL_ID) AS "AMOUNT OF ACCIGNED CRIMINALS"
FROM SENTENCES S JOIN PROB_OFFICERS PO
ON S.PROB_ID = PO.PROB_ID
GROUP BY S.PROB_ID , PO.FIRST ,PO.LAST
HAVING COUNT(CRIMINAL_ID) > ANY (SELECT AVG(COUNT(*))
                                  FROM SENTENCES GROUP BY CRIMINAL_ID);



/*QUESTION 5 
 List each crime that has had the highest number of appeals recorded.
*/
SELECT CC.CRIME_ID ,COUNT(CC.CRIME_ID) as "Number of apppeals"
FROM CRIME_CHARGES CC JOIN APPEALS A 
ON CC.CRIME_ID = A.CRIME_ID
GROUP BY CC.CRIME_ID  
ORDER BY CC.CRIME_ID;