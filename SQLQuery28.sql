USE [master]
GO
/****** Object:  Database [RecipeOrganizerDB]    Script Date: 8/9/2023 1:24:20 PM ******/
CREATE DATABASE [RecipeOrganizerDB]
GO
ALTER DATABASE [RecipeOrganizerDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RecipeOrganizerDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RecipeOrganizerDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [RecipeOrganizerDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RecipeOrganizerDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RecipeOrganizerDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [RecipeOrganizerDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RecipeOrganizerDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [RecipeOrganizerDB] SET  MULTI_USER 
GO
ALTER DATABASE [RecipeOrganizerDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RecipeOrganizerDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RecipeOrganizerDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [RecipeOrganizerDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [RecipeOrganizerDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [RecipeOrganizerDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [RecipeOrganizerDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [RecipeOrganizerDB]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 8/9/2023 1:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[CountryId] [nvarchar](20) NOT NULL,
	[CountryName] [nvarchar](255) NULL,
	[HasRecipe] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Direction]    Script Date: 8/9/2023 1:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Direction](
	[DirectionsId] [nvarchar](20) NOT NULL,
	[RecipeId] [nvarchar](20) NULL,
	[DirectionsNum] [int] NULL,
	[DirectionsDesc] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[DirectionsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FavoriteRecipe]    Script Date: 8/9/2023 1:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FavoriteRecipe](
	[FavoriteId] [nvarchar](20) NOT NULL,
	[UserId] [nvarchar](20) NULL,
	[RecipeId] [nvarchar](20) NULL,
	[FavoriteTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[FavoriteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ingredient]    Script Date: 8/9/2023 1:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingredient](
	[IngredientId] [nvarchar](20) NOT NULL,
	[IngredientName] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[IngredientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IngredientOfRecipe]    Script Date: 8/9/2023 1:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IngredientOfRecipe](
	[IngredientId] [nvarchar](20) NULL,
	[RecipeId] [nvarchar](20) NULL,
	[Description] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Meal]    Script Date: 8/9/2023 1:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Meal](
	[MealId] [nvarchar](20) NOT NULL,
	[MealName] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[MealId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nutrition]    Script Date: 8/9/2023 1:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nutrition](
	[NutritionId] [nvarchar](20) NOT NULL,
	[NutritionName] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[NutritionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NutritionInRecipe]    Script Date: 8/9/2023 1:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NutritionInRecipe](
	[NutritionId] [nvarchar](20) NULL,
	[RecipeId] [nvarchar](20) NULL,
	[Quantity] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Photo]    Script Date: 8/9/2023 1:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Photo](
	[PhotoId] [nvarchar](20) NOT NULL,
	[PhotoName] [nvarchar](255) NULL,
	[RecipeId] [nvarchar](20) NULL,
	[UserId] [nvarchar](20) NULL,
	[UploadTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PhotoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Plan]    Script Date: 8/9/2023 1:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plan](
	[PlanId] [nvarchar](20) NOT NULL,
	[UserId] [nvarchar](20) NULL,
	[CreateTime] [datetime] NULL,
	[UpdateTime] [datetime] NULL,
	[DeleteTime] [datetime] NULL,
	[IsDelete] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PlanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlanDetail]    Script Date: 8/9/2023 1:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlanDetail](
	[PlanDetailId] [nvarchar](20) NOT NULL,
	[PlanId] [nvarchar](20) NULL,
	[RecipeId] [nvarchar](20) NULL,
	[Date] [datetime] NULL,
	[MealOfDate] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PlanDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recipe]    Script Date: 8/9/2023 1:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	[IsDelete] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[RecipeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Review]    Script Date: 8/9/2023 1:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Review](
	[ReviewId] [nvarchar](20) NOT NULL,
	[UserId] [nvarchar](20) NULL,
	[RecipeId] [nvarchar](20) NULL,
	[CreateTime] [datetime] NULL,
	[UpdateTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReviewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAccount]    Script Date: 8/9/2023 1:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	[IsDelete] [bit] NULL,
	[Role] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Country] ADD  DEFAULT ((0)) FOR [HasRecipe]
GO
ALTER TABLE [dbo].[Recipe] ADD  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [dbo].[UserAccount] ADD  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [dbo].[UserAccount] ADD  DEFAULT ((1)) FOR [Role]
GO
ALTER TABLE [dbo].[Direction]  WITH CHECK ADD FOREIGN KEY([RecipeId])
REFERENCES [dbo].[Recipe] ([RecipeId])
GO
ALTER TABLE [dbo].[FavoriteRecipe]  WITH CHECK ADD FOREIGN KEY([RecipeId])
REFERENCES [dbo].[Recipe] ([RecipeId])
GO
ALTER TABLE [dbo].[FavoriteRecipe]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[UserAccount] ([UserId])
GO
ALTER TABLE [dbo].[IngredientOfRecipe]  WITH CHECK ADD FOREIGN KEY([IngredientId])
REFERENCES [dbo].[Ingredient] ([IngredientId])
GO
ALTER TABLE [dbo].[IngredientOfRecipe]  WITH CHECK ADD FOREIGN KEY([RecipeId])
REFERENCES [dbo].[Recipe] ([RecipeId])
GO
ALTER TABLE [dbo].[NutritionInRecipe]  WITH CHECK ADD FOREIGN KEY([NutritionId])
REFERENCES [dbo].[Nutrition] ([NutritionId])
GO
ALTER TABLE [dbo].[NutritionInRecipe]  WITH CHECK ADD FOREIGN KEY([RecipeId])
REFERENCES [dbo].[Recipe] ([RecipeId])
GO
ALTER TABLE [dbo].[Photo]  WITH CHECK ADD FOREIGN KEY([RecipeId])
REFERENCES [dbo].[Recipe] ([RecipeId])
GO
ALTER TABLE [dbo].[Photo]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[UserAccount] ([UserId])
GO
ALTER TABLE [dbo].[Plan]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[UserAccount] ([UserId])
GO
ALTER TABLE [dbo].[PlanDetail]  WITH CHECK ADD FOREIGN KEY([PlanId])
REFERENCES [dbo].[Plan] ([PlanId])
GO
ALTER TABLE [dbo].[PlanDetail]  WITH CHECK ADD FOREIGN KEY([RecipeId])
REFERENCES [dbo].[Recipe] ([RecipeId])
GO
ALTER TABLE [dbo].[Recipe]  WITH CHECK ADD FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([CountryId])
GO
ALTER TABLE [dbo].[Recipe]  WITH CHECK ADD FOREIGN KEY([MealId])
REFERENCES [dbo].[Meal] ([MealId])
GO
ALTER TABLE [dbo].[Recipe]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[UserAccount] ([UserId])
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD FOREIGN KEY([RecipeId])
REFERENCES [dbo].[Recipe] ([RecipeId])
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[UserAccount] ([UserId])
GO
USE [master]
GO
ALTER DATABASE [RecipeOrganizerDB] SET  READ_WRITE 
GO
