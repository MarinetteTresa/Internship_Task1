-- To get the Amount and Date--
SELECT   PropertyExpense.Amount, CONVERT(varchar, PropertyExpense.Date, 106) AS Date
FROM         Property INNER JOIN
                         PropertyExpense ON Property.Id = PropertyExpense.PropertyId INNER JOIN
                         Address ON Property.AddressId = Address.AddressId INNER JOIN
                         OwnerProperty ON Property.Id = OwnerProperty.PropertyId INNER JOIN
                         Person ON OwnerProperty.OwnerId = Person.Id
WHERE     (Property.Name = 'Property A')


-- To get Name, ForstNamr, Number, Street,Property Details--
SELECT   p.Name, ps.FirstName, a.Number, a.Street, a.Suburb, a.City, p.Id, a.AddressId, pe.Amount, p.Bathroom, p.Bedroom, rt.Name AS Frequency
FROM         OwnerProperty AS op INNER JOIN
                         Property AS p ON op.PropertyId = p.Id INNER JOIN
                         Person AS ps ON ps.Id = op.OwnerId INNER JOIN
                         Address AS a ON a.AddressId = p.AddressId INNER JOIN
                         PropertyExpense AS pe ON p.Id = pe.PropertyId INNER JOIN
                         TargetRentType AS rt ON p.TargetRentTypeId = rt.Id
WHERE     (p.Name = 'Property A')



