using System;
using System.Collections.Generic;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public partial class UserAccount
    {
        public UserAccount()
        {
            FavoriteRecipes = new HashSet<FavoriteRecipe>();
            Photos = new HashSet<Photo>();
            Plans = new HashSet<Plan>();
            Recipes = new HashSet<Recipe>();
            Reviews = new HashSet<Review>();
        }

        public string UserId { get; set; } = null!;
        public string? Username { get; set; }
        public string? UserInfo { get; set; }
        public string? FullName { get; set; }
        public string? Email { get; set; }
        public string? AvatarName { get; set; }
        public string? GoogleToken { get; set; }
        public string? PhoneNum { get; set; }
        public string? Address { get; set; }
        public string? Password { get; set; }
        public DateTime? CreateDate { get; set; }
        public DateTime? UpdateDate { get; set; }
        public bool? IsDelete { get; set; }
        public int? Role { get; set; }

        public virtual ICollection<FavoriteRecipe> FavoriteRecipes { get; set; }
        public virtual ICollection<Photo> Photos { get; set; }
        public virtual ICollection<Plan> Plans { get; set; }
        public virtual ICollection<Recipe> Recipes { get; set; }
        public virtual ICollection<Review> Reviews { get; set; }
    }
}
