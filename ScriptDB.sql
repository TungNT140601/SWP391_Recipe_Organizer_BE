Create database RecipeOrganizerDB
Go

Use RecipeOrganizerDB
Go

-- UserAccount Table
CREATE TABLE UserAccount (
    UserId NVARCHAR(20) PRIMARY KEY,
    Username NVARCHAR(255) NULL,
    UserInfo TEXT NULL,
    FullName NVARCHAR(255) NULL,
    Email NVARCHAR(255) NULL,
    AvatarName NVARCHAR(255) NULL,
    GoogleToken NVARCHAR(255) NULL,
    PhoneNum NVARCHAR(10) NULL,
    Address NVARCHAR(255) NULL,
    Password NVARCHAR(255) NULL,
    CreateDate DATETIME NULL,
    UpdateDate DATETIME NULL,
    IsDelete BIT DEFAULT 0,
    Role INT DEFAULT 1
);

-- Country Table
CREATE TABLE Country (
    CountryId NVARCHAR(20) PRIMARY KEY,
    CountryName NVARCHAR(255) NULL,
    HasRecipe BIT DEFAULT 0
);

-- Meal Table
CREATE TABLE Meal (
    MealId NVARCHAR(20) PRIMARY KEY,
    MealName NVARCHAR(255) NULL
);

-- Ingredient Table
CREATE TABLE Ingredient (
    IngredientId NVARCHAR(20) PRIMARY KEY,
    IngredientName NVARCHAR(255) NULL
);

-- Recipe Table
CREATE TABLE Recipe (
    RecipeId NVARCHAR(20) PRIMARY KEY,
    RecipeName NVARCHAR(255) NULL,
    UserId NVARCHAR(20),
    CountryId NVARCHAR(20),
    MealId NVARCHAR(20),
    Description TEXT NULL,
    PrepTime INT NULL,
    CookTime INT NULL,
    StandTime INT NULL,
    TotalTime INT NULL,
    Servings INT NULL,
    CreateTime DATETIME,
    UpdateTime DATETIME NULL,
    DeleteTime DATETIME NULL,
    IsDelete BIT DEFAULT 0,
    FOREIGN KEY (UserId) REFERENCES UserAccount(UserId),
    FOREIGN KEY (CountryId) REFERENCES Country(CountryId),
    FOREIGN KEY (MealId) REFERENCES Meal(MealId)
);

-- Photo Table
CREATE TABLE Photo (
    PhotoId NVARCHAR(20) PRIMARY KEY,
    PhotoName NVARCHAR(255) NULL,
    RecipeId NVARCHAR(20),
    UserId NVARCHAR(20),
    UploadTime DATETIME NULL,
    FOREIGN KEY (RecipeId) REFERENCES Recipe(RecipeId),
    FOREIGN KEY (UserId) REFERENCES UserAccount(UserId)
);

-- IngredientOfRecipe Table
CREATE TABLE IngredientOfRecipe (
    IngredientId NVARCHAR(20),
    RecipeId NVARCHAR(20),
    Description NVARCHAR(255) NULL,
    FOREIGN KEY (IngredientId) REFERENCES Ingredient(IngredientId),
    FOREIGN KEY (RecipeId) REFERENCES Recipe(RecipeId)
);

-- Direction Table
CREATE TABLE Direction (
    DirectionsId NVARCHAR(20) PRIMARY KEY,
    RecipeId NVARCHAR(20),
    DirectionsNum INT NULL,
    DirectionsDesc NVARCHAR(255) NULL,
    FOREIGN KEY (RecipeId) REFERENCES Recipe(RecipeId)
);

-- Review Table
CREATE TABLE Review (
    ReviewId NVARCHAR(20) PRIMARY KEY,
    UserId NVARCHAR(20),
    RecipeId NVARCHAR(20),
    CreateTime DATETIME NULL,
    UpdateTime DATETIME NULL,
    FOREIGN KEY (UserId) REFERENCES UserAccount(UserId),
    FOREIGN KEY (RecipeId) REFERENCES Recipe(RecipeId)
);

-- Nutrition Table
CREATE TABLE Nutrition (
    NutritionId NVARCHAR(20) PRIMARY KEY,
    NutritionName NVARCHAR(255) NULL
);

-- NutritionInRecipe Table
CREATE TABLE NutritionInRecipe (
    NutritionId NVARCHAR(20),
    RecipeId NVARCHAR(20),
    Quantity INT NULL,
    FOREIGN KEY (NutritionId) REFERENCES Nutrition(NutritionId),
    FOREIGN KEY (RecipeId) REFERENCES Recipe(RecipeId)
);

-- FavoriteRecipe Table
CREATE TABLE FavoriteRecipe (
    FavoriteId NVARCHAR(20) PRIMARY KEY,
    UserId NVARCHAR(20),
    RecipeId NVARCHAR(20),
    FavoriteTime DATETIME NULL,
    FOREIGN KEY (UserId) REFERENCES UserAccount(UserId),
    FOREIGN KEY (RecipeId) REFERENCES Recipe(RecipeId)
);

-- Plan Table
CREATE TABLE [Plan] (
    PlanId NVARCHAR(20) PRIMARY KEY,
    UserId NVARCHAR(20),
    CreateTime DATETIME NULL,
    UpdateTime DATETIME NULL,
    DeleteTime DATETIME NULL,
    IsDelete BIT NULL,
    FOREIGN KEY (UserId) REFERENCES UserAccount(UserId)
);

-- PlanDetail Table
CREATE TABLE PlanDetail (
    PlanDetailId NVARCHAR(20) PRIMARY KEY,
    PlanId NVARCHAR(20),
    RecipeId NVARCHAR(20),
    Date DATETIME NULL,
    MealOfDate INT NULL,
    FOREIGN KEY (PlanId) REFERENCES [Plan](PlanId),
    FOREIGN KEY (RecipeId) REFERENCES Recipe(RecipeId)
);
