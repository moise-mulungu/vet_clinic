/*Queries that provide answers to the questions from all projects.*/

-- Animals which name end with "mon"
SELECT * FROM animals WHERE name LIKE '%mon';

-- Date of birth between january 2016 to December 2019
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- Animals whose neutered value is true and escape attempts less than 3
SELECT * FROM animals WHERE neutered='true' AND escape_attempts < 3;

-- date of birth with AGunom and Pikachu
SELECT date_of_birth from animals WHERE name='Agumon' OR name='Pikachu';

-- Animals whose neutered is true
SELECT * FROM animals WHERE neutered = 'true';

-- Animals not having Gabumon as name
SELECT * FROM animals WHERE name <> 'Gabumon';

-- Animals weighing from 10.4 to 17.3kg
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

--TRANSACTION
-- set species to unspecified
BEGIN;
UPDATE animals
SET species = 'unspecified';

--Verify if the change was made
SELECT * FROM animals;

--rollback the change
ROLLBACK;

--verify if the changes was rolledback
SELECT * FROM animals;

--Update species column to digimon for all animals that have a name ending in 'mon'. 
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

-- Update species column to pokemon for all animals that don't have species already set.
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;

--Verify if the change was made and persists after commit.
SELECT * FROM animals;

--delete all records in the animals table
BEGIN;
DELETE from animals;
ROLLBACK;

--verify if the changes was rolledback
SELECT * FROM animals;

--Delete all animals born after Jan 1st, 2022.
BEGIN;
DELETE FROM animals
WHERE date_of_birth >= '2022-01-01';

--Create a savepoint for the transaction.
SAVEPOINT deleteAnimalsBornAfterJan2022;

--Update all animals' weight to be their weight multiplied by -1.
UPDATE animals
SET weight_kg = weight_kg * -1;

--Rollback to the savepoint  commit
ROLLBACK TO deleteAnimalsBornAfterJan2022;

--Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

--commit
COMMIT;

-- WRITING QUERIES
--Count number of animals 
SELECT COUNT(*) FROM animals;
-- or
SELECT COUNT(name) FROM animals;

--Count number of animals that have not attempted escape 
SELECT 
COUNT(*) FROM animals 
WHERE escape_attempts = 0;

--Avarage weight of animals 
SELECT AVG(weight_kg) FROM animals;

--Sum of escape attempts and compare between neutered and non-neutered
SELECT 
neutered, SUM(escape_attempts) 
FROM animals 
GROUP BY neutered;

--Minimum and maximum weights of each type of animal
SELECT 
species, MIN(weight_kg), MAX(weight_kg) 
FROM animals 
GROUP BY species;

--Average number of escape attempts per animal type of those born between 1990 and 2000 
SELECT 
species, AVG(escape_attempts) 
FROM animals 
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' 
GROUP BY species;
