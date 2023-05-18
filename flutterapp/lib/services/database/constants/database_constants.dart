const dbName = "pokemon.db";
const pokemonTable = "pokemon";
const descriptionTable = "description";
const favoriteTable = "favorite";

// Pokemon
const idColumn = "id";
const nameColumn = "name";
const speciesColumn = "species";
const spritesColumn = "sprites";
const statsColumn = "stats";
const typesColumn = "types";
const heightColumn = "height";
const weightColumn = "weight";

//Description
const descriptionIdColumn = "description_id";
const descriptionColumn = "description";

// Favorite
const pokemonNameColumn = "pokemonName";

// Table creations
const createPokemonTable = """ CREATE TABLE IF NOT EXISTS "pokemon" (
        "id" INTEGER NOT NULL,
        "name" TEXT NOT NULL UNIQUE,
        "species" TEXT NOT NULL UNIQUE,
        "sprites" TEXT NOT NULL UNIQUE,
        "stats" TEXT NOT NULL UNIQUE,
        "types" TEXT NOT NULL UNIQUE,
        "height" INTEGER NOT NULL,
        "weight" INTEGER NOT NULL,
        PRIMARY KEY("id" AUTOINCREMENT)
      );""";

const createDescriptionTable = """ CREATE TABLE IF NOT EXISTS "description" (
        "description_id" INTEGER NOT NULL,
        "description" TEXT NOT NULL UNIQUE,
        FOREIGN KEY("description_id") REFERENCES "pokemon"("id"),
        PRIMARY KEY("description_id" AUTOINCREMENT)
      );""";

const createFavoriteTable = """ CREATE TABLE IF NOT EXISTS "favorite" (
        "pokemonName" TEXT NOT NULL UNIQUE,
        PRIMARY KEY("pokemonName" AUTOINCREMENT)
      );""";
