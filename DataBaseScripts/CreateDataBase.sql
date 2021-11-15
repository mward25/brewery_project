CREATE DATABASE IF NOT EXISTS BrewerySystem;
USE BrewerySystem;

SET FOREIGN_KEY_CHECKS=0;   
DROP TABLE Recipe;
DROP TABLE Brew;
DROP TABLE Ingredient;
DROP TABLE RecipeIngredient;
SET FOREIGN_KEY_CHECKS=0;   


CREATE TABLE IF NOT EXISTS Recipe (
	RecipeID int AUTO_INCREMENT Primary key NOT NULL,
	Name varchar(100) NOT NULL,
	Style varchar(20) NOT NULL,
	Version int NOT NULL,
	IBU DECIMAL(10,4) NOT NULL,
	ABV DECIMAL(10,4) NOT NULL,
	Active bool NOT NULL DEFAULT TRUE);

CREATE TABLE IF NOT EXISTS Brew (
	BrewID int AUTO_INCREMENT Primary key NOT NULL,
	RecipeID int NOT NULL,
	ScheduledDate DATE NOT NULL,
	Done bool NOT NULL DEFAULT FALSE);


CREATE TABLE IF NOT EXISTS Ingredient (
	IngredientID int AUTO_INCREMENT Primary key NOT NULL,
	Name varchar(40) NOT NULL,
	Quantity int NOT NULL);

CREATE TABLE IF NOT EXISTS RecipeIngredient(
	RecipeID int NOT NULL,
	IngredientID int NOT NULL,
	AmountInRecipe int NOT NULL);



-- Horse Radish
INSERT Ingredient (Name, Quantity) VALUES ('Horse Radish', 30);
SELECT LAST_INSERT_ID() INTO @beet_id;

-- Beets
INSERT Ingredient (Name, Quantity) VALUES ('Beets', 20);
SELECT LAST_INSERT_ID() INTO @horse_radish_id;

-- Horse radish beer
INSERT Recipe(Name, Style, Version, IBU, ABV) VALUES ('Pickled Beet and Horseradish Beer', 'realy bad', 1, 90, 50);
SELECT LAST_INSERT_ID() INTO @horse_radish_beer_id;
INSERT INTO RecipeIngredient (RecipeID, IngredientID, AmountInRecipe) VALUES (@horse_radish_beer_id, @horse_radish_id, 43);
INSERT INTO RecipeIngredient (RecipeID, IngredientID, AmountInRecipe) VALUES (@horse_radish_beer_id, @beet_id, 20);


-- Densier beer
INSERT Ingredient (Name, Quantity) VALUES ('POTATO', 45);
SELECT LAST_INSERT_ID() INTO @potato_id;
INSERT Recipe(Name, Style, Version, IBU, ABV) VALUES ('densier', 'ok', 1, 20, 4);
SELECT LAST_INSERT_ID() INTO @densier_beer_id;
INSERT INTO RecipeIngredient (RecipeID, IngredientID, AmountInRecipe) VALUES (@densier_beer_id, @potato_id, 9999);


INSERT INTO Brew (RecipeID, ScheduledDate, Done) VALUES (@densier_beer_id, '2021-12-21', FALSE);


SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS; 
SET FOREIGN_KEY_CHECKS=0;   

ALTER TABLE Brew ADD CONSTRAINT FK_Brew_Recipe FOREIGN KEY(RecipeID)
REFERENCES Recipe (RecipeID)
	ON DELETE CASCADE;

ALTER TABLE RecipeIngredient ADD CONSTRAINT FK_RecipeIngredient_Recipe FOREIGN KEY(RecipeID)
REFERENCES Recipe (RecipeID)
	ON DELETE CASCADE;


ALTER TABLE RecipeIngredient ADD CONSTRAINT FK_RecipeIngredient_Ingredient FOREIGN KEY(IngredientID)
REFERENCES Ingredient (IngredientID)
	ON DELETE CASCADE;


ALTER TABLE Recipe ADD CONSTRAINT FK_Recipe_Brew FOREIGN KEY(RecipeID)
REFERENCES Recipe (RecipeID)
	ON DELETE CASCADE;

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;

DELIMITER //
CREATE PROCEDURE usp_testing_reset_data()
BEGIN
        SET FOREIGN_KEY_CHECKS=0;   
        DROP TABLE Recipe;
        DROP TABLE Brew;
        DROP TABLE Ingredient;
        DROP TABLE RecipeIngredient;
        SET FOREIGN_KEY_CHECKS=0;   


        CREATE TABLE IF NOT EXISTS Recipe (
            RecipeID int AUTO_INCREMENT Primary key NOT NULL,
            Name varchar(100) NOT NULL,
            Style varchar(20) NOT NULL,
            Version int NOT NULL,
            IBU DECIMAL(10,4) NOT NULL,
            ABV DECIMAL(10,4) NOT NULL,
            Active bool NOT NULL DEFAULT TRUE);

        CREATE TABLE IF NOT EXISTS Brew (
            BrewID int AUTO_INCREMENT Primary key NOT NULL,
            RecipeID int NOT NULL,
            ScheduledDate DATE NOT NULL,
            Done bool NOT NULL DEFAULT FALSE);


        CREATE TABLE IF NOT EXISTS Ingredient (
            IngredientID int AUTO_INCREMENT Primary key NOT NULL,
            Name varchar(40) NOT NULL,
            Quantity int NOT NULL);

        CREATE TABLE IF NOT EXISTS RecipeIngredient(
            RecipeID int NOT NULL,
            IngredientID int NOT NULL,
            AmountInRecipe int NOT NULL);



        -- Horse Radish
        INSERT Ingredient (Name, Quantity) VALUES ('Horse Radish', 30);
        SELECT LAST_INSERT_ID() INTO @beet_id;

        -- Beets
        INSERT Ingredient (Name, Quantity) VALUES ('Beets', 20);
        SELECT LAST_INSERT_ID() INTO @horse_radish_id;

        -- Horse radish beer
        INSERT Recipe(Name, Style, Version, IBU, ABV) VALUES ('Pickled Beet and Horseradish Beer', 'realy bad', 1, 90, 50);
        SELECT LAST_INSERT_ID() INTO @horse_radish_beer_id;
        INSERT INTO RecipeIngredient (RecipeID, IngredientID, AmountInRecipe) VALUES (@horse_radish_beer_id, @horse_radish_id, 43);
        INSERT INTO RecipeIngredient (RecipeID, IngredientID, AmountInRecipe) VALUES (@horse_radish_beer_id, @beet_id, 20);


        -- Densier beer
        INSERT Ingredient (Name, Quantity) VALUES ('POTATO', 45);
        SELECT LAST_INSERT_ID() INTO @potato_id;
        INSERT Recipe(Name, Style, Version, IBU, ABV) VALUES ('densier', 'ok', 1, 20, 4);
        SELECT LAST_INSERT_ID() INTO @densier_beer_id;
        INSERT INTO RecipeIngredient (RecipeID, IngredientID, AmountInRecipe) VALUES (@densier_beer_id, @potato_id, 9999);


        INSERT INTO Brew (RecipeID, ScheduledDate, Done) VALUES (@densier_beer_id, '2021-12-21', FALSE);


        SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS; 
        SET FOREIGN_KEY_CHECKS=0;   

        ALTER TABLE Brew ADD CONSTRAINT FK_Brew_Recipe FOREIGN KEY(RecipeID)
        REFERENCES Recipe (RecipeID)
            ON DELETE CASCADE;

        ALTER TABLE RecipeIngredient ADD CONSTRAINT FK_RecipeIngredient_Recipe FOREIGN KEY(RecipeID)
        REFERENCES Recipe (RecipeID)
            ON DELETE CASCADE;


        ALTER TABLE RecipeIngredient ADD CONSTRAINT FK_RecipeIngredient_Ingredient FOREIGN KEY(IngredientID)
        REFERENCES Ingredient (IngredientID)
            ON DELETE CASCADE;


        ALTER TABLE Recipe ADD CONSTRAINT FK_Recipe_Brew FOREIGN KEY(RecipeID)
        REFERENCES Recipe (RecipeID)
            ON DELETE CASCADE;

        SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
END//

