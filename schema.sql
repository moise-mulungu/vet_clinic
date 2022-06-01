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
full_name VARCHAR(100),
age INT);

-- Create species table
CREATE TABLE species(
id SERIAL NOT NULL PRIMARY KEY,
name VARCHAR(100));
