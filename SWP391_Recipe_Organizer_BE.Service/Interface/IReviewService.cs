using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Service.Interface
{
    public interface IReviewService
    {
        Review Get(string id);
        IEnumerable<Review> GetAll();
        bool Add(Review item);
        bool Remove(Review item);
        bool Update(Review item);
    }
}
