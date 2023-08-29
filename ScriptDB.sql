/****** Object:  Database [RecipeOrganizerDB]    Script Date: 8/29/2023 9:27:15 PM ******/
CREATE DATABASE [RecipeOrganizerDB]  (EDITION = 'Basic', SERVICE_OBJECTIVE = 'Basic', MAXSIZE = 2 GB) WITH CATALOG_COLLATION = SQL_Latin1_General_CP1_CI_AS, LEDGER = OFF;
GO
ALTER DATABASE [RecipeOrganizerDB] SET COMPATIBILITY_LEVEL = 160
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
ALTER DATABASE [RecipeOrganizerDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RecipeOrganizerDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RecipeOrganizerDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RecipeOrganizerDB] SET  MULTI_USER 
GO
ALTER DATABASE [RecipeOrganizerDB] SET ENCRYPTION ON
GO
ALTER DATABASE [RecipeOrganizerDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [RecipeOrganizerDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
/*** The scripts of database scoped configurations in Azure should be executed inside the target database connection. ***/
GO
-- ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 8;
GO
/****** Object:  Table [dbo].[Country]    Script Date: 8/29/2023 9:27:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[CountryId] [nvarchar](20) NOT NULL,
	[CountryName] [nvarchar](255) NULL,
	[HasRecipe] [bit] NULL,
	[IsDelete] [bit] NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Direction]    Script Date: 8/29/2023 9:27:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Direction](
	[DirectionsId] [nvarchar](20) NOT NULL,
	[RecipeId] [nvarchar](20) NULL,
	[DirectionsNum] [int] NULL,
	[DirectionsDesc] [text] NULL,
 CONSTRAINT [PK_Direction] PRIMARY KEY CLUSTERED 
(
	[DirectionsId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FavoriteRecipe]    Script Date: 8/29/2023 9:27:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FavoriteRecipe](
	[FavoriteId] [nvarchar](20) NOT NULL,
	[UserId] [nvarchar](20) NULL,
	[RecipeId] [nvarchar](20) NULL,
	[FavoriteTime] [datetime] NULL,
 CONSTRAINT [PK_FavoriteRecipe] PRIMARY KEY CLUSTERED 
(
	[FavoriteId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ingredient]    Script Date: 8/29/2023 9:27:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingredient](
	[IngredientId] [nvarchar](20) NOT NULL,
	[IngredientName] [nvarchar](255) NULL,
	[IsDelete] [bit] NULL,
	[Measure] [nvarchar](255) NULL,
	[Carbohydrate] [float] NULL,
	[Protein] [float] NULL,
	[Fat] [float] NULL,
	[Calories] [float] NULL,
 CONSTRAINT [PK_Ingredient] PRIMARY KEY CLUSTERED 
(
	[IngredientId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IngredientOfRecipe]    Script Date: 8/29/2023 9:27:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IngredientOfRecipe](
	[IngredientId] [nvarchar](20) NOT NULL,
	[RecipeId] [nvarchar](20) NOT NULL,
	[Quantity] [float] NULL,
 CONSTRAINT [PK_IngredientOfRecipe] PRIMARY KEY CLUSTERED 
(
	[IngredientId] ASC,
	[RecipeId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Meal]    Script Date: 8/29/2023 9:27:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Meal](
	[MealId] [nvarchar](20) NOT NULL,
	[MealName] [nvarchar](255) NULL,
	[IsDelete] [bit] NULL,
 CONSTRAINT [PK_Meal] PRIMARY KEY CLUSTERED 
(
	[MealId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Photo]    Script Date: 8/29/2023 9:27:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Photo](
	[PhotoId] [nvarchar](20) NOT NULL,
	[RecipeId] [nvarchar](20) NULL,
	[UserId] [nvarchar](20) NULL,
	[UploadTime] [datetime] NULL,
	[IsDelete] [bit] NULL,
	[PhotoName] [text] NULL,
 CONSTRAINT [PK_Photo] PRIMARY KEY CLUSTERED 
(
	[PhotoId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Plan]    Script Date: 8/29/2023 9:27:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plan](
	[PlanId] [nvarchar](20) NOT NULL,
	[UserId] [nvarchar](20) NULL,
	[PlanName] [nvarchar](255) NULL,
	[PlanDescription] [text] NULL,
	[CreateTime] [datetime] NULL,
	[UpdateTime] [datetime] NULL,
	[DeleteTime] [datetime] NULL,
	[IsDelete] [bit] NULL,
 CONSTRAINT [PK_Plan] PRIMARY KEY CLUSTERED 
(
	[PlanId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlanDetail]    Script Date: 8/29/2023 9:27:15 PM ******/
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
 CONSTRAINT [PK_PlanDetail] PRIMARY KEY CLUSTERED 
(
	[PlanDetailId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recipe]    Script Date: 8/29/2023 9:27:15 PM ******/
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
	[Carbohydrate] [int] NULL,
	[Protein] [int] NULL,
	[Fat] [int] NULL,
	[Calories] [int] NULL,
	[CreateTime] [datetime] NULL,
	[UpdateTime] [datetime] NULL,
	[DeleteTime] [datetime] NULL,
	[IsDelete] [bit] NULL,
 CONSTRAINT [PK_Recipe] PRIMARY KEY CLUSTERED 
(
	[RecipeId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Review]    Script Date: 8/29/2023 9:27:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Review](
	[ReviewId] [nvarchar](20) NOT NULL,
	[UserId] [nvarchar](20) NULL,
	[RecipeId] [nvarchar](20) NULL,
	[VoteNum] [int] NULL,
	[Comment] [text] NULL,
	[CreateTime] [datetime] NULL,
	[UpdateTime] [datetime] NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[ReviewId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAccount]    Script Date: 8/29/2023 9:27:15 PM ******/
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
	[Role] [int] NOT NULL,
 CONSTRAINT [PK_UserAccount] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AD', N'Andorra', 1, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AE', N'United Arab Emirates', 1, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AF', N'Afghanistan', 1, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AG', N'Antigua and Barbuda', 1, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AI', N'Anguilla', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AL', N'Albania', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AM', N'Armenia', 1, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AN', N'Netherlands Antilles', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AO', N'Angola', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AQ', N'Antarctica', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AR', N'Argentina', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AS', N'American Samoa', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AT', N'Austria', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AU', N'Australia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AW', N'Aruba', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AX', N'Aland Islands', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AZ', N'Azerbaijan', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BA', N'Bosnia and Herzegovina', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BB', N'Barbados', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BD', N'Bangladesh', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BE', N'Belgium', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BF', N'Burkina Faso', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BG', N'Bulgaria', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BH', N'Bahrain', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BI', N'Burundi', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BJ', N'Benin', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BL', N'Saint Barthelemy', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BM', N'Bermuda', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BN', N'Brunei Darussalam', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BO', N'Bolivia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BQ', N'Bonaire, Sint Eustatius and Saba', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BR', N'Brazil', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BS', N'Bahamas', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BT', N'Bhutan', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BV', N'Bouvet Island', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BW', N'Botswana', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BY', N'Belarus', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'BZ', N'Belize', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'CA', N'Canada', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'CC', N'Cocos (Keeling) Islands', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'CD', N'Congo, Democratic Republic of the Congo', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'CF', N'Central African Republic', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'CG', N'Congo', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'CH', N'Switzerland', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'CI', N'Cote D''Ivoire', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'CK', N'Cook Islands', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'CL', N'Chile', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'CM', N'Cameroon', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'CN', N'China', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'CO', N'Colombia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'CR', N'Costa Rica', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'CS', N'Serbia and Montenegro', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'CU', N'Cuba', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'CV', N'Cape Verde', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'CW', N'Curacao', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'CX', N'Christmas Island', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'CY', N'Cyprus', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'CZ', N'Czech Republic', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'DE', N'Germany', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'DJ', N'Djibouti', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'DK', N'Denmark', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'DM', N'Dominica', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'DO', N'Dominican Republic', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'DZ', N'Algeria', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'EC', N'Ecuador', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'EE', N'Estonia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'EG', N'Egypt', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'EH', N'Western Sahara', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'ER', N'Eritrea', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'ES', N'Spain', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'ET', N'Ethiopia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'FI', N'Finland', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'FJ', N'Fiji', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'FK', N'Falkland Islands (Malvinas)', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'FM', N'Micronesia, Federated States of', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'FO', N'Faroe Islands', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'FR', N'France', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'GA', N'Gabon', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'GB', N'United Kingdom', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'GD', N'Grenada', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'GE', N'Georgia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'GF', N'French Guiana', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'GG', N'Guernsey', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'GH', N'Ghana', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'GI', N'Gibraltar', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'GL', N'Greenland', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'GM', N'Gambia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'GN', N'Guinea', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'GP', N'Guadeloupe', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'GQ', N'Equatorial Guinea', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'GR', N'Greece', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'GS', N'South Georgia and the South Sandwich Islands', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'GT', N'Guatemala', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'GU', N'Guam', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'GW', N'Guinea-Bissau', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'GY', N'Guyana', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'HK', N'Hong Kong', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'HM', N'Heard Island and Mcdonald Islands', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'HN', N'Honduras', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'HR', N'Croatia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'HT', N'Haiti', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'HU', N'Hungary', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'ID', N'Indonesia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'IE', N'Ireland', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'IL', N'Israel', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'IM', N'Isle of Man', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'IN', N'India', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'IO', N'British Indian Ocean Territory', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'IQ', N'Iraq', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'IR', N'Iran, Islamic Republic of', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'IS', N'Iceland', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'IT', N'Italy', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'JE', N'Jersey', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'JM', N'Jamaica', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'JO', N'Jordan', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'JP', N'Japan', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'KE', N'Kenya', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'KG', N'Kyrgyzstan', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'KH', N'Cambodia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'KI', N'Kiribati', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'KM', N'Comoros', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'KN', N'Saint Kitts and Nevis', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'KP', N'Korea, Democratic People''s Republic of', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'KR', N'Korea, Republic of', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'KW', N'Kuwait', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'KY', N'Cayman Islands', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'KZ', N'Kazakhstan', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'LA', N'Lao People''s Democratic Republic', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'LB', N'Lebanon', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'LC', N'Saint Lucia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'LI', N'Liechtenstein', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'LK', N'Sri Lanka', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'LR', N'Liberia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'LS', N'Lesotho', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'LT', N'Lithuania', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'LU', N'Luxembourg', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'LV', N'Latvia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'LY', N'Libyan Arab Jamahiriya', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MA', N'Morocco', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MC', N'Monaco', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MD', N'Moldova, Republic of', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'ME', N'Montenegro', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MF', N'Saint Martin', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MG', N'Madagascar', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MH', N'Marshall Islands', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MK', N'Macedonia, the Former Yugoslav Republic of', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'ML', N'Mali', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MM', N'Myanmar', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MN', N'Mongolia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MO', N'Macao', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MP', N'Northern Mariana Islands', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MQ', N'Martinique', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MR', N'Mauritania', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MS', N'Montserrat', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MT', N'Malta', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MU', N'Mauritius', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MV', N'Maldives', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MW', N'Malawi', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MX', N'Mexico', 1, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MY', N'Malaysia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MZ', N'Mozambique', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'NA', N'Namibia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'NC', N'New Caledonia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'NE', N'Niger', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'NF', N'Norfolk Island', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'NG', N'Nigeria', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'NI', N'Nicaragua', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'NL', N'Netherlands', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'NO', N'Norway', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'NP', N'Nepal', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'NR', N'Nauru', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'NU', N'Niue', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'NZ', N'New Zealand', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'OM', N'Oman', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'PA', N'Panama', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'PE', N'Peru', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'PF', N'French Polynesia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'PG', N'Papua New Guinea', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'PH', N'Philippines', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'PK', N'Pakistan', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'PL', N'Poland', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'PM', N'Saint Pierre and Miquelon', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'PN', N'Pitcairn', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'PR', N'Puerto Rico', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'PS', N'Palestinian Territory, Occupied', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'PT', N'Portugal', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'PW', N'Palau', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'PY', N'Paraguay', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'QA', N'Qatar', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'RE', N'Reunion', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'RO', N'Romania', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'RS', N'Serbia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'RU', N'Russian Federation', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'RW', N'Rwanda', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'SA', N'Saudi Arabia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'SB', N'Solomon Islands', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'SC', N'Seychelles', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'SD', N'Sudan', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'SE', N'Sweden', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'SG', N'Singapore', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'SH', N'Saint Helena', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'SI', N'Slovenia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'SJ', N'Svalbard and Jan Mayen', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'SK', N'Slovakia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'SL', N'Sierra Leone', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'SM', N'San Marino', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'SN', N'Senegal', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'SO', N'Somalia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'SR', N'Suriname', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'SS', N'South Sudan', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'ST', N'Sao Tome and Principe', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'SV', N'El Salvador', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'SX', N'Sint Maarten', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'SY', N'Syrian Arab Republic', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'SZ', N'Swaziland', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'TC', N'Turks and Caicos Islands', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'TD', N'Chad', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'TF', N'French Southern Territories', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'TG', N'Togo', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'TH', N'Thailand', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'TJ', N'Tajikistan', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'TK', N'Tokelau', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'TL', N'Timor-Leste', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'TM', N'Turkmenistan', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'TN', N'Tunisia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'TO', N'Tonga', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'TR', N'Turkey', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'TT', N'Trinidad and Tobago', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'TV', N'Tuvalu', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'TW', N'Taiwan, Province of China', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'TZ', N'Tanzania, United Republic of', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'UA', N'Ukraine', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'UG', N'Uganda', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'UM', N'United States Minor Outlying Islands', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'US', N'United States', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'UY', N'Uruguay', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'UZ', N'Uzbekistan', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'VA', N'Holy See (Vatican City State)', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'VC', N'Saint Vincent and the Grenadines', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'VE', N'Venezuela', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'VG', N'Virgin Islands, British', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'VI', N'Virgin Islands, U.s.', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'VN', N'Viet Nam', 1, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'VU', N'Vanuatu', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'WF', N'Wallis and Futuna', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'WS', N'Samoa', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'XK', N'Kosovo', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'YE', N'Yemen', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'YT', N'Mayotte', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'ZA', N'South Africa', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'ZM', N'Zambia', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'ZW', N'Zimbabwe', 0, 0)
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'0c6b3d0138db4671b571', N'32165d79812a479e93b5', 2, N'Toss radish and carrot with seasoned rice vinegar in a bowl until well coated. Let sit until veggies become slightly limp, 15 to 20 minutes. Drain and set aside or refrigerate.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'0e0bc590a89940b0891e', N'32165d79812a479e93b5', 5, N'Spread the interior surfaces of roll liberally with mayonnaise mixture. Transfer roll, cut-side up, to the prepared baking sheet.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'1832db7437ff47f89346', N'8c2d7127f534423aac97', 4, N'Place onion halves on a second baking sheet and roast on another rack until blackened and soft, about 45 minutes.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'1d5d42d9f2fc4d44a1de', N'6e3dcbb6e73241c989dc', 6, N'Pour hot coffee over ice cubes and stir briskly with the long-handled spoon to chill the coffee.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'1ed3dcacc7b94734b3ee', N'acc0c914d54345dfa93a', 3, N'Stir in milk, cream cheese, Parmesan cheese, and basil. Bring to a boil, stirring constantly. Cook until sauce is well blended and heated through, about 1 to 2 minutes.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'1f111a2b530549bda913', N'80d745e9deec413aa78e', 2, N'Fill a large bowl with warm water. Dip one wrapper into the hot water for 1 second to soften. Lay wrapper flat; place 2 shrimp halves in a row across the center, add some vermicelli, lettuce, mint, cilantro, and basil, leaving about 2 inches uncovered on each side. Fold uncovered sides inward, then tightly roll the wrapper, beginning at the end with lettuce. Repeat with remaining ingredients.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'2c635144fa1c4bcb8c2f', N'6e3dcbb6e73241c989dc', 3, N'Spoon 2 tablespoons sweetened condensed milk into each of 4 coffee cups.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'33385e98b2f140eebe5b', N'e87beae773694c1c89f1', 2, N'Place Italian sausage links, spaghetti sauce, green pepper, and onion into a slow cooker; mix until well combined.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'341e3065059648578261', N'531a0a31a60d485fadfe', 2, N'For the sauces: Mix water, lime juice, sugar, fish sauce, garlic, and chili sauce in a small bowl until well combined. Mix hoisin sauce and peanuts in a separate small bowl.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'36a5e4f8d3a4497cb950', N'945c17bcc4864effa5eb', 3, N'Shred chicken in the cooker with two forks. Stir in butter.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'428b2a0ada394484ae85', N'36652c30256a447b9d9c', 5, N'Add chili powder and black pepper to the chicken broth, and stir in.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'44b270636cfc49609bf6', N'36652c30256a447b9d9c', 1, N'Heat olive oil over medium heat in a 12-inch skillet. Season both sides of pork chops with taco seasoning, cumin, smoked paprika, and salt.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'4780f3cc93894678b3ab', N'8c2d7127f534423aac97', 7, N'When noodles have soaked for 1 hour, heat up the reserved broth by bringing it to a simmer.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'4aa2bb89691945f19e80', N'32165d79812a479e93b5', 4, N'Split French roll just enough so you can open it like a book. Pull out some of the bread from the top half to better accommodate the filling if desired.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'51bf1000682141ee952c', N'531a0a31a60d485fadfe', 3, N'Fill a large pot with lightly salted water and bring to a rolling boil; stir in vermicelli pasta and return to a boil. Cook pasta uncovered, stirring occasionally, until the pasta is tender yet firm to the bite, 3 to 5 minutes.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'549a91e4d96941398696', N'80d745e9deec413aa78e', 3, N'For the sauces: Mix water, lime juice, sugar, fish sauce, garlic, and chili sauce in a small bowl until well combined. Mix hoisin sauce and peanuts in a separate small bowl.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'57d5148715914531b258', N'69b882c46f66461a9e27', 3, N'Cook on Low for 6 to 8 hours. Shred chicken.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'5838b7ba848b42238502', N'acc0c914d54345dfa93a', 1, N'Cook pasta as directed on package, adding broccoli to the boiling water for the last 2 minutes of the pasta cooking time. Drain pasta mixture.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'5b0c7b155aa547569f75', N'8c2d7127f534423aac97', 5, N'Transfer beef bones and onion halves to a large stockpot. Add ginger, salt, star anise, fish sauce, and 4 quarts water; bring to a boil. Reduce heat to low and simmer for 6 to 10 hours. Strain the broth into a saucepan and set aside.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'608b6cd0b42b44c0acbf', N'8c2d7127f534423aac97', 6, N'Place rice noodles in a large bowl filled with room temperature water. Let soak for 1 hour. Drain.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'60ddab26e4f1486da2ee', N'945c17bcc4864effa5eb', 2, N'Cover and cook on Low for 6 to 7 hours.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'636c15027d5c45059ee6', N'945c17bcc4864effa5eb', 4, N'Pile shredded chicken and sauce onto hoagie rolls. Serve with remaining Buffalo sauce.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'66c86e8063b64ea9acd8', N'dd62bb4a4fd0476c90b1', 1, N' aa')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'765d1c1bb0274466ab90', N'8c2d7127f534423aac97', 8, N'Bring a large pot of water to a boil. Cook the noodles in the boiling water for 1 minute. Drain.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'76865efdc92644f5a666', N'69b882c46f66461a9e27', 1, N'Combine chicken broth and taco seasoning mix in a bowl.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'7849458e5e624498b47f', N'6e3dcbb6e73241c989dc', 4, N'Pour 1 cup fresh hot coffee into each cup and stir to dissolve the milk.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'79490768272946319530', N'acc0c914d54345dfa93a', 2, N'Meanwhile, heat dressing in large nonstick skillet on medium-high heat. Add chicken and cook until no longer pink in the center, stirring occasionally, about 5 to 7 minutes.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'840a9cc6e5aa4c4aa86c', N'8c2d7127f534423aac97', 3, N'Place beef bones on a baking sheet and roast in the preheated oven until browned, about 1 hour.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'8d5f6df1e3cc454b9bf5', N'32165d79812a479e93b5', 7, N'Place sliced pork, paté, pickled radish and carrot, cucumber, jalapeño, and cilantro leaves in warm roll. Cut in half to serve.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'91d14206d3d2446ea654', N'e87beae773694c1c89f1', 3, N'Place Italian sausage links, spaghetti sauce, green pepper, and onion into a slow cooker; mix until well combined.

')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'9251cf42950d488d92b8', N'80d745e9deec413aa78e', 1, N'Fill a large pot with lightly salted water and bring to a rolling boil; stir in vermicelli pasta and return to a boil. Cook pasta uncovered, stirring occasionally, until the pasta is tender yet firm to the bite, 3 to 5 minutes.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'985c6c21be5f48b9b1bf', N'36652c30256a447b9d9c', 2, N'Place chops in the hot skillet and cook, turning once, until browned on both sides, about 2 minutes per side. Remove to a plate, and keep warm.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'9be198ebfe6142b48665', N'36652c30256a447b9d9c', 4, N'Pour in diced tomatoes and green chilies, with their juices, and stir, being sure to scrape up any browned bits on the bottom of the skillet.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'9c578e51051d414b83dd', N'69b882c46f66461a9e27', 2, N'Place chicken in a slow cooker. Pour chicken broth mixture over chicken.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'9cd820a4dea4458b8b63', N'8c2d7127f534423aac97', 9, N'Divide noodles among 4 serving bowls; top with sirloin, cilantro, and green onion. Ladle hot broth over the top. Stir and let sit until beef is partially cooked and no longer pink, 1 to 2 minutes.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'9f9fe23c24bf43f9af6e', N'62082df1777449798aa4', 2, N'step 2')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'a416005b4c4f492190dc', N'32165d79812a479e93b5', 6, N'Bake in the preheated oven until warm and crisp with slightly browned edges, about 7 minutes.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'a743abfc81d94587b852', N'e87beae773694c1c89f1', 1, N'Gather all ingredients.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'abe8421c91134f2fad83', N'36652c30256a447b9d9c', 8, N'Remove cover, and continue to simmer until rice is tender and all the liquid is absorbed, about 5 minutes more. An instant-read thermometer inserted into the center of pork chops should read 145 degrees F (63 degrees C).')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'ad1e9da94c7f4b618f39', N'1701c4936dd041ca8936', 2, N'We all know the fried spring roll (cha gio), but its “fresh” counterpart is a much lighter and healthier appetizer alternative. Slices of pork, shrimp, lettuce, mint, and vermicelli noodles are neatly wrapped up in a translucent rice paper before being dunked into a hoisin-peanut dip.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'b2470de33f95405aa9cf', N'80d745e9deec413aa78e', 4, N'Serve rolled spring rolls with fish sauce and hoisin sauce mixtures.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'b68b4ad35c574923909d', N'fa3ab1b59e414f6488d2', 1, N'1')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'b8124732e3ab424b8b4c', N'8c2d7127f534423aac97', 1, N'Gather all ingredients.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'b9539e5a7785402bbc5f', N'36652c30256a447b9d9c', 7, N'Nestle pork chops into the skillet contents, and add any accumulated juices from the chops. Cover, reduce heat to low, and simmer about 20 minutes.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'bda15323d6844f11a24e', N'945c17bcc4864effa5eb', 1, N'Place chicken breasts into the slow cooker; pour in 3/4 of the wing sauce and ranch dressing mix.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'be2533a057904f2e8a3d', N'32165d79812a479e93b5', 1, N'Preheat the oven to 400 degrees F (200 degrees C). Line a baking sheet with aluminum foil.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'c22707b4842343ddbdb8', N'8c2d7127f534423aac97', 2, N'Preheat the oven to 425 degrees F (220 degrees C).')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'c341e03b17d1453896a0', N'22e597910b9b4f1ab552', 2, N'Rice: You may typically find this dish served with com tam (broken rice) but long grain rice you typically find with Vietnamese cuisine works.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'c34cf97c836c427b9e56', N'8c2d7127f534423aac97', 10, N'Serve with bean sprouts, Thai basil, lime wedges, hoisin sauce, and chile-garlic sauce on the side.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'da9e3e5279744729b6a4', N'b9589acfa7e140abb30b', 1, N'123')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'db1c77b93dec48838725', N'531a0a31a60d485fadfe', 1, N'Serve rolled spring rolls with fish sauce and hoisin sauce mixtures.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'e1b34017b2d44870b68d', N'1701c4936dd041ca8936', 1, N'There are a few variations of this noodle soup dish, but the foundation of it is a crab and tomato broth. The crustaceans produce a piquant aroma while the red vegetable adds a layer of acidity and hint of sourness to the soup. Vermicelli is often the noodle of choice and toppings can include meatballs, pork knuckles, fried tofu, fish, snails, and blood cubes.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'e5a13baba0bc497c9c55', N'6e3dcbb6e73241c989dc', 1, N'Gather all ingredients.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'e761fb47769346d3a1e0', N'36652c30256a447b9d9c', 9, N'Garnish with flat-leaf parsley or cilantro and lime slices. Serve warm.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'eb7511045e5a4c428bae', N'22e597910b9b4f1ab552', 1, N'Dipping sauce: The dipping sauce is the same fish sauce recipe here. If you’re making a big bowl of sauce to share for dinner, use a spoon to sauce up your plate instead of dipping your cuts in so you keep the sauce clean for everyone else.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'ef58b8b2fb624ca79913', N'6e3dcbb6e73241c989dc', 2, N'Brew water with coffee using your preferred method to make coffee.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'ef62ee84277244559811', N'acc0c914d54345dfa93a', 4, N'Add chicken mixture to pasta mixture; mix lightly.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'efc4298864d943819b35', N'6e3dcbb6e73241c989dc', 5, N'Serve cups of coffee along with 4 tall glasses filled with 4 ice cubes each and a long-handled spoon.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'f516afd822ef4e5f890d', N'62082df1777449798aa4', 1, N'step 1')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'f661d665167a4f80a6cc', N'36652c30256a447b9d9c', 6, N'Add thawed corn kernels, sliced zucchini, and uncooked rice. Stir until vegetables are evenly distributed, and make sure all the rice is submerged in the cooking liquid. Bring to a boil.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'f8c0b0b451dd40f2bd12', N'c81271cece0e41c1a347', 1, N'asd')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'fa1214937bfc47999019', N'36652c30256a447b9d9c', 3, N'In the same skillet, cook and stir onion and bell pepper, until the vegetables just begin to pick up a little color, about 2 minutes. Add garlic and cook until fragrant, about 30 seconds.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'fac29e53df01486a84c5', N'32165d79812a479e93b5', 3, N'Mix mayonnaise, hoisin sauce, and sriracha in a small bowl.')
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'0202bf73770d4bf0a950', N'2d5b9c2e631a4913bb23', N'32165d79812a479e93b5', CAST(N'2023-08-29T12:17:52.683' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'17196de4b9444a068a76', N'b868aba865fa4492be7c', N'80d745e9deec413aa78e', CAST(N'2023-08-29T13:56:44.857' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'2b870e44ba2e46b28fd7', N'b868aba865fa4492be7c', N'6e3dcbb6e73241c989dc', CAST(N'2023-08-29T13:56:49.963' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'303d8eee22bf4038b7d9', N'1d4eea6852374bbba3ed', N'32165d79812a479e93b5', CAST(N'2023-08-29T13:53:59.907' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'32728d795f3c4348b1dd', N'1d4eea6852374bbba3ed', N'6e3dcbb6e73241c989dc', CAST(N'2023-08-29T14:04:23.277' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'67367c09f6644dab8246', N'1d4eea6852374bbba3ed', N'8c2d7127f534423aac97', CAST(N'2023-08-29T13:53:25.670' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'766c1fd75c6a4e77bf12', N'233ecd03e7bb4d1fa30b', N'fa3ab1b59e414f6488d2', CAST(N'2023-08-29T12:52:09.710' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'9c9016fbf784420eba4b', N'b868aba865fa4492be7c', N'32165d79812a479e93b5', CAST(N'2023-08-29T20:15:09.690' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'ae7a304559e746868ab0', N'233ecd03e7bb4d1fa30b', N'8c2d7127f534423aac97', CAST(N'2023-08-29T13:33:51.363' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'b6013b6ebe214d41bae3', N'233ecd03e7bb4d1fa30b', N'945c17bcc4864effa5eb', CAST(N'2023-08-29T09:15:45.050' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'ca8cca8f910346e5ba83', N'b868aba865fa4492be7c', N'69b882c46f66461a9e27', CAST(N'2023-08-29T20:15:12.210' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'e0feed8177954f6dae7c', N'233ecd03e7bb4d1fa30b', N'1701c4936dd041ca8936', CAST(N'2023-08-29T14:12:09.750' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'e30f918db66943d38072', N'1d4eea6852374bbba3ed', N'80d745e9deec413aa78e', CAST(N'2023-08-29T13:54:02.027' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'e59038dfd94d45249377', N'233ecd03e7bb4d1fa30b', N'69b882c46f66461a9e27', CAST(N'2023-08-29T09:13:48.767' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'e93751ba6fbe4454a0f9', N'b868aba865fa4492be7c', N'8c2d7127f534423aac97', CAST(N'2023-08-29T20:15:07.603' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'eb28083063564b5b8d66', N'233ecd03e7bb4d1fa30b', N'32165d79812a479e93b5', CAST(N'2023-08-29T12:51:29.500' AS DateTime))
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'1567f5fd3c01498780ba', N'12', 1, N'1', 1, 1, 1, 17)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'51e1f298d03343e08a33', N'Beef', 1, N'100-grams (d)', 0.10000000149011612, 35, 10, 230.39999389648438)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'53a6a95c12e94f10b862', N'test', 1, N'test', 1, 1, 1, 17)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'74680258862b4540aa58', N'test', 1, N'test', 0.10000000149011612, 0, 0, 0.40000000596046448)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'7d875d503b76421d81cb', N'a', 1, N'1', 1, 1, 1, 17)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'9e603225dce44b04b21b', N'a', 1, N'a', 0, 0, 0, 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'c297366948134012b428', N'Beef', 0, N'100-grams', 0.10000000149011612, 10, 35, 355.39999389648438)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'cbd93fb73173495599ee', N'a', 1, N'a', 1, 1, 1, 17)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'd993ddc2c54741e3a2e3', N'test', 1, N'test', 0.20000000298023224, 2, 0.10000000149011612, 9.6999998092651367)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'e07b921fc8394caebab0', N'a', 1, N'a', 0, 0.10000000149011612, 1, 9.3999996185302734)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ebb84aa293e441169e98', N'test', 1, N'test', 0, 0, 0, 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ef0ab76997ab4c918536', N'test', 1, N'test', 0, 0, 0, 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'f4ac92456fab42d1b6e7', N'test', 1, N'test', 0.30000001192092896, 0.30000001192092896, 1.2999999523162842, 14.09999942779541)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0001', N'Flour', 1, N'Cups', 113, 10, 0.4, 495.6)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0002', N'Sugar', 0, N'Cups', 99.7, 0, 0, 398.8)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0005', N'Butter', 0, N'Cups', 1, 0.10000000149011612, 81.699996948242188, 739.70001220703125)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0006', N'Chocolate chips', 0, N'Cups', 67.4, 45, 46.2, 865.40000000000009)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0009', N'Salt', 0, N'Teaspoons', 0, 0, 0, 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0010', N'Chocolate cake mix', 0, N'Boxes', 113, 44, 45, 1033)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0011', N'Granulated sugar', 0, N'Cups', 120, 0, 0, 480)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0012', N'Brown sugar', 0, N'Cups', 120, 0, 0, 480)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0013', N'Cornstarch', 0, N'Cups', 60, 0, 0, 240)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0014', N'Baking powder', 0, N'Teaspoons', 15, 0, 0, 60)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0015', N'Baking soda', 0, N'Teaspoons', 15, 0, 0, 60)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0016', N'All-purpose flour', 0, N'Cups', 120, 0, 0, 480)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0017', N'Cocoa powder', 0, N'Cups', 40, 0, 22, 358)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0018', N'Vegetable oil', 0, N'Cups', 120, 0, 100, 1380)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0019', N'Eggs', 0, N'Units', 6, 18, 18, 258)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0020', N'Milk', 0, N'Cups', 120, 13, 8, 604)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0021', N'Vanilla extract', 0, N'Teaspoons', 15, 0, 0, 60)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0022', N'Walnuts', 0, N'Cups', 120, 15, 7, 603)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0023', N'Pecans', 0, N'Cups', 120, 19, 4, 592)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0024', N'Almonds', 0, N'Cups', 120, 16, 6, 598)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0025', N'Raisins', 0, N'Cups', 120, 25, 0, 580)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0026', N'Cranberries', 0, N'Cups', 120, 25, 0, 580)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0028', N'White chocolate chips', 0, N'Cups', 120, 0, 40, 840)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0029', N'Coconut', 0, N'Cups', 120, 27, 0, 588)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0030', N'Peanut butter', 0, N'Cups', 120, 0, 16, 624)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0031', N'Honey', 0, N'Cups', 120, 0, 0, 480)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0032', N'Maple syrup', 0, N'Cups', 120, 0, 0, 480)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0033', N'Yogurt', 0, N'Cups', 120, 5, 8, 572)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0034', N'Sour cream', 0, N'Cups', 120, 4, 2, 514)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0035', N'Cream cheese', 0, N'Cups', 120, 1, 10, 574)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0036', N'Heavy cream', 0, N'Cups', 120, 0, 80, 1200)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0037', N'Whipped cream', 0, N'Cups', 120, 0, 0, 480)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0038', N'Nutella', 0, N'Cups', 120, 56, 11, 803)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0039', N'Jam', 0, N'Cups', 120, 25, 0, 580)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0040', N'Jelly', 0, N'Cups', 120, 25, 0, 580)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0041', N'Marmalade', 0, N'Cups', 120, 25, 0, 580)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0042', N'Honey mustard', 0, N'Cups', 120, 8, 0, 512)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0043', N'Ranch dressing', 0, N'Cups', 120, 3, 0, 492)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0044', N'Mayonnaise', 0, N'Cups', 120, 0, 10, 570)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0045', N'Ketchup', 0, N'Cups', 120, 10, 0, 520)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0046', N'Mustard', 0, N'Cups', 120, 0, 0, 480)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0047', N'Soy sauce', 0, N'Cups', 120, 8, 2, 530)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0048', N'Worcestershire sauce', 0, N'Cups', 120, 3, 0, 492)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0049', N'Teriyaki sauce', 0, N'Cups', 120, 12, 0, 528)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete], [Measure], [Carbohydrate], [Protein], [Fat], [Calories]) VALUES (N'ING0050', N'Sesame oil', 0, N'Cups', 120, 0, 10, 570)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'51e1f298d03343e08a33', N'8c2d7127f534423aac97', 5)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'c297366948134012b428', N'22e597910b9b4f1ab552', 2)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'c297366948134012b428', N'36652c30256a447b9d9c', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'c297366948134012b428', N'b9589acfa7e140abb30b', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'c297366948134012b428', N'c81271cece0e41c1a347', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0002', N'1701c4936dd041ca8936', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0002', N'36652c30256a447b9d9c', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0002', N'62082df1777449798aa4', 3)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0002', N'8c2d7127f534423aac97', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0002', N'945c17bcc4864effa5eb', 12)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0002', N'fa3ab1b59e414f6488d2', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0005', N'36652c30256a447b9d9c', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0005', N'62082df1777449798aa4', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0005', N'69b882c46f66461a9e27', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0005', N'945c17bcc4864effa5eb', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0005', N'e87beae773694c1c89f1', 3)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0006', N'1701c4936dd041ca8936', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0006', N'36652c30256a447b9d9c', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0006', N'531a0a31a60d485fadfe', 32)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0006', N'6e3dcbb6e73241c989dc', 3)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0006', N'80d745e9deec413aa78e', 3)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0006', N'acc0c914d54345dfa93a', 2)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0009', N'22e597910b9b4f1ab552', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0009', N'32165d79812a479e93b5', 0.5)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0009', N'36652c30256a447b9d9c', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0009', N'62082df1777449798aa4', 8)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0009', N'69b882c46f66461a9e27', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0009', N'8c2d7127f534423aac97', 4)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0010', N'531a0a31a60d485fadfe', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0010', N'62082df1777449798aa4', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0010', N'6e3dcbb6e73241c989dc', 2)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0010', N'80d745e9deec413aa78e', 4)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0010', N'dd62bb4a4fd0476c90b1', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0012', N'1701c4936dd041ca8936', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0012', N'8c2d7127f534423aac97', 8)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0013', N'8c2d7127f534423aac97', 2)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0015', N'22e597910b9b4f1ab552', 3)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0015', N'acc0c914d54345dfa93a', 4)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0016', N'22e597910b9b4f1ab552', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0016', N'32165d79812a479e93b5', 5)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0018', N'22e597910b9b4f1ab552', 3)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0019', N'32165d79812a479e93b5', 2)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0019', N'8c2d7127f534423aac97', 3)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0019', N'acc0c914d54345dfa93a', 3)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0020', N'acc0c914d54345dfa93a', 5)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0028', N'6e3dcbb6e73241c989dc', 2)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0028', N'80d745e9deec413aa78e', 5)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0031', N'32165d79812a479e93b5', 0.2)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0035', N'531a0a31a60d485fadfe', 1)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0044', N'32165d79812a479e93b5', 0.5)
GO
INSERT [dbo].[IngredientOfRecipe] ([IngredientId], [RecipeId], [Quantity]) VALUES (N'ING0045', N'32165d79812a479e93b5', 0.2)
GO
INSERT [dbo].[Meal] ([MealId], [MealName], [IsDelete]) VALUES (N'M0001', N'Breakfast', 0)
GO
INSERT [dbo].[Meal] ([MealId], [MealName], [IsDelete]) VALUES (N'M0002', N'Lunch', 0)
GO
INSERT [dbo].[Meal] ([MealId], [MealName], [IsDelete]) VALUES (N'M0003', N'Dinner', 0)
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'07b1530687204d21a56b', N'acc0c914d54345dfa93a', N'2088e23a19284eb1924e', CAST(N'2023-08-29T20:29:14.273' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2F0e80f717-9d4b-41fe-a90e-3b63f29f492c?alt=media&token=1094f3ad-5436-4a8c-a051-9d350877e11b')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'0c09e4aead22458197ac', N'8ae3a29b05804e738916', N'1b4cfb67eaa74051ac0f', CAST(N'2023-08-29T20:43:07.867' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2F326e3d13-ae76-4b44-b11c-de46bbacd6d4?alt=media&token=fff002aa-d4c3-40da-bcc7-321dee5031db')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'178dd08a63874b42b0ce', N'62082df1777449798aa4', N'1b4cfb67eaa74051ac0f', CAST(N'2023-08-29T08:27:48.503' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2F4536403d-7828-4c82-bc7f-c56206ce0bf3?alt=media&token=8d00516b-df0f-4d70-b87c-36d1799486dc')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'202fe4e2909b4395b71e', N'531a0a31a60d485fadfe', N'1b4cfb67eaa74051ac0f', CAST(N'2023-08-29T14:01:36.277' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2F2548e4b3-c6b6-4fe4-9024-9559e34b0e96?alt=media&token=a9209732-cdac-46df-bf60-c6d828d024d5')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'2ad3c61470f24450abdf', N'e87beae773694c1c89f1', N'60769b703f4248648cd3', CAST(N'2023-08-29T09:22:02.683' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2F02599e18-4d33-4bfa-a76c-86dc224a5858?alt=media&token=208eb14f-d7c3-4378-a880-1d626bf00358')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'56c85b01d1fb4356a71d', N'c81271cece0e41c1a347', N'60769b703f4248648cd3', CAST(N'2023-08-29T11:37:58.847' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2Feb1de5b4-79c2-44bd-adb2-c9be5ca62839?alt=media&token=b49305f2-1a07-4f12-b0e6-bd33e2a1eea2')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'5d928e59865e4362a506', N'fa3ab1b59e414f6488d2', N'60769b703f4248648cd3', CAST(N'2023-08-29T09:59:50.597' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2F29f82ffa-0944-4c98-94c4-a7dcff410f49?alt=media&token=9f109b89-5e6c-480e-b75e-f14bcfd23abf')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'6b0b07187c3b45cb90af', N'dd62bb4a4fd0476c90b1', N'1b4cfb67eaa74051ac0f', CAST(N'2023-08-29T08:30:02.810' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2Fe0c30f09-f0c4-43ef-a5d0-bdd34668dc95?alt=media&token=0ad8a7ba-a566-4c0f-9eb3-957f56e42f82')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'70ff1ffd09124db08384', N'06f99037dbec463cbadb', N'2088e23a19284eb1924e', CAST(N'2023-08-29T13:41:07.883' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2F326e3d13-ae76-4b44-b11c-de46bbacd6d4?alt=media&token=fff002aa-d4c3-40da-bcc7-321dee5031db')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'8b6979bd08d946a3a698', N'69b882c46f66461a9e27', N'60769b703f4248648cd3', CAST(N'2023-08-29T09:19:39.860' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2F3b4bd170-5f50-40f2-a433-c3172d7c2c44?alt=media&token=766656ce-c480-4f8b-ae18-18984b2e4a56')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'908b82b21fa645879aab', N'80d745e9deec413aa78e', N'1b4cfb67eaa74051ac0f', CAST(N'2023-08-29T20:47:13.833' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2F326e3d13-ae76-4b44-b11c-de46bbacd6d4?alt=media&token=fff002aa-d4c3-40da-bcc7-321dee5031db')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'920bde43dc0f4a59a769', N'496c5630198f4b0e9d68', N'1b4cfb67eaa74051ac0f', CAST(N'2023-08-29T13:29:00.037' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2Fe7b597a0-26e3-4a3f-9cd2-b921ee228264?alt=media&token=965868a1-9473-4a2f-adf1-bafeb752f78e')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'99c2ac97b6464514804c', N'8c2d7127f534423aac97', N'2088e23a19284eb1924e', CAST(N'2023-08-29T13:58:29.830' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2Fcb714b24-e05d-4ca8-887d-de7766370941?alt=media&token=f42034b0-bf04-4160-bbe4-47dc821f1c56')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'9a7fc39d40ea483282b9', N'22e597910b9b4f1ab552', N'adc1180042a94805a10f', CAST(N'2023-08-29T14:03:23.770' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2Fff3d5e56-8672-4d8a-b585-6c13857fd7d4?alt=media&token=10d914e7-9146-4078-ab94-ffc0e73bb646')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'9b8f0038d39c4a2c8798', N'945c17bcc4864effa5eb', N'60769b703f4248648cd3', CAST(N'2023-08-29T09:19:59.327' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2Fccbf66cd-983f-44ca-9d08-29d3c9cc117b?alt=media&token=027c137f-1105-4c09-8220-1334cdfe5de0')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'a24772876bbb43d59884', N'36652c30256a447b9d9c', N'2088e23a19284eb1924e', CAST(N'2023-08-29T13:52:09.473' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2Fd8df0ed3-a0c1-4f69-88f6-04bcb3893baa?alt=media&token=c1c10723-b4bf-4ee8-8b61-16d6cc163904')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'a971411fc32f465e8ab6', N'91ce7161456d44dbb89e', N'2088e23a19284eb1924e', CAST(N'2023-08-29T13:40:02.010' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2Fde85b813-25a8-4279-9841-078ad1fe3c11?alt=media&token=0223b3d5-0c17-4212-b4f4-963c6d4fa394')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'b1265c5caeab4acf8b89', N'b9589acfa7e140abb30b', N'60769b703f4248648cd3', CAST(N'2023-08-29T11:39:28.550' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2Fe3d9939d-afd5-45a2-b249-aaf356b43c3a?alt=media&token=c42570c3-fb9f-4fca-a11f-d4ba5558bab3')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'cfa87f3db20f4ec6aa60', N'32165d79812a479e93b5', N'2088e23a19284eb1924e', CAST(N'2023-08-29T10:27:48.010' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2Fd4eb4931-0051-43fa-a760-64ca18d7fa8f?alt=media&token=4efa56cb-8cfc-47ac-b46d-efbc5736a3b3')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'd97c820ee60f4dedbc81', N'1701c4936dd041ca8936', N'adc1180042a94805a10f', CAST(N'2023-08-29T14:11:09.550' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2F6bfc9281-02f6-4fdc-b177-1c6e4acab0ca?alt=media&token=1a75b470-e5bd-469c-bf49-e51fa44e50b1')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'eef6c3a13e104ae290fb', N'7ad9329f81894e21bdfe', N'1b4cfb67eaa74051ac0f', CAST(N'2023-08-29T20:45:22.273' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2F326e3d13-ae76-4b44-b11c-de46bbacd6d4?alt=media&token=fff002aa-d4c3-40da-bcc7-321dee5031db')
GO
INSERT [dbo].[Photo] ([PhotoId], [RecipeId], [UserId], [UploadTime], [IsDelete], [PhotoName]) VALUES (N'ef8d7cbcffbb406bbab0', N'6e3dcbb6e73241c989dc', N'1b4cfb67eaa74051ac0f', CAST(N'2023-08-29T13:57:45.267' AS DateTime), 0, N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2Fec3d0a25-74ba-4634-b758-a05c9c11f85b?alt=media&token=d98f17b3-e0c9-499c-9d54-3044a34deeb2')
GO
INSERT [dbo].[Plan] ([PlanId], [UserId], [PlanName], [PlanDescription], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'23ad81ff9c6d4d23b61b', N'2d5b9c2e631a4913bb23', N'', N'', CAST(N'2023-08-29T08:54:13.907' AS DateTime), CAST(N'2023-08-29T08:54:13.923' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Plan] ([PlanId], [UserId], [PlanName], [PlanDescription], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'87bc425a72c6410da635', N'b868aba865fa4492be7c', N'', N'', CAST(N'2023-08-29T10:14:29.827' AS DateTime), CAST(N'2023-08-29T10:14:29.827' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Plan] ([PlanId], [UserId], [PlanName], [PlanDescription], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'b77ea76baf974e488efa', N'1d4eea6852374bbba3ed', N'', N'', CAST(N'2023-08-29T09:09:17.340' AS DateTime), CAST(N'2023-08-29T09:09:17.340' AS DateTime), NULL, 0)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'19b83ee7fe164e8eb58a', N'23ad81ff9c6d4d23b61b', N'945c17bcc4864effa5eb', CAST(N'2023-09-04T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'1cadcdd524a748fcbd7b', N'b77ea76baf974e488efa', N'69b882c46f66461a9e27', CAST(N'2023-09-03T00:00:00.000' AS DateTime), 2)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'2209860d985741cdac7b', N'b77ea76baf974e488efa', N'dd62bb4a4fd0476c90b1', CAST(N'2023-09-03T00:00:00.000' AS DateTime), 3)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'28aad9300de44f1db98c', N'b77ea76baf974e488efa', N'945c17bcc4864effa5eb', CAST(N'2023-09-01T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'297cdb3427f247ed8ec5', N'23ad81ff9c6d4d23b61b', N'69b882c46f66461a9e27', CAST(N'2023-08-30T00:00:00.000' AS DateTime), 2)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'2a436b0dcc444499b819', N'23ad81ff9c6d4d23b61b', N'dd62bb4a4fd0476c90b1', CAST(N'2023-08-31T00:00:00.000' AS DateTime), 3)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'305bd04a5f11499284ac', N'23ad81ff9c6d4d23b61b', N'69b882c46f66461a9e27', CAST(N'2023-09-02T00:00:00.000' AS DateTime), 2)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'34355fba4e8d4d1e98d8', N'23ad81ff9c6d4d23b61b', N'69b882c46f66461a9e27', CAST(N'2023-09-01T00:00:00.000' AS DateTime), 2)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'3c19f6add12c419a873a', N'b77ea76baf974e488efa', N'dd62bb4a4fd0476c90b1', CAST(N'2023-09-02T00:00:00.000' AS DateTime), 3)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'3f9faa31e3954fa9b9bf', N'23ad81ff9c6d4d23b61b', N'945c17bcc4864effa5eb', CAST(N'2023-08-30T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'41c5b7097c7c43eeaf45', N'23ad81ff9c6d4d23b61b', N'dd62bb4a4fd0476c90b1', CAST(N'2023-08-28T00:00:00.000' AS DateTime), 3)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'4285be5b25584c1aa8c4', N'87bc425a72c6410da635', N'32165d79812a479e93b5', CAST(N'2023-08-29T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'513e3ffa1ade4f4dbf77', N'23ad81ff9c6d4d23b61b', N'32165d79812a479e93b5', CAST(N'2023-08-28T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'52b7db97d592469cbb81', N'23ad81ff9c6d4d23b61b', N'945c17bcc4864effa5eb', CAST(N'2023-08-31T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'57961746c2cc46bfb665', N'23ad81ff9c6d4d23b61b', N'dd62bb4a4fd0476c90b1', CAST(N'2023-09-01T00:00:00.000' AS DateTime), 3)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'65853f82891f472cbf13', N'23ad81ff9c6d4d23b61b', N'945c17bcc4864effa5eb', CAST(N'2023-08-29T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'6b70fc34c2384c2d8454', N'87bc425a72c6410da635', N'acc0c914d54345dfa93a', CAST(N'2023-08-29T00:00:00.000' AS DateTime), 3)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'765206ab3eca43c0b98d', N'23ad81ff9c6d4d23b61b', N'69b882c46f66461a9e27', CAST(N'2023-08-29T00:00:00.000' AS DateTime), 2)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'7be67db83b0d4016bec8', N'87bc425a72c6410da635', N'69b882c46f66461a9e27', CAST(N'2023-08-29T00:00:00.000' AS DateTime), 2)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'7df005a8267942c0a67a', N'23ad81ff9c6d4d23b61b', N'32165d79812a479e93b5', CAST(N'2023-09-01T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'8d970873834a4adfb547', N'87bc425a72c6410da635', N'36652c30256a447b9d9c', CAST(N'2023-08-29T00:00:00.000' AS DateTime), 3)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'96d5a812f7474f1d9222', N'b77ea76baf974e488efa', N'945c17bcc4864effa5eb', CAST(N'2023-09-03T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'9aca55d767c942d89e30', N'23ad81ff9c6d4d23b61b', N'69b882c46f66461a9e27', CAST(N'2023-08-31T00:00:00.000' AS DateTime), 2)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'a181e7c25348474581c6', N'23ad81ff9c6d4d23b61b', N'b9589acfa7e140abb30b', CAST(N'2023-08-29T00:00:00.000' AS DateTime), 3)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'a3eb5d06c6e74dde95f9', N'23ad81ff9c6d4d23b61b', N'e87beae773694c1c89f1', CAST(N'2023-09-04T00:00:00.000' AS DateTime), 3)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'adcb4b8d22c94edcb1f0', N'87bc425a72c6410da635', N'945c17bcc4864effa5eb', CAST(N'2023-08-29T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'b438c8f22929414d82e1', N'23ad81ff9c6d4d23b61b', N'945c17bcc4864effa5eb', CAST(N'2023-09-02T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'b8ccba22d0ba42f1ad77', N'23ad81ff9c6d4d23b61b', N'fa3ab1b59e414f6488d2', CAST(N'2023-08-28T00:00:00.000' AS DateTime), 2)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'b973eab3686a44de839b', N'87bc425a72c6410da635', N'8c2d7127f534423aac97', CAST(N'2023-08-29T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'c4bf0696dcd54d749c29', N'23ad81ff9c6d4d23b61b', N'69b882c46f66461a9e27', CAST(N'2023-09-04T00:00:00.000' AS DateTime), 2)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'cdb48534eac5470fb660', N'b77ea76baf974e488efa', N'62082df1777449798aa4', CAST(N'2023-08-29T00:00:00.000' AS DateTime), 2)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'd9a766aad41c4263b570', N'23ad81ff9c6d4d23b61b', N'dd62bb4a4fd0476c90b1', CAST(N'2023-08-30T00:00:00.000' AS DateTime), 3)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'e1407ff0073b4a90bfb0', N'b77ea76baf974e488efa', N'69b882c46f66461a9e27', CAST(N'2023-08-29T00:00:00.000' AS DateTime), 3)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'e3206d14412d4a4fab4c', N'b77ea76baf974e488efa', N'62082df1777449798aa4', CAST(N'2023-08-29T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'ee3596137a5a4c6fa861', N'b77ea76baf974e488efa', N'69b882c46f66461a9e27', CAST(N'2023-08-31T00:00:00.000' AS DateTime), 2)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'06f99037dbec463cbadb', N'Vietnamese Fresh Spring Rolls', N'2088e23a19284eb1924e', N'VN', N'M0002', N'These Vietnamese spring rolls are a refreshing change from the usual fried variety and have become a family favorite. They are a great summertime appetizer and delicious dipped in one or both of the sauces.', 45, 5, 0, 50, 8, 0, 0, 0, 0, CAST(N'2023-08-29T13:41:07.857' AS DateTime), CAST(N'2023-08-29T13:41:07.857' AS DateTime), CAST(N'2023-08-29T13:46:47.743' AS DateTime), 1)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'1701c4936dd041ca8936', N'Foods Every Southerner Should Have In the Pantry', N'adc1180042a94805a10f', N'AM', N'M0001', N'', 100, 100, 12, 212, 6, 287, 45, 46, 1744, CAST(N'2023-08-29T14:11:09.517' AS DateTime), CAST(N'2023-08-29T14:11:09.517' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'22e597910b9b4f1ab552', N'Vietnamese Pork Chop Recipe', N'adc1180042a94805a10f', N'VN', N'M0001', N'This quintessential rice dish of Vietnamese pork chops is packed with flavor, super easy to make, and a crowd pleaser!', 20, 20, 100, 140, 4, NULL, NULL, NULL, 0, CAST(N'2023-08-29T14:03:23.760' AS DateTime), CAST(N'2023-08-29T14:03:23.760' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'32165d79812a479e93b5', N'Roasted Pork Bánh Mì (Vietnamese Sandwich)', N'2088e23a19284eb1924e', N'VN', N'M0001', N'Bánh mì sandwiches are delicious. I''ll never forget my first real bánh mì. I remember thinking to myself, this isn''t just one of the best sandwiches I''ve ever had to eat, but one of the best things, period. Not only do we get amazing contrasts in flavor and texture, but also the temperature difference between the crisp, warm, meat-filled roll, and cool, crunchy vegetables makes this so much fun to eat.', 25, 10, 0, 35, 1, 612, 36, 36, 2916, CAST(N'2023-08-29T10:27:48.000' AS DateTime), CAST(N'2023-08-29T10:27:48.000' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'36652c30256a447b9d9c', N'Tex-Mex Pork Chops and Rice Skillet', N'2088e23a19284eb1924e', N'MX', N'M0003', N'Brown some chops, then add vegetables, broth and rice. This dinner only needs one skillet, a knife, a cutting board, some measuring cups and spoons, a can opener, and a mixing and serving spoon. We like this with simple quesadillas and a salad. Add some avocado slices, if you like!', 15, 30, 0, 45, 4, NULL, NULL, NULL, 0, CAST(N'2023-08-29T13:52:09.460' AS DateTime), CAST(N'2023-08-29T13:52:09.460' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'496c5630198f4b0e9d68', N'Vietnamese Fresh Spring Rolls', N'1b4cfb67eaa74051ac0f', N'VN', N'M0002', N'These Vietnamese spring rolls are a refreshing change from the usual fried variety and have become a family favorite. They are a great summertime appetizer and delicious dipped in one or both of the sauces.', 32, 2, 21, 55, 1, 0, 0, 0, 0, CAST(N'2023-08-29T13:28:59.973' AS DateTime), CAST(N'2023-08-29T13:28:59.973' AS DateTime), CAST(N'2023-08-29T13:30:14.577' AS DateTime), 1)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'531a0a31a60d485fadfe', N'Chrismast Cake', N'1b4cfb67eaa74051ac0f', N'VN', N'M0002', N'A Christmas cake is a rich and festive dessert traditionally enjoyed during the holiday season. It is typically made with a dense, spiced fruitcake base, filled with a variety of dried fruits, nuts, and often soaked in alcohol like brandy or rum. The cake is often adorned with a layer of marzipan and royal icing, which can be elaborately decorated with holiday-themed designs.', 32, 2, 21, 55, 1, NULL, NULL, NULL, 0, CAST(N'2023-08-29T13:29:53.407' AS DateTime), CAST(N'2023-08-29T13:29:53.407' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'62082df1777449798aa4', N'tessting on', N'1b4cfb67eaa74051ac0f', N'AI', N'M0001', N'dess', 3, 8, 3, 14, 2, 413, 44, 127, 2969, CAST(N'2023-08-29T08:27:47.650' AS DateTime), CAST(N'2023-08-29T08:27:47.650' AS DateTime), CAST(N'2023-08-29T09:12:47.857' AS DateTime), 1)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'69b882c46f66461a9e27', N'Shredded Chicken Tacos (Lunch)', N'60769b703f4248648cd3', N'AE', N'M0002', N'', 12, 20, 20, 52, 5, 1, 0, 82, 740, CAST(N'2023-08-29T01:28:31.583' AS DateTime), CAST(N'2023-08-29T01:28:31.583' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'6e3dcbb6e73241c989dc', N'Vietnamese Iced Coffee', N'1b4cfb67eaa74051ac0f', N'VN', N'M0001', N'A strong Vietnamese iced coffee recipe with sweetened condensed milk. Chilled on ice, this makes an unbeatable Southeast Asian treat. Even those who only take their coffee black will like this. Serve it on hot summer days or as an evening treat. We learned this in Vietnam, and now drink almost all our espresso this way.', 5, 5, 0, 10, 4, 668, 223, 309, 6342, CAST(N'2023-08-29T13:51:18.497' AS DateTime), CAST(N'2023-08-29T13:51:18.497' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'7ad9329f81894e21bdfe', N'Vietnamese Fresh Spring Rolls', N'1b4cfb67eaa74051ac0f', N'VN', N'M0002', N'These Vietnamese spring rolls are a refreshing change from the usual fried variety and have become a family favorite. They are a great summertime appetizer and delicious dipped in one or both of the sauces.', 45, 5, 0, 50, 8, 0, 0, 0, 0, CAST(N'2023-08-29T20:45:18.567' AS DateTime), CAST(N'2023-08-29T20:45:18.803' AS DateTime), CAST(N'2023-08-29T13:51:31.760' AS DateTime), 1)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'80d745e9deec413aa78e', N'Vietnamese Fresh Spring Rolls', N'1b4cfb67eaa74051ac0f', N'VN', N'M0002', N'These Vietnamese spring rolls are a refreshing change from the usual fried variety and have become a family favorite. They are a great summertime appetizer and delicious dipped in one or both of the sauces.', 45, 5, 0, 50, 8, 1254, 311, 519, 10928, CAST(N'2023-08-29T20:47:08.243' AS DateTime), CAST(N'2023-08-29T20:47:08.393' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'8ae3a29b05804e738916', N'Vietnamese Fresh Spring Rolls', N'1b4cfb67eaa74051ac0f', N'VN', N'M0002', N'These Vietnamese spring rolls are a refreshing change from the usual fried variety and have become a family favorite. They are a great summertime appetizer and delicious dipped in one or both of the sauces.', 45, 5, 0, 50, 8, 0, 0, 0, 0, CAST(N'2023-08-29T20:43:01.480' AS DateTime), CAST(N'2023-08-29T20:43:01.703' AS DateTime), CAST(N'2023-08-29T13:51:39.607' AS DateTime), 1)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'8c2d7127f534423aac97', N'Homemade VietNam Pho', N'2088e23a19284eb1924e', N'VN', N'M0001', N'Authentic, Vietnamese pho soup is all about the broth! Beef bones, fish sauce, star anise, and ginger simmer for at least 6 hours, creating a complex, aromatic broth that may not be quick, but it''s certainly delicious. The flavorful broth is ladled over rice noodles and thinly sliced beef and topped with fresh garnishes.', 20, 420, 0, 440, 4, NULL, NULL, NULL, 0, CAST(N'2023-08-29T10:22:44.803' AS DateTime), CAST(N'2023-08-29T10:22:44.803' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'91ce7161456d44dbb89e', N'Vietnamese Fresh Spring Rolls', N'2088e23a19284eb1924e', N'VN', N'M0002', N'These Vietnamese spring rolls are a refreshing change from the usual fried variety and have become a family favorite. They are a great summertime appetizer and delicious dipped in one or both of the sauces.', 45, 5, 0, 50, 8, 0, 0, 0, 0, CAST(N'2023-08-29T13:40:01.830' AS DateTime), CAST(N'2023-08-29T13:40:01.830' AS DateTime), CAST(N'2023-08-29T13:46:52.133' AS DateTime), 1)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'945c17bcc4864effa5eb', N'Hamburger (Breakfast)', N'60769b703f4248648cd3', N'AD', N'M0001', N'', 1, 20, 2, 23, 1, NULL, NULL, NULL, 0, CAST(N'2023-08-29T01:26:08.127' AS DateTime), CAST(N'2023-08-29T01:26:08.127' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'acc0c914d54345dfa93a', N'Easy Chicken and Broccoli Alfredo', N'2088e23a19284eb1924e', N'AF', N'M0003', N'Fettuccine is used for this chicken and broccoli Alfredo recipe but you can use your favorite pasta.', 10, 20, 0, 30, 4, NULL, NULL, NULL, 0, CAST(N'2023-08-29T20:29:13.933' AS DateTime), CAST(N'2023-08-29T20:29:13.933' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'b9589acfa7e140abb30b', N'Test Delete (dinner)', N'60769b703f4248648cd3', N'CG', N'M0003', N'', 12, 12, 12, 36, 1, 0, 10, 35, 355, CAST(N'2023-08-29T11:39:28.520' AS DateTime), CAST(N'2023-08-29T11:39:28.520' AS DateTime), CAST(N'2023-08-29T11:40:47.477' AS DateTime), 1)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'c81271cece0e41c1a347', N'Test Delete recipe (Dinner)', N'60769b703f4248648cd3', N'AG', N'M0003', N'', 10, 2, 20, 32, 1, 0, 10, 35, 355, CAST(N'2023-08-29T11:37:58.830' AS DateTime), CAST(N'2023-08-29T11:37:58.830' AS DateTime), CAST(N'2023-08-29T11:38:26.183' AS DateTime), 1)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'dd62bb4a4fd0476c90b1', N' ba', N'1b4cfb67eaa74051ac0f', N'AG', N'M0003', N'bbb', 231, 32, 12, 275, 21, NULL, NULL, NULL, 0, CAST(N'2023-08-29T08:28:28.537' AS DateTime), CAST(N'2023-08-29T08:28:28.537' AS DateTime), NULL, 1)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'e87beae773694c1c89f1', N'Sausage with Sauce (Dinner)', N'60769b703f4248648cd3', N'AX', N'M0003', N'', 10, 29, 10, 49, 3, 3, 0, 245, 2219, CAST(N'2023-08-29T09:22:02.657' AS DateTime), CAST(N'2023-08-29T09:22:02.657' AS DateTime), CAST(N'2023-08-29T09:43:52.460' AS DateTime), 1)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [Carbohydrate], [Protein], [Fat], [Calories], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'fa3ab1b59e414f6488d2', N'sth (Lunch)', N'60769b703f4248648cd3', N'AE', N'M0002', N'', 1, 1, 1, 3, 1, 100, 0, 0, 399, CAST(N'2023-08-29T09:59:50.460' AS DateTime), CAST(N'2023-08-29T09:59:50.460' AS DateTime), NULL, 1)
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'12a3c07029234c74a2a7', N'b868aba865fa4492be7c', N'8c2d7127f534423aac97', 5, N'Delicious recipe of Pho', CAST(N'2023-08-29T20:04:05.627' AS DateTime), CAST(N'2023-08-29T20:04:05.627' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'3786af1d4ab748a091a3', N'1d4eea6852374bbba3ed', N'62082df1777449798aa4', 5, N'good', CAST(N'2023-08-29T09:08:12.537' AS DateTime), CAST(N'2023-08-29T09:08:12.537' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'480c16b7af55488b8901', N'1d4eea6852374bbba3ed', N'32165d79812a479e93b5', 5, N'In love', CAST(N'2023-08-29T13:54:14.223' AS DateTime), CAST(N'2023-08-29T13:54:14.223' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'57d0e2db937d4488a93b', N'1d4eea6852374bbba3ed', N'6e3dcbb6e73241c989dc', 5, N'very good especially strong', CAST(N'2023-08-29T14:02:59.977' AS DateTime), CAST(N'2023-08-29T14:02:59.977' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'5e590e3577cc41f69b58', N'b868aba865fa4492be7c', N'6e3dcbb6e73241c989dc', 5, N'My favorite drink', CAST(N'2023-08-29T13:57:05.960' AS DateTime), CAST(N'2023-08-29T13:57:05.960' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'73c93485bfbb4d1a8b5b', N'b868aba865fa4492be7c', N'36652c30256a447b9d9c', 1, N'Not my taste', CAST(N'2023-08-29T14:02:19.943' AS DateTime), CAST(N'2023-08-29T14:02:19.943' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'7e8ecbf6b0334d789519', N'1d4eea6852374bbba3ed', N'80d745e9deec413aa78e', 4, N'very good, for me', CAST(N'2023-08-29T13:54:33.597' AS DateTime), CAST(N'2023-08-29T13:54:33.597' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'98fdfc9f1bd540f59f51', N'1d4eea6852374bbba3ed', N'8c2d7127f534423aac97', 5, N'The reall Phou', CAST(N'2023-08-29T13:53:43.600' AS DateTime), CAST(N'2023-08-29T13:53:43.600' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'bebd233023934056815b', N'b868aba865fa4492be7c', N'32165d79812a479e93b5', 4, N'I love it', CAST(N'2023-08-29T20:04:34.887' AS DateTime), CAST(N'2023-08-29T20:04:34.887' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'd508112deb524dae91eb', N'1d4eea6852374bbba3ed', N'acc0c914d54345dfa93a', 4, N'good', CAST(N'2023-08-29T13:55:06.563' AS DateTime), CAST(N'2023-08-29T13:55:06.563' AS DateTime))
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'107229d2d1c04e4c830d', NULL, NULL, N'Nguyen Huu Vinh (K15 HCM)', N'vinhnhse151180@fpt.edu.vn', N'https://lh3.googleusercontent.com/a/AAcHTteW9MGR7a80rjnaQ-gr0XeaeMZ1NDQFxcCjIwFDARQP=s96-c', N'111643714267608097701', NULL, NULL, NULL, CAST(N'2023-08-16T07:23:01.730' AS DateTime), CAST(N'2023-08-16T07:23:01.730' AS DateTime), 0, 0)
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'1b4cfb67eaa74051ac0f', NULL, N'"Heat the food to the right degree, to make it healthy and germ free."', N'Nguyen Cong Vu (K15 HCM)', N'vuncse151184@fpt.edu.vn', N'https://lh3.googleusercontent.com/a/AAcHTtccq042jmpce_GCz1YOO8EbCZE2YmuXFZEcYEJXEDEp6Q=s96-c', N'102154017976058839733', N'0338010423', N'Vinhome Grand Park s302', NULL, CAST(N'2023-08-20T02:59:51.093' AS DateTime), CAST(N'2023-08-23T02:06:01.730' AS DateTime), 0, 2)
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'1d4eea6852374bbba3ed', NULL, NULL, N'Vũ Nguyễn', N'zzzvulovezzz@gmail.com', N'https://lh3.googleusercontent.com/a/AAcHTtep7a-1kbqwpQ_M--FcUfUnfizldTcBw_tNLYioZpgtKhQ=s96-c', N'107058069586416634930', NULL, NULL, NULL, CAST(N'2023-08-16T12:13:47.637' AS DateTime), CAST(N'2023-08-23T02:05:58.837' AS DateTime), 0, 1)
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'1eabf9a3a487442a9219', NULL, NULL, N'Nguyễn Vũ', N'vu12ace3@gmail.com', N'https://lh3.googleusercontent.com/a/AAcHTtckyLIW5n-egdwTgz5-crm9rjJqAZvrN9Y4WgKWg21M=s96-c', N'100201184006812873288', NULL, NULL, NULL, CAST(N'2023-08-23T01:58:45.437' AS DateTime), CAST(N'2023-08-23T02:05:55.803' AS DateTime), 0, 1)
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'2088e23a19284eb1924e', NULL, N'"Heat the food to the right degree, to make it healthy and germ free."', N'Thanh Tung (Cooker)', N'tungntse151166@fpt.edu.vn', N'https://lh3.googleusercontent.com/a/AAcHTtedFa1NAe-NB0_xLWxQS31yLwlZCP6Mgia1SKivQod-1g=s96-c', N'111642914489008266230', N'', N'', NULL, CAST(N'2023-08-17T00:54:57.533' AS DateTime), CAST(N'2023-08-19T01:33:29.807' AS DateTime), 0, 2)
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'233ecd03e7bb4d1fa30b', NULL, NULL, N'Dao Anh Tu (K15 HCM)', N'tudase151149@fpt.edu.vn', N'https://lh3.googleusercontent.com/a/AAcHTtd0JVTUPG83TCmj3DX9cAop6AJtIJQt2cahlxa0k0SRiHk=s96-c', N'116037527002951123712', NULL, NULL, NULL, CAST(N'2023-08-16T09:33:39.380' AS DateTime), CAST(N'2023-08-19T13:44:29.637' AS DateTime), 0, 1)
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'2d5b9c2e631a4913bb23', NULL, NULL, N'Không phải là Vinh', N'vinhnguyen50501@gmail.com', N'https://lh3.googleusercontent.com/a/AAcHTtdKyeiJy0dVGiduubkYehlIChkQFwj7lXW8lb0HVjMMQig=s96-c', N'100535088785222488815', NULL, NULL, NULL, CAST(N'2023-08-17T02:30:25.273' AS DateTime), CAST(N'2023-08-21T02:06:31.923' AS DateTime), 0, 1)
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'361ed1d8338c4d379648', NULL, NULL, N'Tú T', N'ganyu.2151@gmail.com', N'https://lh3.googleusercontent.com/a/AAcHTtfMHj_cFX28og5trHJTsZ27qTHy7pnjwrtQwMZlALhn7w=s96-c', N'114241499934185044008', NULL, NULL, NULL, CAST(N'2023-08-23T02:22:46.197' AS DateTime), CAST(N'2023-08-23T02:22:46.197' AS DateTime), 0, 1)
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'4ee7d5475cf1480e9f76', NULL, NULL, N'Vũ Nguyễn', N'hi3.vuno1@gmail.com', N'https://lh3.googleusercontent.com/a/AAcHTtfT_wwvT1vJ8lSkqKGIwNd1boqYee-jRC4G30kt_3A2=s96-c', N'103958057739445184671', NULL, NULL, NULL, CAST(N'2023-08-23T02:18:41.753' AS DateTime), CAST(N'2023-08-23T02:18:41.753' AS DateTime), 0, 1)
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'60769b703f4248648cd3', NULL, NULL, N'TRó Con', N'sieutrommagickid1412@gmail.com', N'https://lh3.googleusercontent.com/a/AAcHTtcXS0U_-Zj87l4qcQ6yaHBM3FOhYg6tsiZHGyhb2wZYReg=s96-c', N'115542460270909692080', NULL, NULL, NULL, CAST(N'2023-08-18T02:19:25.493' AS DateTime), CAST(N'2023-08-25T15:08:40.467' AS DateTime), 0, 2)
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'8553dea200ec4f7e8b6a', NULL, NULL, N'Thanh Tung Nguyen', N'tung14062001@gmail.com', N'https://lh3.googleusercontent.com/a/AAcHTtf_Hxh3YuzJ3r3HOEo3-V5LpAnCTIG8V_vXiKH5lNwe=s96-c', N'115063297405620570263', NULL, NULL, NULL, CAST(N'2023-08-23T01:55:37.937' AS DateTime), CAST(N'2023-08-23T01:55:37.937' AS DateTime), 0, 0)
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'8d03f655cb2f483ca8af', NULL, NULL, N'Tu Dao Anh', N'tudase151149@gmail.com', N'https://lh3.googleusercontent.com/a/AAcHTtcVfDjaElFACUHhzmr916CzSrG27Sup1WD_KQvpYt-yaw=s96-c', N'101232676956960335315', NULL, NULL, NULL, CAST(N'2023-08-23T13:03:13.460' AS DateTime), CAST(N'2023-08-23T13:03:13.460' AS DateTime), 0, 0)
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'adc1180042a94805a10f', NULL, NULL, N'chan paimon', N'paimon.2151@gmail.com', N'https://lh3.googleusercontent.com/a/AAcHTtcxhzEv0gVo-GpYp73CUZNn7QQmUPLVSJB_A98CfbAFHA=s96-c', N'112345351324736521299', NULL, NULL, NULL, CAST(N'2023-08-21T11:10:17.473' AS DateTime), CAST(N'2023-08-22T11:42:18.970' AS DateTime), 0, 2)
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'b868aba865fa4492be7c', NULL, N'Hello my name is Tung', N'Thanh Tung (User)', N'tungnt14062001@gmail.com', N'https://lh3.googleusercontent.com/a/AAcHTteamewrdtg8vW3004yDUGU6HEGkdyA6NnkY4g6zpGzI=s96-c', N'115474841404682840042', N'0123456789', N'HCM', NULL, CAST(N'2023-08-16T03:02:40.547' AS DateTime), CAST(N'2023-08-16T03:02:40.547' AS DateTime), 0, 1)
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'e94a2ec5779e4c47be5d', NULL, NULL, N'Phó Sắc Cường', N'f0rsaken.prx012@gmail.com', N'https://lh3.googleusercontent.com/a/AAcHTteM2ybWeuy1mTSLVlKCZmDGEnrTmZk5e88zZ-Ly1QxEDg=s96-c', N'108422255311599285219', NULL, NULL, NULL, CAST(N'2023-08-18T00:35:41.933' AS DateTime), CAST(N'2023-08-18T00:35:41.933' AS DateTime), 0, 1)
GO
ALTER TABLE [dbo].[Country] ADD  CONSTRAINT [DF__Country__HasReci__6FE99F9F]  DEFAULT ((0)) FOR [HasRecipe]
GO
ALTER TABLE [dbo].[Country] ADD  CONSTRAINT [DF__Country__IsDelet__70DDC3D8]  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [dbo].[Meal] ADD  CONSTRAINT [DF__Meal__IsDelete__02FC7413]  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [dbo].[Photo] ADD  CONSTRAINT [DF__Photo__IsDelete__2180FB33]  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [dbo].[Plan] ADD  CONSTRAINT [DF__Plan__IsDelete__08B54D69]  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [dbo].[Recipe] ADD  CONSTRAINT [DF__Recipe__IsDelete__0D7A0286]  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [dbo].[UserAccount] ADD  CONSTRAINT [DF__UserAccou__IsDel__797309D9]  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [dbo].[UserAccount] ADD  CONSTRAINT [DF__UserAccoun__Role__7A672E12]  DEFAULT ((1)) FOR [Role]
GO
ALTER TABLE [dbo].[Direction]  WITH CHECK ADD  CONSTRAINT [FK_Direction_Recipe] FOREIGN KEY([RecipeId])
REFERENCES [dbo].[Recipe] ([RecipeId])
GO
ALTER TABLE [dbo].[Direction] CHECK CONSTRAINT [FK_Direction_Recipe]
GO
ALTER TABLE [dbo].[FavoriteRecipe]  WITH CHECK ADD  CONSTRAINT [FK_FavoriteRecipe_Recipe] FOREIGN KEY([RecipeId])
REFERENCES [dbo].[Recipe] ([RecipeId])
GO
ALTER TABLE [dbo].[FavoriteRecipe] CHECK CONSTRAINT [FK_FavoriteRecipe_Recipe]
GO
ALTER TABLE [dbo].[FavoriteRecipe]  WITH CHECK ADD  CONSTRAINT [FK_FavoriteRecipe_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserAccount] ([UserId])
GO
ALTER TABLE [dbo].[FavoriteRecipe] CHECK CONSTRAINT [FK_FavoriteRecipe_User]
GO
ALTER TABLE [dbo].[IngredientOfRecipe]  WITH CHECK ADD  CONSTRAINT [FK_IngredientOfRecipe_Ingredient] FOREIGN KEY([IngredientId])
REFERENCES [dbo].[Ingredient] ([IngredientId])
GO
ALTER TABLE [dbo].[IngredientOfRecipe] CHECK CONSTRAINT [FK_IngredientOfRecipe_Ingredient]
GO
ALTER TABLE [dbo].[IngredientOfRecipe]  WITH CHECK ADD  CONSTRAINT [FK_IngredientOfRecipe_Recipe] FOREIGN KEY([RecipeId])
REFERENCES [dbo].[Recipe] ([RecipeId])
GO
ALTER TABLE [dbo].[IngredientOfRecipe] CHECK CONSTRAINT [FK_IngredientOfRecipe_Recipe]
GO
ALTER TABLE [dbo].[Photo]  WITH CHECK ADD  CONSTRAINT [FK_Photo_Recipe] FOREIGN KEY([RecipeId])
REFERENCES [dbo].[Recipe] ([RecipeId])
GO
ALTER TABLE [dbo].[Photo] CHECK CONSTRAINT [FK_Photo_Recipe]
GO
ALTER TABLE [dbo].[Photo]  WITH CHECK ADD  CONSTRAINT [FK_Photo_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserAccount] ([UserId])
GO
ALTER TABLE [dbo].[Photo] CHECK CONSTRAINT [FK_Photo_User]
GO
ALTER TABLE [dbo].[Plan]  WITH CHECK ADD  CONSTRAINT [FK_Plan_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserAccount] ([UserId])
GO
ALTER TABLE [dbo].[Plan] CHECK CONSTRAINT [FK_Plan_User]
GO
ALTER TABLE [dbo].[PlanDetail]  WITH CHECK ADD  CONSTRAINT [FK_PlanDetail_Plan] FOREIGN KEY([PlanId])
REFERENCES [dbo].[Plan] ([PlanId])
GO
ALTER TABLE [dbo].[PlanDetail] CHECK CONSTRAINT [FK_PlanDetail_Plan]
GO
ALTER TABLE [dbo].[PlanDetail]  WITH CHECK ADD  CONSTRAINT [FK_PlanDetail_Recipe] FOREIGN KEY([RecipeId])
REFERENCES [dbo].[Recipe] ([RecipeId])
GO
ALTER TABLE [dbo].[PlanDetail] CHECK CONSTRAINT [FK_PlanDetail_Recipe]
GO
ALTER TABLE [dbo].[Recipe]  WITH CHECK ADD  CONSTRAINT [FK_Recipe_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([CountryId])
GO
ALTER TABLE [dbo].[Recipe] CHECK CONSTRAINT [FK_Recipe_Country]
GO
ALTER TABLE [dbo].[Recipe]  WITH CHECK ADD  CONSTRAINT [FK_Recipe_Meal] FOREIGN KEY([MealId])
REFERENCES [dbo].[Meal] ([MealId])
GO
ALTER TABLE [dbo].[Recipe] CHECK CONSTRAINT [FK_Recipe_Meal]
GO
ALTER TABLE [dbo].[Recipe]  WITH CHECK ADD  CONSTRAINT [FK_Recipe_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserAccount] ([UserId])
GO
ALTER TABLE [dbo].[Recipe] CHECK CONSTRAINT [FK_Recipe_User]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Recipe] FOREIGN KEY([RecipeId])
REFERENCES [dbo].[Recipe] ([RecipeId])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Recipe]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserAccount] ([UserId])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_User]
GO
ALTER DATABASE [RecipeOrganizerDB] SET  READ_WRITE 
GO
