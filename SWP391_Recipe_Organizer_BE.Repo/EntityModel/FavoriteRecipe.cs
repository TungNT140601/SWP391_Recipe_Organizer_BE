using System;
using System.Collections.Generic;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public partial class FavoriteRecipe
    {
        public string FavoriteId { get; set; } = null!;
        public string? UserId { get; set; }
        public string? RecipeId { get; set; }
        public DateTime? FavoriteTime { get; set; }

        public virtual Recipe? Recipe { get; set; }
        public virtual UserAccount? User { get; set; }
    }
}
