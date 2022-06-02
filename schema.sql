/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INTEGER NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL
);

-- Adding a species column
ALTER TABLE animals
ADD COLUMN species VARCHAR(100);

-- Create owners table
CREATE TABLE owners(
id SERIAL NOT NULL PRIMARY KEY,
full_name VARCHAR(100) NOT NULL,
age INT NOT NULL
);

-- Create species table
CREATE TABLE species(
id SERIAL NOT NULL PRIMARY KEY,
name VARCHAR(100) NOT NULL
);

-- Modifying animals table
-- Remove the species column
ALTER TABLE animals
DROP COLUMN species;

-- Add a species_id column
ALTER TABLE animals
    ADD COLUMN species_id INT;
    ADD CONSTRAINT fk_species_id 
    FOREIGN KEY (species_id) 
    REFERENCES species(id);

-- Add a owner_id column
ALTER TABLE animals
    ADD COLUMN owner_id INT;
    ADD CONSTRAINT fk_owner_id
    FOREIGN KEY (owner_id)
    REFERENCES owners(id);

-- ADD "join table" FOR VISITS
-- Create vets table
CREATE TABLE vets(
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    date_of_graduation DATE NOT NULL
);

-- Create a 'join-table' named specialization
    CREATE TABLE specializations(
    vets_id INT NOT NULL,
    species_id INT NOT NULL,
    CONSTRAINT fk_species 
        FOREIGN KEY (species_id) 
        REFERENCES species(id),
    CONSTRAINT fk_vets 
        FOREIGN KEY (vets_id) 
        REFERENCES vets(id)
);

-- Create another join-table named visits 
CREATE TABLE visits(
    vets_id INT NOT NULL,
    animals_id INT NOT NULL,
    CONSTRAINT fk_animals 
        FOREIGN KEY (animals_id) 
        REFERENCES animals (id),
    CONSTRAINT fk_vets 
        FOREIGN KEY (vets_id) 
        REFERENCES vets (id)
);

-- Adding a missing column to the visits table
ALTER TABLE visits
ADD COLUMN date_visit DATE NOT NULL;


