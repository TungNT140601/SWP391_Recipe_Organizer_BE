using System;
using System.Collections.Generic;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public partial class Direction
    {
        public string DirectionsId { get; set; } = null!;
        public string? RecipeId { get; set; }
        public int? DirectionsNum { get; set; }
        public string? DirectionsDesc { get; set; }

        public virtual Recipe? Recipe { get; set; }
    }
}
