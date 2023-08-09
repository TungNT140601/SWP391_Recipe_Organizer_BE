using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public class Plan
    {
        public Plan()
        {
            PlanDetails = new HashSet<PlanDetail>();
        }
        public string PlanId { get; set; }
        public string UserId { get; set; }
        public DateTime CreateTime { get; set; }
        public DateTime UpdateTime { get; set; }
        public DateTime DeleteTime { get; set; }
        public bool IsDelete { get; set; }
        public virtual UserAccount? UserAccount { get; set; }
        public virtual IEnumerable<PlanDetail> PlanDetails { get; set; }
    }
}
