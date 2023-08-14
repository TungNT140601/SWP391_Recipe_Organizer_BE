using SWP391_Recipe_Organizer_BE.Repo.DataAccess;
using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.Repository
{
    public class ReviewRepository : GenericRepository<Review>, IReviewRepository
    {
        public ReviewRepository(RecipeOrganizerDBContext dBContext) : base(dBContext)
        {
        }
        public override bool Add(Review item)
        {
            try
            {
                var review = dbSet.Where(x => x.UserId == item.UserId && x.RecipeId == item.RecipeId).FirstOrDefault();
                if (review != null)
                {
                    review.VoteNum = item.VoteNum;
                    review.Comment = item.Comment;
                    review.RecipeId = item.RecipeId;
                    review.UpdateTime = DateTime.Now;
                    review.Comment = item.Comment;
                    dbSet.Update(review);
                    dBContext.SaveChanges();
                    return true;
                }
                else
                {
                    dbSet.Add(item);
                    dBContext.SaveChanges();
                    return true;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
