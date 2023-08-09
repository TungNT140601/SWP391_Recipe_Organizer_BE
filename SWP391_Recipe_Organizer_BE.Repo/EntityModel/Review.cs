using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public class Review
    {
        public Review() { }
        public string ReviewId { get; set; }
        public string UserId { get; set; }
        public string RecipeId { get; set; }
        public DateTime CreateTime { get; set; } = DateTime.Now;
        public DateTime UpdateTime { get; set; } = DateTime.Now;
        public virtual UserAccount? UserAccount { get; set; }
        public virtual Recipe? Recipe { get; set; }
    }
}
