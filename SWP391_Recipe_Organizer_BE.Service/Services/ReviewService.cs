using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
using SWP391_Recipe_Organizer_BE.Service.Interface;
using SWP391_Recipe_Organizer_BE.Ultility;
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
            try
            {
                var review = reviewRepository.Get(x => x.UserId == item.UserId && x.RecipeId == item.RecipeId);
                if (review != null)
                {
                    review.VoteNum = item.VoteNum;
                    review.Comment = item.Comment;
                    review.UpdateTime = DateTime.Now;
                    return reviewRepository.Update(review);
                }
                else
                {
                    item.ReviewId = GenerateId.AutoGenerateId();
                    item.CreateTime = DateTime.Now;
                    item.UpdateTime = DateTime.Now;
                    return reviewRepository.Add(item);
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool Delete(string id)
        {
            try
            {
                var review = reviewRepository.Get(x => x.ReviewId == id);
                if (review != null)
                {
                    return reviewRepository.Remove(review.ReviewId);
                }
                else
                {
                    throw new Exception("Not Found");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
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
            try
            {
                var review = reviewRepository.Get(x => x.UserId == item.UserId && x.RecipeId == item.RecipeId && x.ReviewId == item.ReviewId);
                if (review != null)
                {
                    review.VoteNum = item.VoteNum;
                    review.Comment = item.Comment;
                    review.UpdateTime = DateTime.Now;
                    return reviewRepository.Update(review);
                }
                else
                {
                    throw new Exception("Not Found");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public double GetAveReview(string id)
        {
            try
            {
                var reviews = reviewRepository.GetAll(x => x.RecipeId == id).ToList();
                if (reviews != null)
                {
                    if (reviews.Count > 0)
                    {
                        return Math.Round(reviews.Average(x => x.VoteNum ?? 0), 1);
                    }
                }
                return 0;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
