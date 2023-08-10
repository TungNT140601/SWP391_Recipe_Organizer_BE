using System;
using System.Collections.Generic;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public partial class Country
    {
        public Country()
        {
            Recipes = new HashSet<Recipe>();
        }

        public string CountryId { get; set; } = null!;
        public string? CountryName { get; set; }
        public bool? HasRecipe { get; set; }
        public bool? IsDelete { get; set; }

        public virtual ICollection<Recipe> Recipes { get; set; }
    }
}
