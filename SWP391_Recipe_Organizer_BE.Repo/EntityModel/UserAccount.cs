using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public class UserAccount
    {
        public UserAccount()
        {
            Recipes = new HashSet<Recipe>();
            Plans = new HashSet<Plan>();
            FavoriteRecipes = new HashSet<FavoriteRecipe>();
            Reviews = new HashSet<Review>();
            Photos = new HashSet<Photo>();
        }
        public string UserId { get; set; }

        public string? Username { get; set; }
        public string? UserInfo { get; set; }
        public string? FullName { get; set; }
        public string? Email { get; set; }
        public string? AvatarName { get; set; }
        public string? GoogleToken { get; set; }
        public string? PhoneNum { get; set; }
        public string? Address { get; set; }
        public string Password { get; set; }
        public DateTime CreateDate { get; set; } = DateTime.Now;
        public DateTime UpdateDate { get; set; } = DateTime.Now;
        public bool IsDelete { get; set; } = false;
        public int Role { get; set; } = 1; // 0: Admin, 1: Customer, 2: Cooker
        public virtual IEnumerable<Recipe> Recipes { get; set; }
        public virtual IEnumerable<Plan> Plans { get; set; }
        public virtual IEnumerable<FavoriteRecipe> FavoriteRecipes { get; set; }
        public virtual IEnumerable<Review> Reviews { get; set; }
        public virtual IEnumerable<Photo> Photos { get; set; }
    }
}
