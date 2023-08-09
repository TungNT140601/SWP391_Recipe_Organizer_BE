using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public class Direction
    {
        public Direction()
        {

        }
        public string DirectionsId { get; set; }
        public string RecipeId { get; set; }
        public int DirectionsNum { get; set; }
        public string DirectionsDesc { get; set; }
        public virtual Recipe Recipe { get; set; }
    }
}
