using System;
using System.Collections.Generic;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public partial class Ingredient
    {
        public string IngredientId { get; set; } = null!;
        public string? IngredientName { get; set; }
        public bool? IsDelete { get; set; }
    }
}
