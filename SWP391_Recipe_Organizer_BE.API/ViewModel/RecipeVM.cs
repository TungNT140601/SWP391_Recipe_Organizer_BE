﻿using SWP391_Recipe_Organizer_BE.Repo.EntityModel;

namespace SWP391_Recipe_Organizer_BE.API.ViewModel
{
    public class RecipeVM
    {
        public string? RecipeId { get; set; }
        public string? RecipeName { get; set; }
        public string? UserId { get; set; }
        public string? CountryId { get; set; }
        public string? MealId { get; set; }
        public string? Description { get; set; }
        public int? PrepTime { get; set; }
        public int? CookTime { get; set; }
        public int? StandTime { get; set; }
        public int? TotalTime { get; set; }
        public int? Servings { get; set; }
        public int? Carbohydrate { get; set; } = 0;
        public int? Protein { get; set; } = 0;
        public int? Fat { get; set; } = 0;
        public int? Calories { get; set; } = 0;
        public DateTime? UpdateTime { get; set; }
        public UserAccountVM? UserAccountVMs { get; set; }
        public MealVM? MealVMs { get; set; }
        public int? TotalReview { get; set; }
        public double? AveVote { get; set; }
        public int? TotalFavorite { get; set; }
        public bool? IsFavorite { get; set; } = false;
        public bool IsDelete { get; set; }
        public ReviewVM? UserReview { get; set; }
        public CountryVM? CountryVM { get; set; }
        public ICollection<PhotoVM>? PhotoVMs { get; set; }
        public ICollection<DirectionVM>? DirectionVMs { get; set; }
        public ICollection<ReviewVM>? ReviewVMs { get; set; }
        public virtual ICollection<IngredientOfRecipeVM>? IngredientOfRecipeVMs { get; set; }
    }
    public class RecipeAddUpdateVM
    {
        public string? RecipeId { get; set; }
        public string RecipeName { get; set; }
        public string? UserId { get; set; }
        public string CountryId { get; set; }
        public string MealId { get; set; }
        public string Description { get; set; }
        public string PrepTimeSt { get; set; }
        public string CookTimeSt { get; set; }
        public string StandTimeSt { get; set; }
        public int TotalTime { get; set; }
        public string ServingsSt { get; set; }
        public string CarbohydrateSt { get; set; }
        public string ProteinSt { get; set; }
        public string FatSt { get; set; }
        public int Calories { get; set; }
        public PhotoVM? PhotoVMs { get; set; }
        public ICollection<DirectionVM> DirectionVMs { get; set; }
        public virtual ICollection<IoRAddUpdateVM> IngredientOfRecipeVMs { get; set; }
    }
    public class RecipeSearch
    {
        public string? RecipeName { get; set; }
        public string? CountryId { get; set; }
        public string? MealId { get; set; }
        public int? MinTotalTime { get; set; } = 0;
        public int? MaxTotalTime { get; set; } = int.MaxValue;
        public int? MinServing { get; set; } = 0;
        public int? MaxServing { get; set; } = int.MaxValue;
    }
}
