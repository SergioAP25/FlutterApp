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
        "name" TEXT NOT NULL,
        "species" TEXT NOT NULL,
        "sprites" TEXT NOT NULL,
        "stats" TEXT NOT NULL,
        "types" TEXT NOT NULL,
        "height" INTEGER NOT NULL,
        "weight" INTEGER NOT NULL,
        PRIMARY KEY("id" AUTOINCREMENT)
      );""";

const createDescriptionTable = """ CREATE TABLE IF NOT EXISTS "description" (
        "description_id" INTEGER NOT NULL,
        "description" TEXT NOT NULL UNIQUE,
        FOREIGN KEY("description_id") REFERENCES "pokemon"("id"),
        PRIMARY KEY("description_id")
      );""";

const createFavoriteTable = """ CREATE TABLE IF NOT EXISTS "favorite" (
        "pokemonName" TEXT NOT NULL UNIQUE,
        PRIMARY KEY("pokemonName")
      );""";

// Querys

