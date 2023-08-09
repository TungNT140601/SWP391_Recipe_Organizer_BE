using Microsoft.EntityFrameworkCore;
using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.DataAccess
{
    public class RecipeOrganizerDbContext: DbContext
    {
        public RecipeOrganizerDbContext(DbContextOptions<RecipeOrganizerDbContext> options) : base(options) { }

        public DbSet<Country> Countries { get; set; }
        public DbSet<Direction> Directions { get; set; }
        public DbSet<FavoriteRecipe> FavoriteRecipes { get; set; }
        public DbSet<Ingredient> Ingredients { get; set; }
        public DbSet<IngredientOfRecipe> IngredientOfRecipes { get; set; }
        public DbSet<Meal> Meals { get; set; }
        public DbSet<Nutrition> Nutritions { get; set; }
        public DbSet<NutritionInRecipe> NutritionInRecipes { get; set; }
        public DbSet<Photo> Photos { get; set; }
        public DbSet<Plan> Plans { get; set; }
        public DbSet<PlanDetail> PlanDetails { get; set; }
        public DbSet<Recipe> Recipes { get; set; }
        public DbSet<Review> Reviews { get; set; }
        public DbSet<UserAccount> UserAccounts { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Country>(entity =>
            {
                entity.ToTable("Country");

                entity.HasKey(e => e.CountryId);

                entity.Property(e => e.CountryId)
                .HasColumnName("CountryId")
                .HasColumnType("nvarchar")
                .HasMaxLength(20);

                entity.Property(e => e.CountryName)
                .HasColumnName("CountryName")
                .HasColumnType("nvarchar")
                .HasMaxLength(255);

                
            });
        }
        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);

    }
}
