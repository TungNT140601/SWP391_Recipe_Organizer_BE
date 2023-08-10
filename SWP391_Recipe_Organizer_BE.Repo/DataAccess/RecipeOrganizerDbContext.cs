using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using SWP391_Recipe_Organizer_BE.Repo.EntityModel;

namespace SWP391_Recipe_Organizer_BE.Repo.DataAccess
{
    public partial class RecipeOrganizerDBContext : DbContext
    {
        public RecipeOrganizerDBContext()
        {
        }

        public RecipeOrganizerDBContext(DbContextOptions<RecipeOrganizerDBContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Country> Countries { get; set; } = null!;
        public virtual DbSet<Direction> Directions { get; set; } = null!;
        public virtual DbSet<FavoriteRecipe> FavoriteRecipes { get; set; } = null!;
        public virtual DbSet<Ingredient> Ingredients { get; set; } = null!;
        public virtual DbSet<IngredientOfRecipe> IngredientOfRecipes { get; set; } = null!;
        public virtual DbSet<Meal> Meals { get; set; } = null!;
        public virtual DbSet<Nutrition> Nutritions { get; set; } = null!;
        public virtual DbSet<NutritionInRecipe> NutritionInRecipes { get; set; } = null!;
        public virtual DbSet<Photo> Photos { get; set; } = null!;
        public virtual DbSet<Plan> Plans { get; set; } = null!;
        public virtual DbSet<PlanDetail> PlanDetails { get; set; } = null!;
        public virtual DbSet<Recipe> Recipes { get; set; } = null!;
        public virtual DbSet<Review> Reviews { get; set; } = null!;
        public virtual DbSet<UserAccount> UserAccounts { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("server=(local);uid=sa;pwd=1;database=RecipeOrganizerDB;TrustServerCertificate=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Country>(entity =>
            {
                entity.ToTable("Country");

                entity.Property(e => e.CountryId).HasMaxLength(20);

                entity.Property(e => e.CountryName).HasMaxLength(255);

                entity.Property(e => e.HasRecipe).HasDefaultValueSql("((0))");

                entity.Property(e => e.IsDelete).HasDefaultValueSql("((0))");
            });

            modelBuilder.Entity<Direction>(entity =>
            {
                entity.HasKey(e => e.DirectionsId)
                    .HasName("PK__Directio__D9F441A879D6BC7A");

                entity.ToTable("Direction");

                entity.Property(e => e.DirectionsId).HasMaxLength(20);

                entity.Property(e => e.DirectionsDesc).HasMaxLength(255);

                entity.Property(e => e.RecipeId).HasMaxLength(20);

                entity.HasOne(d => d.Recipe)
                    .WithMany(p => p.Directions)
                    .HasForeignKey(d => d.RecipeId)
                    .HasConstraintName("FK__Direction__Recip__5812160E");
            });

            modelBuilder.Entity<FavoriteRecipe>(entity =>
            {
                entity.HasKey(e => e.FavoriteId)
                    .HasName("PK__Favorite__CE74FAD56A831364");

                entity.ToTable("FavoriteRecipe");

                entity.Property(e => e.FavoriteId).HasMaxLength(20);

                entity.Property(e => e.FavoriteTime).HasColumnType("datetime");

                entity.Property(e => e.RecipeId).HasMaxLength(20);

                entity.Property(e => e.UserId).HasMaxLength(20);

                entity.HasOne(d => d.Recipe)
                    .WithMany(p => p.FavoriteRecipes)
                    .HasForeignKey(d => d.RecipeId)
                    .HasConstraintName("FK__FavoriteR__Recip__59063A47");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.FavoriteRecipes)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK__FavoriteR__UserI__59FA5E80");
            });

            modelBuilder.Entity<Ingredient>(entity =>
            {
                entity.ToTable("Ingredient");

                entity.Property(e => e.IngredientId).HasMaxLength(20);

                entity.Property(e => e.IngredientName).HasMaxLength(255);

                entity.Property(e => e.IsDelete).HasDefaultValueSql("((0))");
            });

            modelBuilder.Entity<IngredientOfRecipe>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("IngredientOfRecipe");

                entity.Property(e => e.Description).HasMaxLength(255);

                entity.Property(e => e.IngredientId).HasMaxLength(20);

                entity.Property(e => e.RecipeId).HasMaxLength(20);

                entity.HasOne(d => d.Ingredient)
                    .WithMany()
                    .HasForeignKey(d => d.IngredientId)
                    .HasConstraintName("FK__Ingredien__Ingre__5AEE82B9");

                entity.HasOne(d => d.Recipe)
                    .WithMany()
                    .HasForeignKey(d => d.RecipeId)
                    .HasConstraintName("FK__Ingredien__Recip__5BE2A6F2");
            });

            modelBuilder.Entity<Meal>(entity =>
            {
                entity.ToTable("Meal");

                entity.Property(e => e.MealId).HasMaxLength(20);

                entity.Property(e => e.IsDelete).HasDefaultValueSql("((0))");

                entity.Property(e => e.MealName).HasMaxLength(255);
            });

            modelBuilder.Entity<Nutrition>(entity =>
            {
                entity.ToTable("Nutrition");

                entity.Property(e => e.NutritionId).HasMaxLength(20);

                entity.Property(e => e.IsDelete).HasDefaultValueSql("((0))");

                entity.Property(e => e.NutritionName).HasMaxLength(255);
            });

            modelBuilder.Entity<NutritionInRecipe>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("NutritionInRecipe");

                entity.Property(e => e.NutritionId).HasMaxLength(20);

                entity.Property(e => e.RecipeId).HasMaxLength(20);

                entity.HasOne(d => d.Nutrition)
                    .WithMany()
                    .HasForeignKey(d => d.NutritionId)
                    .HasConstraintName("FK__Nutrition__Nutri__5CD6CB2B");

                entity.HasOne(d => d.Recipe)
                    .WithMany()
                    .HasForeignKey(d => d.RecipeId)
                    .HasConstraintName("FK__Nutrition__Recip__5DCAEF64");
            });

            modelBuilder.Entity<Photo>(entity =>
            {
                entity.ToTable("Photo");

                entity.Property(e => e.PhotoId).HasMaxLength(20);

                entity.Property(e => e.IsDelete).HasDefaultValueSql("((0))");

                entity.Property(e => e.PhotoName).HasMaxLength(255);

                entity.Property(e => e.RecipeId).HasMaxLength(20);

                entity.Property(e => e.UploadTime).HasColumnType("datetime");

                entity.Property(e => e.UserId).HasMaxLength(20);

                entity.HasOne(d => d.Recipe)
                    .WithMany(p => p.Photos)
                    .HasForeignKey(d => d.RecipeId)
                    .HasConstraintName("FK__Photo__RecipeId__5EBF139D");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Photos)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK__Photo__UserId__5FB337D6");
            });

            modelBuilder.Entity<Plan>(entity =>
            {
                entity.ToTable("Plan");

                entity.Property(e => e.PlanId).HasMaxLength(20);

                entity.Property(e => e.CreateTime).HasColumnType("datetime");

                entity.Property(e => e.DeleteTime).HasColumnType("datetime");

                entity.Property(e => e.IsDelete).HasDefaultValueSql("((0))");

                entity.Property(e => e.PlanDescription).HasColumnType("text");

                entity.Property(e => e.PlanName).HasMaxLength(255);

                entity.Property(e => e.UpdateTime).HasColumnType("datetime");

                entity.Property(e => e.UserId).HasMaxLength(20);

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Plans)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK__Plan__UserId__60A75C0F");
            });

            modelBuilder.Entity<PlanDetail>(entity =>
            {
                entity.ToTable("PlanDetail");

                entity.Property(e => e.PlanDetailId).HasMaxLength(20);

                entity.Property(e => e.Date).HasColumnType("datetime");

                entity.Property(e => e.PlanId).HasMaxLength(20);

                entity.Property(e => e.RecipeId).HasMaxLength(20);

                entity.HasOne(d => d.Plan)
                    .WithMany(p => p.PlanDetails)
                    .HasForeignKey(d => d.PlanId)
                    .HasConstraintName("FK__PlanDetai__PlanI__619B8048");

                entity.HasOne(d => d.Recipe)
                    .WithMany(p => p.PlanDetails)
                    .HasForeignKey(d => d.RecipeId)
                    .HasConstraintName("FK__PlanDetai__Recip__628FA481");
            });

            modelBuilder.Entity<Recipe>(entity =>
            {
                entity.ToTable("Recipe");

                entity.Property(e => e.RecipeId).HasMaxLength(20);

                entity.Property(e => e.CountryId).HasMaxLength(20);

                entity.Property(e => e.CreateTime).HasColumnType("datetime");

                entity.Property(e => e.DeleteTime).HasColumnType("datetime");

                entity.Property(e => e.Description).HasColumnType("text");

                entity.Property(e => e.IsDelete).HasDefaultValueSql("((0))");

                entity.Property(e => e.MealId).HasMaxLength(20);

                entity.Property(e => e.RecipeName).HasMaxLength(255);

                entity.Property(e => e.UpdateTime).HasColumnType("datetime");

                entity.Property(e => e.UserId).HasMaxLength(20);

                entity.HasOne(d => d.Country)
                    .WithMany(p => p.Recipes)
                    .HasForeignKey(d => d.CountryId)
                    .HasConstraintName("FK__Recipe__CountryI__6383C8BA");

                entity.HasOne(d => d.Meal)
                    .WithMany(p => p.Recipes)
                    .HasForeignKey(d => d.MealId)
                    .HasConstraintName("FK__Recipe__MealId__6477ECF3");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Recipes)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK__Recipe__UserId__656C112C");
            });

            modelBuilder.Entity<Review>(entity =>
            {
                entity.ToTable("Review");

                entity.Property(e => e.ReviewId).HasMaxLength(20);

                entity.Property(e => e.CreateTime).HasColumnType("datetime");

                entity.Property(e => e.RecipeId).HasMaxLength(20);

                entity.Property(e => e.UpdateTime).HasColumnType("datetime");

                entity.Property(e => e.UserId).HasMaxLength(20);

                entity.HasOne(d => d.Recipe)
                    .WithMany(p => p.Reviews)
                    .HasForeignKey(d => d.RecipeId)
                    .HasConstraintName("FK__Review__RecipeId__66603565");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Reviews)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK__Review__UserId__6754599E");
            });

            modelBuilder.Entity<UserAccount>(entity =>
            {
                entity.HasKey(e => e.UserId)
                    .HasName("PK__UserAcco__1788CC4C47760BAB");

                entity.ToTable("UserAccount");

                entity.Property(e => e.UserId).HasMaxLength(20);

                entity.Property(e => e.Address).HasMaxLength(255);

                entity.Property(e => e.AvatarName).HasMaxLength(255);

                entity.Property(e => e.CreateDate).HasColumnType("datetime");

                entity.Property(e => e.Email).HasMaxLength(255);

                entity.Property(e => e.FullName).HasMaxLength(255);

                entity.Property(e => e.GoogleToken).HasMaxLength(255);

                entity.Property(e => e.IsDelete).HasDefaultValueSql("((0))");

                entity.Property(e => e.Password).HasMaxLength(255);

                entity.Property(e => e.PhoneNum).HasMaxLength(10);

                entity.Property(e => e.Role).HasDefaultValueSql("((1))");

                entity.Property(e => e.UpdateDate).HasColumnType("datetime");

                entity.Property(e => e.UserInfo).HasColumnType("text");

                entity.Property(e => e.Username).HasMaxLength(255);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
