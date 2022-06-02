/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agmun', '2020-02-03', 0, true, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-03', 2, true, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2021-05-12', 5, true, 11);

-- Adding new insertions
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2020-02-08', 0, false, -11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2021-11-15', 2, true, -5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '1993-04-02', 3, false, -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '2005-07-12', 1, true, -45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '2005-06-07', 7, true, 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '1998-10-13', 3, true, 17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '2022-05-14', 4, true, 22);

-- Insert data in owners table
INSERT INTO owners(full_name, age) VALUES 
('Sam Smith', 34), 
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whitaker', 38);

-- Insert data in species table
INSERT INTO species(name) VALUES
('Pokemon'),
('Digimon');

--Modify the inserted animals so it includes the species_id value
-- If the name ends in "mon" it will be Digimon
UPDATE animals
set species_id = (SELECT id from species where name = 'Digimon')
WHERE name LIKE '%mon';

--All other animals are Pokemon
UPDATE animals
set species_id = (SELECT id from species where name = 'Pokemon')
WHERE species_id IS NULL;

--Modify the inserted animals to include owner information (owner_id);
-- Sam Smith owns Agumon.
UPDATE animals
set owner_id = (SELECT id from owners where full_name = 'Sam Smith')
WHERE name='Agumon';

--Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals
set owner_id = (SELECT id from owners where full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon','Pikachu');

--Bob owns Devimon and Plantmon
UPDATE animals
set owner_id = (SELECT id from owners where full_name = 'Bob')
WHERE name IN ('Devimon','Plantmon');

--Melody Pond owns Charmander,Squirtle and Blossom
UPDATE animals
set owner_id = (SELECT id from owners where full_name = 'Melody Pond')
WHERE name IN ('Charmander','Squirtle','Blossom');

--Dean Winchester owns Angemon and Boarmon
UPDATE animals
set owner_id = (SELECT id from owners where full_name = 'Dean Winchester')
WHERE name IN ('Angemon','Boarmon');

NSERT INTO vets(name, age, date_of_graduation) VALUES
('William Tatche', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-01-08');
