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
