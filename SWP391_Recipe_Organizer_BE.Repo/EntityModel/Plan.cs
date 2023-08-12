using System;
using System.Collections.Generic;

namespace SWP391_Recipe_Organizer_BE.Repo.EntityModel
{
    public partial class Plan
    {
        public Plan()
        {
            PlanDetails = new HashSet<PlanDetail>();
        }

        public string PlanId { get; set; } = null!;
        public string? UserId { get; set; }
        public DateTime? CreateTime { get; set; }
        public DateTime? UpdateTime { get; set; }
        public DateTime? DeleteTime { get; set; }
        public bool? IsDelete { get; set; }
        public string? PlanName { get; set; }
        public string? PlanDescription { get; set; }

        public virtual UserAccount? User { get; set; }
        public virtual ICollection<PlanDetail> PlanDetails { get; set; }
    }
}
