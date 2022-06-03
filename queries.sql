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

/* Writing queries using JOIN */
--what animals belong to Melody Pond?
SELECT name FROM owners
JOIN animals ON owners.id = animals.owner_id 
WHERE full_name='Melody Pond';

--List of all animals that are pokemon(their type is Pokemon)
SELECT animals.name FROM species 
JOIN animals ON species.id = animals.species_id 
WHERE species.name = 'Pokemon';

--Listing all owners and their animals, including even those that don't own any animal.
SELECT owners.full_name, animals.name 
FROM owners 
LEFT JOIN animals ON owners.id = animals.owner_id;

--How many animals are there per species?
SELECT species.name, COUNT(animals.name)
FROM species 
JOIN animals 
ON species.id = animals.species_id 
GROUP BY species.name;

--All Digimon owned by Jennifer Orwell.
SELECT animals.name 
FROM species 
JOIN animals 
ON species.id = animals.species_id JOIN owners ON owners.id = animals.owner_id   
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

--All animals owned by Dean Winchester that never escaped.
SELECT animals.name 
FROM owners 
JOIN animals 
ON owners.id = animals.owner_id 
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT full_name FROM owners 
JOIN animals ON  owners.id = animals.owner_id 
GROUP BY full_name 
ORDER BY COUNT(name) DESC;


-- Writing queries for join-table visits
-- Who was the last animal seen by William Tatcher?
SELECT animals.name FROM animals 
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_visit DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT (animals.name) FROM animals 
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT COUNT (animals.name) FROM animals 
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Stephanie Mendez';

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, visits.date_visit FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Stephanie Mendez' AND visits.date_visit BETWEEN 'April 1, 2020' AND 'Aug 30, 2020';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(*) FROM visits 
JOIN animals ON animals.id = visits.animals_id
GROUP BY animals.name
ORDER BY count DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_visit ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, vets.name, visits.date_visit FROM animals 
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id 
ORDER BY visits.date_visit DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM species  
JOIN specializations ON species.id = specializations.species_id
RIGHT JOIN vets ON vets.id = specializations.vets_id
JOIN visits ON visits.vets_id = vets.id
WHERE species.name IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name FROM vets 
JOIN visits ON visits.vets_id = vets.id
JOIN animals ON animals.id = visits.animals_id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY (species.name)
ORDER BY COUNT (species.name) DESC
Limit 1;
  
