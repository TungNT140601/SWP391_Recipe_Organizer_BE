using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Service.Services
{
    public class ReviewService : IReviewService
    {
        private readonly IReviewRepository reviewRepository;
        public ReviewService(IReviewRepository reviewRepository)
        {
            this.reviewRepository = reviewRepository;
        }

        public bool Add(Review item)
        {
            throw new NotImplementedException();
        }

        public bool Delete(object id)
        {
            throw new NotImplementedException();
        }

        public Review Get(string id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Review> GetAll()
        {
            throw new NotImplementedException();
        }

        public bool Update(Review item)
        {
            throw new NotImplementedException();
        }

        public double GetAveReview(string id)
        {
            try
            {
                var reviews = reviewRepository.GetAll(x => x.RecipeId == id).ToList();
                var sum = 0;
                if (reviews.Any())
                {
                    foreach (var review in reviews)
                    {
                        sum += review.VoteNum.Value;
                    }
                    double average = (double)sum / reviews.Count();
                    return Math.Round(average, 1);
                }
                else
                {
                    return 0;
                }
            }catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
