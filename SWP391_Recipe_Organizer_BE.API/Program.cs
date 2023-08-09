using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using SWP391_Recipe_Organizer_BE.Repo.DataAccess;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
using SWP391_Recipe_Organizer_BE.Repo.Repository;
using System.Text;

namespace SWP391_Recipe_Organizer_BE.API
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.

            builder.Services.AddControllers();
            builder.Services.AddDbContext<RecipeOrganizerDBContext>(opt =>
            opt.UseSqlServer(builder.Configuration.GetConnectionString("RecipeOrganizerDB")));
            var jwtSettings = builder.Configuration.GetSection("JwtSettings");
            builder.Services.AddAuthentication(option =>
            {
                option.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                option.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            }).AddJwtBearer(option =>
            {
                option.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidateIssuerSigningKey = true,
                    ValidIssuer = jwtSettings["Issuer"],
                    ValidAudience = jwtSettings["Audience"],
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings["SecretKey"]))
                };
            });
            builder.Services.AddCors(options =>
            {
                options.AddDefaultPolicy(builder =>
                {
                    builder.AllowAnyOrigin()
                           .AllowAnyMethod()
                           .AllowAnyHeader();
                });
            });
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Title = "Recipe Organizer API", Version = "v1" });

                // Configure Swagger to use JWT authentication
                c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
                {
                    Description = "JWT Authorization header using the Bearer scheme",
                    Name = "Authorization",
                    In = ParameterLocation.Header,
                    Type = SecuritySchemeType.ApiKey
                });

                c.AddSecurityRequirement(new OpenApiSecurityRequirement
        {
            {
                new OpenApiSecurityScheme
                {
                    Reference = new OpenApiReference
                    {
                        Type = ReferenceType.SecurityScheme,
                        Id = "Bearer"
                    }
                },
                new string[] { }
            }
        });
            });

            builder.Services.AddScoped<ICountryRepository, CountryRepository>();
            builder.Services.AddScoped<IDirectionRepository, DirectionRepository>();
            builder.Services.AddScoped<IFavoriteRecipeRepository, FavoriteRecipeRepository>();
            builder.Services.AddScoped<IIngredientRepository, IngredientRepository>();
            builder.Services.AddScoped<IIngredientOfRecipeRepository, IngredientOfRecipeRepository>();
            builder.Services.AddScoped<IMealRepository, MealRepository>();
            builder.Services.AddScoped<INutritionRepository, NutritionRepository>();
            builder.Services.AddScoped<INutritionInRecipeRepository, NutritionInRecipeRepository>();
            builder.Services.AddScoped<IPhotoRepository, PhotoRepository>();
            builder.Services.AddScoped<IPlanRepository, PlanRepository>();
            builder.Services.AddScoped<IPlanDetailRepository, PlanDetailRepository>();
            builder.Services.AddScoped<IRecipeRepository, RecipeRepository>();
            builder.Services.AddScoped<IReviewRepository, ReviewRepository>();
            builder.Services.AddScoped<IUserAccountRepository, UserAccountRepository>();

            //builder.Services.AddScoped<ICountryService, CountryService>();
            //builder.Services.AddScoped<IDirectionService, DirectionService>();
            //builder.Services.AddScoped<IFavoriteRecipeService, FavoriteRecipeService>();
            //builder.Services.AddScoped<IIngredientService, IngredientService>();
            //builder.Services.AddScoped<IIngredientOfRecipeService, IngredientOfRecipeService>();
            //builder.Services.AddScoped<IMealService, MealService>();
            //builder.Services.AddScoped<INutritionService, NutritionService>();
            //builder.Services.AddScoped<INutritionInRecipeService, NutritionInRecipeService>();
            //builder.Services.AddScoped<IPhotoService, PhotoService>();
            //builder.Services.AddScoped<IPlanService, PlanService>();
            //builder.Services.AddScoped<IPlanDetailService, PlanDetailService>();
            //builder.Services.AddScoped<IRecipeService, RecipeService>();
            //builder.Services.AddScoped<IReviewService, ReviewService>();
            //builder.Services.AddScoped<IUserAccountService, UserAccountService>();
            var app = builder.Build();

            // Configure the HTTP request pipeline.
            app.UseSwagger();
            app.UseSwaggerUI();
            app.UseCors();
            app.UseHttpsRedirection();

            app.UseAuthentication();
            app.UseAuthorization();

            app.MapControllers();

            app.Run();
        }
    }
}