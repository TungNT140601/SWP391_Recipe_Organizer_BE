using System;
using System.Collections.Generic;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public partial class Photo
    {
        public string? PhotoId { get; set; } = null!;
        public string? PhotoName { get; set; }
        public string? RecipeId { get; set; }
        public string? UserId { get; set; }
        public DateTime? UploadTime { get; set; }
        public bool? IsDelete { get; set; }

        public virtual Recipe? Recipe { get; set; }
        public virtual UserAccount? User { get; set; }
    }
}
