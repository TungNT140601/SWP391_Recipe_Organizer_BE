CREATE TABLE [dbo].[Country](
	[CountryId] [nvarchar](20) NOT NULL,
	[CountryName] [nvarchar](255) NULL,
	[HasRecipe] [bit] DEFAULT 0,
	[IsDelete] [bit] DEFAULT 0,
	CONSTRAINT [PK_Country] PRIMARY KEY ([CountryId])
);

CREATE TABLE [dbo].[UserAccount](
	[UserId] [nvarchar](20) NOT NULL,
	[Username] [nvarchar](255) NULL,
	[UserInfo] [text] NULL,
	[FullName] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NULL,
	[AvatarName] [nvarchar](255) NULL,
	[GoogleToken] [nvarchar](255) NULL,
	[PhoneNum] [nvarchar](10) NULL,
	[Address] [nvarchar](255) NULL,
	[Password] [nvarchar](255) NULL,
	[CreateDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[IsDelete] [bit] DEFAULT 0,
	[Role] [int] NOT NULL DEFAULT 1,
	CONSTRAINT [PK_UserAccount] PRIMARY KEY ([UserId])
);

CREATE TABLE [dbo].[Ingredient](
	[IngredientId] [nvarchar](20) NOT NULL,
	[IngredientName] [nvarchar](255) NULL,
	[IsDelete] [bit] DEFAULT 0,
	CONSTRAINT [PK_Ingredient] PRIMARY KEY ([IngredientId])
);

CREATE TABLE [dbo].[Meal](
	[MealId] [nvarchar](20) NOT NULL,
	[MealName] [nvarchar](255) NULL,
	[IsDelete] [bit] DEFAULT 0,
	CONSTRAINT [PK_Meal] PRIMARY KEY ([MealId])
);

CREATE TABLE [dbo].[Nutrition](
	[NutritionId] [nvarchar](20) NOT NULL,
	[NutritionName] [nvarchar](255) NULL,
	[IsDelete] [bit] DEFAULT 0,
	CONSTRAINT [PK_Nutrition] PRIMARY KEY ([NutritionId])
);

CREATE TABLE [dbo].[Plan](
	[PlanId] [nvarchar](20) NOT NULL,
	[UserId] [nvarchar](20) NULL,
	[CreateTime] [datetime] NULL,
	[UpdateTime] [datetime] NULL,
	[DeleteTime] [datetime] NULL,
	[IsDelete] [bit] DEFAULT 0,
	[PlanName] [nvarchar](255) NULL,
	[PlanDescription] [text] NULL,
	CONSTRAINT [PK_Plan] PRIMARY KEY ([PlanId]),
	CONSTRAINT [FK_Plan_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[UserAccount] ([UserId])
);

CREATE TABLE [dbo].[Recipe](
	[RecipeId] [nvarchar](20) NOT NULL,
	[RecipeName] [nvarchar](255) NULL,
	[UserId] [nvarchar](20) NULL,
	[CountryId] [nvarchar](20) NULL,
	[MealId] [nvarchar](20) NULL,
	[Description] [text] NULL,
	[PrepTime] [int] NULL,
	[CookTime] [int] NULL,
	[StandTime] [int] NULL,
	[TotalTime] [int] NULL,
	[Servings] [int] NULL,
	[CreateTime] [datetime] NULL,
	[UpdateTime] [datetime] NULL,
	[DeleteTime] [datetime] NULL,
	[IsDelete] [bit] DEFAULT 0,
	CONSTRAINT [PK_Recipe] PRIMARY KEY ([RecipeId]),
	CONSTRAINT [FK_Recipe_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[UserAccount] ([UserId]),
	CONSTRAINT [FK_Recipe_Country] FOREIGN KEY ([CountryId]) REFERENCES [dbo].[Country] ([CountryId]),
	CONSTRAINT [FK_Recipe_Meal] FOREIGN KEY ([MealId]) REFERENCES [dbo].[Meal] ([MealId])
);

CREATE TABLE [dbo].[Direction](
	[DirectionsId] [nvarchar](20) NOT NULL,
	[RecipeId] [nvarchar](20) NULL,
	[DirectionsNum] [int] NULL,
	[DirectionsDesc] [nvarchar](255) NULL,
	CONSTRAINT [PK_Direction] PRIMARY KEY ([DirectionsId]),
	CONSTRAINT [FK_Direction_Recipe] FOREIGN KEY ([RecipeId]) REFERENCES [dbo].[Recipe] ([RecipeId])
);

CREATE TABLE [dbo].[FavoriteRecipe](
	[FavoriteId] [nvarchar](20) NOT NULL,
	[UserId] [nvarchar](20) NULL,
	[RecipeId] [nvarchar](20) NULL,
	[FavoriteTime] [datetime] NULL,
	CONSTRAINT [PK_FavoriteRecipe] PRIMARY KEY ([FavoriteId]),
	CONSTRAINT [FK_FavoriteRecipe_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[UserAccount] ([UserId]),
	CONSTRAINT [FK_FavoriteRecipe_Recipe] FOREIGN KEY ([RecipeId]) REFERENCES [dbo].[Recipe] ([RecipeId])
);

CREATE TABLE [dbo].[IngredientOfRecipe](
	[IngredientId] [nvarchar](20) NOT NULL,
	[RecipeId] [nvarchar](20) NOT NULL,
	[Description] [nvarchar](255) NULL,
	CONSTRAINT [PK_IngredientOfRecipe] PRIMARY KEY ([IngredientId], [RecipeId]),
	CONSTRAINT [FK_IngredientOfRecipe_Ingredient] FOREIGN KEY ([IngredientId]) REFERENCES [dbo].[Ingredient] ([IngredientId]),
	CONSTRAINT [FK_IngredientOfRecipe_Recipe] FOREIGN KEY ([RecipeId]) REFERENCES [dbo].[Recipe] ([RecipeId])
);

CREATE TABLE [dbo].[NutritionInRecipe](
	[NutritionId] [nvarchar](20) NOT NULL,
	[RecipeId] [nvarchar](20) NOT NULL,
	[Quantity] [int] NULL,
	CONSTRAINT [PK_NutritionInRecipe] PRIMARY KEY ([NutritionId], [RecipeId]),
	CONSTRAINT [FK_NutritionInRecipe_Nutrition] FOREIGN KEY ([NutritionId]) REFERENCES [dbo].[Nutrition] ([NutritionId]),
	CONSTRAINT [FK_NutritionInRecipe_Recipe] FOREIGN KEY ([RecipeId]) REFERENCES [dbo].[Recipe] ([RecipeId])
);

CREATE TABLE [dbo].[Photo](
	[PhotoId] [nvarchar](20) NOT NULL,
	[PhotoName] [nvarchar](255) NULL,
	[RecipeId] [nvarchar](20) NULL,
	[UserId] [nvarchar](20) NULL,
	[UploadTime] [datetime] NULL,
	[IsDelete] [bit] DEFAULT 0,
	CONSTRAINT [PK_Photo] PRIMARY KEY ([PhotoId]),
	CONSTRAINT [FK_Photo_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[UserAccount] ([UserId]),
	CONSTRAINT [FK_Photo_Recipe] FOREIGN KEY ([RecipeId]) REFERENCES [dbo].[Recipe] ([RecipeId])
);

CREATE TABLE [dbo].[PlanDetail](
	[PlanDetailId] [nvarchar](20) NOT NULL,
	[PlanId] [nvarchar](20) NULL,
	[RecipeId] [nvarchar](20) NULL,
	[Date] [datetime] NULL,
	[MealOfDate] [int] NULL,
	CONSTRAINT [PK_PlanDetail] PRIMARY KEY ([PlanDetailId]),
	CONSTRAINT [FK_PlanDetail_Plan] FOREIGN KEY ([PlanId]) REFERENCES [dbo].[Plan] ([PlanId]),
	CONSTRAINT [FK_PlanDetail_Recipe] FOREIGN KEY ([RecipeId]) REFERENCES [dbo].[Recipe] ([RecipeId])
);

CREATE TABLE [dbo].[Review](
	[ReviewId] [nvarchar](20) NOT NULL,
	[UserId] [nvarchar](20) NULL,
	[RecipeId] [nvarchar](20) NULL,
	[CreateTime] [datetime] NULL,
	[UpdateTime] [datetime] NULL,
	[VoteNum] [int] NULL,
	[Comment] [text] NULL,
	CONSTRAINT [PK_Review] PRIMARY KEY ([ReviewId]),
	CONSTRAINT [FK_Review_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[UserAccount] ([UserId]),
	CONSTRAINT [FK_Review_Recipe] FOREIGN KEY ([RecipeId]) REFERENCES [dbo].[Recipe] ([RecipeId])
);

