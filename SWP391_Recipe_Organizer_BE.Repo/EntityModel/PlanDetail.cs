using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public class PlanDetail
    {
        public PlanDetail() { }
        public string PlanDetailId { get; set; }
        public string PlanId { get; set; }
        public string RecipeId { get; set; }
        public DateTime Date { get; set; }
        public int MealOfDate { get; set; }
        public virtual Plan Plan { get; set; }
        public virtual Recipe Recipe { get; set; }
    }
}
