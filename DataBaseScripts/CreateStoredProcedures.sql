--CREATE PROCEDURE usp_CustomerCreate (out custId int, in name_p varchar(100), in address_p varchar(50), in city_p varchar(20), in state_p varchar(2), in zipcode_p varchar(15))
--BEGIN
--	Insert into customers (name, address, city, state, zipcode, concurrencyid)
--    Values (name_p, address_p, city_p, state_p, zipcode_p, 1);
--    Select LAST_INSERT_ID() into custId;
--    
--END //

DELIMITER //

DROP usp_RecipeCreate;
CREATE PROCEDURE usp_RecipeCreate(out out_recipeID int, in in_name varchar(100), in in_style varchar(20), in in_version int, in in_ibu DECIMAL(10,4), in in_abv DECIMAL(10,4))
BEGIN
	Insert INTO Recipe (Name, Style, Version, IBU, ABV) VALUES (in_name, in_style, in_version, in_ibu, in_abv);
	SELECT LAST_INSERT_ID() INTO out_recipeID;
END//

CREATE PROCEDURE usp_IngredientRecipeCreate(out out_ingredient_recipeID, in in_recipeID, in in_ingredientID)
BEGIN
	
END//

DELIMITER ;

