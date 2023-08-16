USE [RecipeOrganizerDB]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 8/16/2023 9:27:11 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Direction]    Script Date: 8/16/2023 9:27:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Direction](
	[DirectionsId] [nvarchar](20) NOT NULL,
	[RecipeId] [nvarchar](20) NULL,
	[DirectionsNum] [int] NULL,
	[DirectionsDesc] [nvarchar](255) NULL,
 CONSTRAINT [PK_Direction] PRIMARY KEY CLUSTERED 
(
	[DirectionsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FavoriteRecipe]    Script Date: 8/16/2023 9:27:11 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ingredient]    Script Date: 8/16/2023 9:27:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingredient](
	[IngredientId] [nvarchar](20) NOT NULL,
	[IngredientName] [nvarchar](255) NULL,
	[IsDelete] [bit] NULL,
 CONSTRAINT [PK_Ingredient] PRIMARY KEY CLUSTERED 
(
	[IngredientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IngredientOfRecipe]    Script Date: 8/16/2023 9:27:11 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Meal]    Script Date: 8/16/2023 9:27:11 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Photo]    Script Date: 8/16/2023 9:27:11 AM ******/
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
	[IsDelete] [bit] NULL,
 CONSTRAINT [PK_Photo] PRIMARY KEY CLUSTERED 
(
	[PhotoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Plan]    Script Date: 8/16/2023 9:27:11 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlanDetail]    Script Date: 8/16/2023 9:27:11 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recipe]    Script Date: 8/16/2023 9:27:11 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Review]    Script Date: 8/16/2023 9:27:11 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAccount]    Script Date: 8/16/2023 9:27:11 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AD', N'Andorra', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AE', N'United Arab Emirates', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AF', N'Afghanistan', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AG', N'Antigua and Barbuda', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AI', N'Anguilla', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AL', N'Albania', 0, 0)
GO
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'AM', N'Armenia', 0, 0)
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
INSERT [dbo].[Country] ([CountryId], [CountryName], [HasRecipe], [IsDelete]) VALUES (N'MX', N'Mexico', 0, 0)
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
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'07f0a8bf0bba4cd4ad4f', N'01479969c83147e8a818', 3, N'string3 Update')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'297aeb071ee54e84a2bf', N'01479969c83147e8a818', 5, N'string5 Update')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'2cc2aa5ddd7f4666a095', N'b1a3f23a14fe41f98251', 0, N'string')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'325cb62b682944ceba43', N'4c2c23d705da42e49880', 0, N'string')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'3cdd095e85184eb68877', N'28ea3f81540548419ff7', 0, N'string')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'402a878d5b9042b8ad1f', N'2baf749109e04231b7ee', 2, N'Heat a non-stick skillet over medium heat and add butter.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'44aaa190679047daaf19', N'5b239651016649d4a9b4', 0, N'string')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'631072439fa641eaba35', N'e59dafd29b3e43c7bb52', 0, N'string')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'68f63bd9661a464ba789', N'd41096f0a6264fcb9870', 0, N'string')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'717e5bbbbc014baa937a', N'2baf749109e04231b7ee', 1, N'Crack the eggs into a bowl and whisk until well beaten.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'796d60c745c643038331', N'7e26c0c8d1f444a4b336', 0, N'string')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'a14d1beba09f48fe8c33', N'2baf749109e04231b7ee', 3, N'Pour the beaten eggs into the skillet and cook until the edges start to set.')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'a86eb53b27f541c1b506', N'261a0d1ba51e4ef3bf59', 0, N'string')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'b96f3a34af9341918414', N'01479969c83147e8a818', 1, N'string1 Update')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'e90180859edf4eb8b4a5', N'01479969c83147e8a818', 4, N'string4 Update')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'f5ae6a4835844530af3a', N'01479969c83147e8a818', 2, N'string2 Update')
GO
INSERT [dbo].[Direction] ([DirectionsId], [RecipeId], [DirectionsNum], [DirectionsDesc]) VALUES (N'f68ff4e6404243cc8838', N'7f9ebf6066604e83951f', 0, N'string')
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'03FB3DC7-0AE6-477A-8', N'2700e8b6af184fa493f3', N'2baf749109e04231b7ee', CAST(N'2023-08-13T03:53:28.450' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'08BE696F-AFAD-4F4F-9', N'e473c8b9c32946af84bc', N'e59dafd29b3e43c7bb52', CAST(N'2023-08-13T03:53:28.570' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'0A7C7EB9-6D18-4252-A', N'4d04771382964a2ea2bb', N'b1a3f23a14fe41f98251', CAST(N'2023-08-13T03:53:28.433' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'158D39EE-03EA-4219-9', N'2700e8b6af184fa493f3', N'5b239651016649d4a9b4', CAST(N'2023-08-13T03:53:28.400' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'1883F95D-E90B-481F-9', N'4d04771382964a2ea2bb', N'd41096f0a6264fcb9870', CAST(N'2023-08-13T03:53:28.600' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'18CB89B5-AE91-45E9-A', N'2700e8b6af184fa493f3', N'd41096f0a6264fcb9870', CAST(N'2023-08-13T03:53:28.457' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'1F223AE7-0F37-43E1-9', N'28cf0dbd03794d7ba580', N'e59dafd29b3e43c7bb52', CAST(N'2023-08-13T03:53:28.610' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'2625AE65-8BDA-4E54-8', N'733e042343a2405d83dd', N'261a0d1ba51e4ef3bf59', CAST(N'2023-08-13T03:53:28.623' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'3440B971-B4E6-44B0-B', N'e473c8b9c32946af84bc', N'7f9ebf6066604e83951f', CAST(N'2023-08-13T03:53:28.443' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'3967D3BD-C6B6-4FDD-9', N'4d04771382964a2ea2bb', N'7f9ebf6066604e83951f', CAST(N'2023-08-13T03:53:28.647' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'39AE26C6-A366-4D70-A', N'733e042343a2405d83dd', N'2baf749109e04231b7ee', CAST(N'2023-08-13T03:53:28.593' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'3AB9D8FA-F29F-4668-8', N'4d04771382964a2ea2bb', N'5b239651016649d4a9b4', CAST(N'2023-08-13T03:53:28.373' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'3DD43ABC-13A0-4EC8-B', N'a94a6e75f3284093a2e5', N'01479969c83147e8a818', CAST(N'2023-08-13T03:53:28.380' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'4208A7FC-895D-49B6-9', N'733e042343a2405d83dd', N'28ea3f81540548419ff7', CAST(N'2023-08-13T03:53:28.397' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'4CD02C4E-7943-4216-8', N'a94a6e75f3284093a2e5', N'01479969c83147e8a818', CAST(N'2023-08-13T03:53:28.630' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'4F6494D6-AB72-4110-9', N'a94a6e75f3284093a2e5', N'd41096f0a6264fcb9870', CAST(N'2023-08-13T03:53:28.467' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'512FEA47-F589-4E5E-B', N'a94a6e75f3284093a2e5', N'b1a3f23a14fe41f98251', CAST(N'2023-08-13T03:53:28.383' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'56B62381-9E70-4BE0-8', N'2700e8b6af184fa493f3', N'2baf749109e04231b7ee', CAST(N'2023-08-13T03:53:28.430' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'5BF9F5C0-1D60-4EE7-A', N'e473c8b9c32946af84bc', N'7f9ebf6066604e83951f', CAST(N'2023-08-13T03:53:28.483' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'6124756F-E0E0-4803-A', N'2700e8b6af184fa493f3', N'7f9ebf6066604e83951f', CAST(N'2023-08-13T03:53:28.407' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'61D745F2-FF36-4E0B-B', N'28cf0dbd03794d7ba580', N'5b239651016649d4a9b4', CAST(N'2023-08-13T03:53:28.520' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'630BA44F-220F-46EC-9', N'e473c8b9c32946af84bc', N'28ea3f81540548419ff7', CAST(N'2023-08-13T03:53:28.490' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'633B016D-9EE0-40AA-8', N'733e042343a2405d83dd', N'b1a3f23a14fe41f98251', CAST(N'2023-08-13T03:53:28.530' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'66F4795B-603C-4853-A', N'a94a6e75f3284093a2e5', N'261a0d1ba51e4ef3bf59', CAST(N'2023-08-13T03:53:28.460' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'758239C8-090C-4BBD-9', N'733e042343a2405d83dd', N'7e26c0c8d1f444a4b336', CAST(N'2023-08-13T03:53:28.390' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'7693DE26-7D4E-4743-B', N'28cf0dbd03794d7ba580', N'd41096f0a6264fcb9870', CAST(N'2023-08-13T03:53:28.503' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'77E64CD1-83F6-4004-8', N'4d04771382964a2ea2bb', N'28ea3f81540548419ff7', CAST(N'2023-08-13T03:53:28.350' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'796D20C5-5248-42D4-A', N'e473c8b9c32946af84bc', N'7e26c0c8d1f444a4b336', CAST(N'2023-08-13T03:53:28.533' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'7978B978-2BCA-4736-8', N'2700e8b6af184fa493f3', N'e59dafd29b3e43c7bb52', CAST(N'2023-08-13T03:53:28.440' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'7DE3E210-CF9D-4416-A', N'4d04771382964a2ea2bb', N'7e26c0c8d1f444a4b336', CAST(N'2023-08-13T03:53:28.500' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'86983787-8D24-4679-8', N'a94a6e75f3284093a2e5', N'5b239651016649d4a9b4', CAST(N'2023-08-13T03:53:28.423' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'92306F93-0D33-47A3-8', N'e473c8b9c32946af84bc', N'28ea3f81540548419ff7', CAST(N'2023-08-13T03:53:28.573' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'9498C66D-93E5-423F-B', N'4d04771382964a2ea2bb', N'5b239651016649d4a9b4', CAST(N'2023-08-13T03:53:28.617' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'94d7288d3e4a4573bce9', N'28cf0dbd03794d7ba580', N'2baf749109e04231b7ee', CAST(N'2023-08-14T18:49:45.070' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'9FB234DC-0A3B-4692-A', N'4d04771382964a2ea2bb', N'01479969c83147e8a818', CAST(N'2023-08-13T03:53:28.493' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'A3D37694-914B-426A-9', N'a94a6e75f3284093a2e5', N'5b239651016649d4a9b4', CAST(N'2023-08-13T03:53:28.417' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'ACA5E981-6952-4B0D-8', N'28cf0dbd03794d7ba580', N'7e26c0c8d1f444a4b336', CAST(N'2023-08-13T03:53:28.633' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'B2CDECAA-FAAD-401D-B', N'4d04771382964a2ea2bb', N'b1a3f23a14fe41f98251', CAST(N'2023-08-13T03:53:28.670' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'B4D0FB12-929C-4C00-B', N'733e042343a2405d83dd', N'5b239651016649d4a9b4', CAST(N'2023-08-13T03:53:28.540' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'B89AE720-FA09-4E92-B', N'733e042343a2405d83dd', N'e59dafd29b3e43c7bb52', CAST(N'2023-08-13T03:53:28.640' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'BB4FD580-72E1-4519-A', N'733e042343a2405d83dd', N'e59dafd29b3e43c7bb52', CAST(N'2023-08-13T03:53:28.650' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'BC93E6A5-D372-4F54-8', N'2700e8b6af184fa493f3', N'28ea3f81540548419ff7', CAST(N'2023-08-13T03:53:28.663' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'C16F827A-12F0-4715-B', N'2700e8b6af184fa493f3', N'b1a3f23a14fe41f98251', CAST(N'2023-08-13T03:53:28.657' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'C3AE1E7E-3600-4F82-9', N'2700e8b6af184fa493f3', N'7f9ebf6066604e83951f', CAST(N'2023-08-13T03:53:28.410' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'CFC4C84B-67EA-42C1-B', N'28cf0dbd03794d7ba580', N'261a0d1ba51e4ef3bf59', CAST(N'2023-08-13T03:53:28.547' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'D3D88E55-A884-4A26-B', N'e473c8b9c32946af84bc', N'2baf749109e04231b7ee', CAST(N'2023-08-13T03:53:28.563' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'D55B5334-8A83-4AD8-8', N'2700e8b6af184fa493f3', N'b1a3f23a14fe41f98251', CAST(N'2023-08-13T03:53:28.583' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'E5F9F27B-52E7-4D9C-A', N'a94a6e75f3284093a2e5', N'28ea3f81540548419ff7', CAST(N'2023-08-13T03:53:28.510' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'E981A451-B41D-41B2-B', N'733e042343a2405d83dd', N'4c2c23d705da42e49880', CAST(N'2023-08-13T03:53:28.587' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'FD3A7516-D6D9-4881-A', N'28cf0dbd03794d7ba580', N'2baf749109e04231b7ee', CAST(N'2023-08-13T03:53:28.607' AS DateTime))
GO
INSERT [dbo].[FavoriteRecipe] ([FavoriteId], [UserId], [RecipeId], [FavoriteTime]) VALUES (N'FDFF6DA6-FF39-40C5-B', N'a94a6e75f3284093a2e5', N'7e26c0c8d1f444a4b336', CAST(N'2023-08-13T03:53:28.477' AS DateTime))
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'ALM030', N'Sliced Almonds', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'APP019', N'Apples', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'BAK006', N'Baking Powder', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'BAN018', N'Ripe Bananas', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'BAS041', N'Fresh Basil', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'BLU020', N'Blueberries', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'BRO010', N'Brown Sugar', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'BUT003', N'Unsalted Butter', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'CAR035', N'Carrots', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'CEL036', N'Celery', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'CHC008', N'Chocolate Chips', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'CHE024', N'Cream Cheese', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'CIN013', N'Ground Cinnamon', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'COC009', N'Cocoa Powder', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'COC029', N'Coconut Flakes', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'CON025', N'Condensed Milk', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'CRA027', N'Cranberries', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'EGG004', N'Eggs', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'FLR001', N'All-Purpose Flour', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'GAR038', N'Garlic', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'GRA028', N'Graham Cracker Crumbs', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'HEA026', N'Heavy Cream', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'HON034', N'Honey', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'HON047', N'Honey', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'LEM015', N'Lemon Zest', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'LEM039', N'Lemon Juice', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'LIM040', N'Lime Juice', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'MAP033', N'Maple Syrup', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'MIL005', N'Whole Milk', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'MNG023', N'Mango', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'NUT011', N'Chopped Nuts', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'NUT014', N'Nutmeg', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'OAT031', N'Rolled Oats', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'ONI037', N'Onions', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'ORA016', N'Orange Zest', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'ORE043', N'Fresh Oregano', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'PAP049', N'Paprika', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'PAR042', N'Parsley', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'PEP048', N'Black Pepper', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'PIN022', N'Pineapple', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'RAI032', N'Raisins', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'RAS046', N'Fresh Raspberries', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'ROSE045', N'Rosemary', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'SAL012', N'Salt', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'STR021', N'Strawberries', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'SUG002', N'Granulated Sugar', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'THY044', N'Thyme', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'TUM050', N'Turmeric', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'VAN007', N'Vanilla Extract', 0)
GO
INSERT [dbo].[Ingredient] ([IngredientId], [IngredientName], [IsDelete]) VALUES (N'YOG017', N'Greek Yogurt', 0)
GO
INSERT [dbo].[Meal] ([MealId], [MealName], [IsDelete]) VALUES (N'M001', N'Breakfast', 0)
GO
INSERT [dbo].[Meal] ([MealId], [MealName], [IsDelete]) VALUES (N'M002', N'Lunch', 0)
GO
INSERT [dbo].[Meal] ([MealId], [MealName], [IsDelete]) VALUES (N'M003', N'Dinner', 0)
GO
INSERT [dbo].[Meal] ([MealId], [MealName], [IsDelete]) VALUES (N'M004', N'Snack', 0)
GO
INSERT [dbo].[Meal] ([MealId], [MealName], [IsDelete]) VALUES (N'M005', N'Brunch', 0)
GO
INSERT [dbo].[Meal] ([MealId], [MealName], [IsDelete]) VALUES (N'M006', N'Dessert', 0)
GO
INSERT [dbo].[Meal] ([MealId], [MealName], [IsDelete]) VALUES (N'M007', N'Appetizer', 0)
GO
INSERT [dbo].[Meal] ([MealId], [MealName], [IsDelete]) VALUES (N'M008', N'Beverage', 0)
GO
INSERT [dbo].[Meal] ([MealId], [MealName], [IsDelete]) VALUES (N'M009', N'Main Course', 0)
GO
INSERT [dbo].[Meal] ([MealId], [MealName], [IsDelete]) VALUES (N'M010', N'Side Dish', 0)
GOINSERT [dbo].[Photo] ([PhotoId], [PhotoName], [RecipeId], [UserId], [UploadTime], [IsDelete]) VALUES (N'0635dce27eae47c3bc83', N'https://firebasestorage.googleapis.com/v0/b/recipe-organizer-swp391.appspot.com/o/Recipes%2Fomelet-image.jpg?alt=media&token=8c452896-cc01-43bd-88ac-23b226d7431f', N'2baf749109e04231b7ee', N'e473c8b9c32946af84bc', CAST(N'2023-08-12T21:49:24.027' AS DateTime), 0)
GO
INSERT [dbo].[Photo] ([PhotoId], [PhotoName], [RecipeId], [UserId], [UploadTime], [IsDelete]) VALUES (N'5b9c578711df4ea78b2b', N'string', N'7f9ebf6066604e83951f', N'e473c8b9c32946af84bc', CAST(N'2023-08-12T21:47:06.967' AS DateTime), 0)
GO
INSERT [dbo].[Photo] ([PhotoId], [PhotoName], [RecipeId], [UserId], [UploadTime], [IsDelete]) VALUES (N'6af66624635848f88cb1', N'string', N'5b239651016649d4a9b4', N'e473c8b9c32946af84bc', CAST(N'2023-08-12T21:46:55.980' AS DateTime), 0)
GO
INSERT [dbo].[Photo] ([PhotoId], [PhotoName], [RecipeId], [UserId], [UploadTime], [IsDelete]) VALUES (N'9b943fe2215d42bf9500', N'string', N'261a0d1ba51e4ef3bf59', N'e473c8b9c32946af84bc', CAST(N'2023-08-12T21:47:03.213' AS DateTime), 0)
GO
INSERT [dbo].[Photo] ([PhotoId], [PhotoName], [RecipeId], [UserId], [UploadTime], [IsDelete]) VALUES (N'9c767b0d481f474794c8', N'string', N'7e26c0c8d1f444a4b336', N'e473c8b9c32946af84bc', CAST(N'2023-08-12T21:47:10.077' AS DateTime), 0)
GO
INSERT [dbo].[Photo] ([PhotoId], [PhotoName], [RecipeId], [UserId], [UploadTime], [IsDelete]) VALUES (N'b01a29f8a42146bca7af', N'string', N'01479969c83147e8a818', N'e473c8b9c32946af84bc', CAST(N'2023-08-13T18:11:08.603' AS DateTime), 0)
GO
INSERT [dbo].[Photo] ([PhotoId], [PhotoName], [RecipeId], [UserId], [UploadTime], [IsDelete]) VALUES (N'bf4ed13f5ffe4ef7a8f0', N'string', N'd41096f0a6264fcb9870', N'e473c8b9c32946af84bc', CAST(N'2023-08-12T21:47:14.193' AS DateTime), 0)
GO
INSERT [dbo].[Photo] ([PhotoId], [PhotoName], [RecipeId], [UserId], [UploadTime], [IsDelete]) VALUES (N'cdf6a8ee861940a796fa', N'string', N'4c2c23d705da42e49880', N'e473c8b9c32946af84bc', CAST(N'2023-08-12T21:46:59.653' AS DateTime), 0)
GO
INSERT [dbo].[Photo] ([PhotoId], [PhotoName], [RecipeId], [UserId], [UploadTime], [IsDelete]) VALUES (N'd8f2b37884cc47cfa887', N'string', N'e59dafd29b3e43c7bb52', N'e473c8b9c32946af84bc', CAST(N'2023-08-12T21:47:17.717' AS DateTime), 0)
GO
INSERT [dbo].[Photo] ([PhotoId], [PhotoName], [RecipeId], [UserId], [UploadTime], [IsDelete]) VALUES (N'f64781a4f9044c3da9d2', N'string', N'b1a3f23a14fe41f98251', N'e473c8b9c32946af84bc', CAST(N'2023-08-12T21:46:47.743' AS DateTime), 0)
GO
INSERT [dbo].[Photo] ([PhotoId], [PhotoName], [RecipeId], [UserId], [UploadTime], [IsDelete]) VALUES (N'f72330b6040143459278', N'string', N'28ea3f81540548419ff7', N'e473c8b9c32946af84bc', CAST(N'2023-08-12T21:45:35.070' AS DateTime), 0)
GO
INSERT [dbo].[Plan] ([PlanId], [UserId], [PlanName], [PlanDescription], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'6589f7d26f4a4f748a8b', N'28cf0dbd03794d7ba580', N'', N'', CAST(N'2023-08-14T12:32:54.587' AS DateTime), CAST(N'2023-08-14T12:32:54.587' AS DateTime), NULL, 0)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'07b173de8cea44358fd5', N'6589f7d26f4a4f748a8b', N'2baf749109e04231b7ee', CAST(N'2023-08-14T12:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'1486d6cc2d3644a0886f', N'6589f7d26f4a4f748a8b', N'2baf749109e04231b7ee', CAST(N'2023-08-14T12:00:00.000' AS DateTime), 3)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'2c8d57d36e5a4a8086a9', N'6589f7d26f4a4f748a8b', N'2baf749109e04231b7ee', CAST(N'2023-08-14T12:00:00.000' AS DateTime), 3)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'3063939b954f47e1ad8d', N'6589f7d26f4a4f748a8b', N'2baf749109e04231b7ee', CAST(N'2023-08-14T12:00:00.000' AS DateTime), 3)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'6268126e8ac242f5bf47', N'6589f7d26f4a4f748a8b', N'2baf749109e04231b7ee', CAST(N'2023-08-14T12:00:00.000' AS DateTime), 2)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'86b3eb0da0b14d37bb60', N'6589f7d26f4a4f748a8b', N'2baf749109e04231b7ee', CAST(N'2023-08-14T12:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'891d0255661648aaa6f5', N'6589f7d26f4a4f748a8b', N'2baf749109e04231b7ee', CAST(N'2023-08-14T12:00:00.000' AS DateTime), 2)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'89a05ae2b80845359068', N'6589f7d26f4a4f748a8b', N'2baf749109e04231b7ee', CAST(N'2023-08-14T12:00:00.000' AS DateTime), 3)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'9d2616fb922b40a18e54', N'6589f7d26f4a4f748a8b', N'2baf749109e04231b7ee', CAST(N'2023-08-14T12:00:00.000' AS DateTime), 3)
GO
INSERT [dbo].[PlanDetail] ([PlanDetailId], [PlanId], [RecipeId], [Date], [MealOfDate]) VALUES (N'b6fef38a979b4145be95', N'6589f7d26f4a4f748a8b', N'2baf749109e04231b7ee', CAST(N'2023-08-14T12:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'01479969c83147e8a818', N'string10', N'e473c8b9c32946af84bc', N'VN', N'M001', N'string', 3, 4, 5, 3, 4, CAST(N'2023-08-12T21:47:22.797' AS DateTime), CAST(N'2023-08-12T21:47:22.797' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'261a0d1ba51e4ef3bf59', N'string05', N'e473c8b9c32946af84bc', N'VN', N'M001', N'string', 0, 0, 0, 0, 0, CAST(N'2023-08-12T21:47:03.127' AS DateTime), CAST(N'2023-08-12T21:47:03.127' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'28ea3f81540548419ff7', N'string', N'e473c8b9c32946af84bc', N'VN', N'M001', N'string', 0, 0, 0, 0, 0, CAST(N'2023-08-12T21:45:20.410' AS DateTime), CAST(N'2023-08-12T21:45:20.410' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'2baf749109e04231b7ee', N'Delicious Omelette', N'e473c8b9c32946af84bc', N'VN', N'M001', N'A mouthwatering omelette recipe with a variety of fresh ingredients.', 15, 10, 5, 30, 2, CAST(N'2023-08-12T21:49:23.927' AS DateTime), CAST(N'2023-08-12T21:49:23.927' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'4c2c23d705da42e49880', N'string04', N'e473c8b9c32946af84bc', N'VN', N'M001', N'string', 0, 0, 0, 0, 0, CAST(N'2023-08-12T21:46:59.563' AS DateTime), CAST(N'2023-08-12T21:46:59.563' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'5b239651016649d4a9b4', N'string03', N'e473c8b9c32946af84bc', N'VN', N'M001', N'string', 0, 0, 0, 0, 0, CAST(N'2023-08-12T21:46:55.893' AS DateTime), CAST(N'2023-08-12T21:46:55.893' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'7e26c0c8d1f444a4b336', N'string07', N'e473c8b9c32946af84bc', N'VN', N'M001', N'string', 0, 0, 0, 0, 0, CAST(N'2023-08-12T21:47:09.970' AS DateTime), CAST(N'2023-08-12T21:47:09.970' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'7f9ebf6066604e83951f', N'string06', N'e473c8b9c32946af84bc', N'VN', N'M001', N'string', 0, 0, 0, 0, 0, CAST(N'2023-08-12T21:47:06.883' AS DateTime), CAST(N'2023-08-12T21:47:06.883' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'b1a3f23a14fe41f98251', N'string02', N'e473c8b9c32946af84bc', N'VN', N'M001', N'string', 0, 0, 0, 0, 0, CAST(N'2023-08-12T21:46:44.733' AS DateTime), CAST(N'2023-08-12T21:46:44.733' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'd41096f0a6264fcb9870', N'string08', N'e473c8b9c32946af84bc', N'VN', N'M001', N'string', 0, 0, 0, 0, 0, CAST(N'2023-08-12T21:47:14.110' AS DateTime), CAST(N'2023-08-12T21:47:14.110' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Recipe] ([RecipeId], [RecipeName], [UserId], [CountryId], [MealId], [Description], [PrepTime], [CookTime], [StandTime], [TotalTime], [Servings], [CreateTime], [UpdateTime], [DeleteTime], [IsDelete]) VALUES (N'e59dafd29b3e43c7bb52', N'string09', N'e473c8b9c32946af84bc', N'VN', N'M001', N'string', 0, 0, 0, 0, 0, CAST(N'2023-08-12T21:47:17.630' AS DateTime), CAST(N'2023-08-12T21:47:17.630' AS DateTime), NULL, 0)
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'REV001', N'2700e8b6af184fa493f3', N'01479969c83147e8a818', 5, N'Great recipe!', CAST(N'2023-08-13T03:47:55.880' AS DateTime), CAST(N'2023-08-13T03:47:55.880' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'REV002', N'28cf0dbd03794d7ba580', N'261a0d1ba51e4ef3bf59', 4, N'Tasty dish!', CAST(N'2023-08-13T03:47:55.880' AS DateTime), CAST(N'2023-08-13T03:47:55.880' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'REV003', N'4d04771382964a2ea2bb', N'28ea3f81540548419ff7', 3, N'Nice flavors.', CAST(N'2023-08-13T03:47:55.880' AS DateTime), CAST(N'2023-08-13T03:47:55.880' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'REV004', N'a94a6e75f3284093a2e5', N'2baf749109e04231b7ee', 5, N'Delicious!', CAST(N'2023-08-13T03:47:55.880' AS DateTime), CAST(N'2023-08-13T03:47:55.880' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'REV005', N'28cf0dbd03794d7ba580', N'4c2c23d705da42e49880', 4, N'Loved it.', CAST(N'2023-08-13T03:47:55.880' AS DateTime), CAST(N'2023-08-13T03:47:55.880' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'REV006', N'4d04771382964a2ea2bb', N'5b239651016649d4a9b4', 3, N'A new favorite.', CAST(N'2023-08-13T03:47:55.880' AS DateTime), CAST(N'2023-08-13T03:47:55.880' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'REV007', N'a94a6e75f3284093a2e5', N'7e26c0c8d1f444a4b336', 2, N'Must try!', CAST(N'2023-08-13T03:47:55.880' AS DateTime), CAST(N'2023-08-13T03:47:55.880' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'REV008', N'28cf0dbd03794d7ba580', N'7f9ebf6066604e83951f', 4, N'Impressive.', CAST(N'2023-08-13T03:47:55.880' AS DateTime), CAST(N'2023-08-13T03:47:55.880' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'REV009', N'4d04771382964a2ea2bb', N'b1a3f23a14fe41f98251', 3, N'Flavorful.', CAST(N'2023-08-13T03:47:55.880' AS DateTime), CAST(N'2023-08-13T03:47:55.880' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'REV010', N'a94a6e75f3284093a2e5', N'd41096f0a6264fcb9870', 5, N'Perfectly cooked.', CAST(N'2023-08-13T03:47:55.880' AS DateTime), CAST(N'2023-08-13T03:47:55.880' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'REV011', N'28cf0dbd03794d7ba580', N'e59dafd29b3e43c7bb52', 4, N'Satisfying.', CAST(N'2023-08-13T03:47:55.880' AS DateTime), CAST(N'2023-08-13T03:47:55.880' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'REV012', N'4d04771382964a2ea2bb', N'2baf749109e04231b7ee', 1, N'Not my taste.', CAST(N'2023-08-13T03:47:55.880' AS DateTime), CAST(N'2023-08-13T03:47:55.880' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'REV013', N'28cf0dbd03794d7ba580', N'5b239651016649d4a9b4', 2, N'Could be better.', CAST(N'2023-08-13T03:47:55.880' AS DateTime), CAST(N'2023-08-13T03:47:55.880' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'REV014', N'4d04771382964a2ea2bb', N'7e26c0c8d1f444a4b336', 3, N'Good recipe, needs improvement.', CAST(N'2023-08-13T03:47:55.880' AS DateTime), CAST(N'2023-08-13T03:47:55.880' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'REV015', N'a94a6e75f3284093a2e5', N'7f9ebf6066604e83951f', 4, N'Thumbs up!', CAST(N'2023-08-13T03:47:55.880' AS DateTime), CAST(N'2023-08-13T03:47:55.880' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'REV016', N'28cf0dbd03794d7ba580', N'b1a3f23a14fe41f98251', 5, N'Awesome.', CAST(N'2023-08-13T03:47:55.880' AS DateTime), CAST(N'2023-08-13T03:47:55.880' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'REV017', N'4d04771382964a2ea2bb', N'd41096f0a6264fcb9870', 4, N'Nice dish.', CAST(N'2023-08-13T03:47:55.880' AS DateTime), CAST(N'2023-08-13T03:47:55.880' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'REV018', N'a94a6e75f3284093a2e5', N'e59dafd29b3e43c7bb52', 5, N'Loved the taste.', CAST(N'2023-08-13T03:47:55.880' AS DateTime), CAST(N'2023-08-13T03:47:55.880' AS DateTime))
GO
INSERT [dbo].[Review] ([ReviewId], [UserId], [RecipeId], [VoteNum], [Comment], [CreateTime], [UpdateTime]) VALUES (N'REV019', N'a94a6e75f3284093a2e5', N'4c2c23d705da42e49880', 3, N'Normal', CAST(N'2023-08-13T03:47:55.880' AS DateTime), CAST(N'2023-08-13T03:47:55.880' AS DateTime))
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'2700e8b6af184fa493f3', NULL, NULL, NULL, N'vuncse151184@fpt.edu.vn', NULL, N'102154017976058839733', NULL, NULL, NULL, CAST(N'2023-08-12T12:41:07.383' AS DateTime), CAST(N'2023-08-12T12:41:07.383' AS DateTime), 0, 1)
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'28cf0dbd03794d7ba580', N'guest', NULL, N'Thanh Tùng Nguyễn', N'tungnt14062001@gmail.com', N'https://lh3.googleusercontent.com/a/AAcHTteamewrdtg8vW3004yDUGU6HEGkdyA6NnkY4g6zpGzI=s96-c', N'115474841404682840042', NULL, NULL, N'$2a$11$gK8YWscITafRtWrikJypMOYbx6v5QThbHJo2MeioNWa8TJqMpzjVG', CAST(N'2023-08-12T16:47:08.993' AS DateTime), CAST(N'2023-08-12T16:47:08.993' AS DateTime), 0, 1)
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'4d04771382964a2ea2bb', NULL, NULL, N'Dao Anh Tu (K15 HCM)', N'tudase151149@fpt.edu.vn', N'https://lh3.googleusercontent.com/a/AAcHTtd0JVTUPG83TCmj3DX9cAop6AJtIJQt2cahlxa0k0SRiHk=s96-c', N'116037527002951123712', NULL, NULL, NULL, CAST(N'2023-08-12T14:59:52.233' AS DateTime), CAST(N'2023-08-12T14:59:52.233' AS DateTime), 0, 1)
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'733e042343a2405d83dd', N'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'$2a$11$gK8YWscITafRtWrikJypMOTWqCE6xdfZcI7WA9rCXCgq5fyLRuuMy', CAST(N'2023-08-11T08:48:08.007' AS DateTime), CAST(N'2023-08-11T08:48:08.007' AS DateTime), 0, 0)
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'a94a6e75f3284093a2e5', NULL, NULL, NULL, N'vinhnhse151180@fpt.edu.vn', NULL, N'111643714267608097701', NULL, NULL, NULL, CAST(N'2023-08-12T00:58:33.197' AS DateTime), CAST(N'2023-08-12T00:58:33.197' AS DateTime), 0, 1)
GO
INSERT [dbo].[UserAccount] ([UserId], [Username], [UserInfo], [FullName], [Email], [AvatarName], [GoogleToken], [PhoneNum], [Address], [Password], [CreateDate], [UpdateDate], [IsDelete], [Role]) VALUES (N'e473c8b9c32946af84bc', N'cooker', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'$2a$11$gK8YWscITafRtWrikJypMOlLpwZe6yTOEXrf512l7ftSoD03d7f/W', CAST(N'2023-08-11T08:48:17.550' AS DateTime), CAST(N'2023-08-11T08:48:17.550' AS DateTime), 0, 2)
GO
ALTER TABLE [dbo].[Country] ADD  CONSTRAINT [DF__Country__HasReci__6FE99F9F]  DEFAULT ((0)) FOR [HasRecipe]
GO
ALTER TABLE [dbo].[Country] ADD  CONSTRAINT [DF__Country__IsDelet__70DDC3D8]  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [dbo].[Ingredient] ADD  CONSTRAINT [DF__Ingredien__IsDel__00200768]  DEFAULT ((0)) FOR [IsDelete]
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
