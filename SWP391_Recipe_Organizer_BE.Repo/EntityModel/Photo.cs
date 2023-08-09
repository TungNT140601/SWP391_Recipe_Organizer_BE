using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public class Photo
    {
        public Photo() { }
        public string PhotoId { get; set; }
        public string PhotoName { get; set; }
        public string RecipeId { get; set; }
        public string UserId { get; set; }
        public DateTime UploadTime { get; set; } = DateTime.Now;
        public virtual UserAccount UserAccount { get; set; }
        public virtual Recipe Recipe { get; set; }
    }
}
