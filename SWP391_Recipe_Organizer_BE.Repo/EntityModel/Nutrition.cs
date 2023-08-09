using System;
using System.Collections.Generic;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public partial class Nutrition
    {
        public string NutritionId { get; set; } = null!;
        public string? NutritionName { get; set; }
    }
}
