using System;
using System.Collections.Generic;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public partial class Meal
    {
        public Meal()
        {
            Recipes = new HashSet<Recipe>();
        }

        public string MealId { get; set; } = null!;
        public string? MealName { get; set; }
        public bool? IsDelete { get; set; }

        public virtual ICollection<Recipe> Recipes { get; set; }
    }
}
