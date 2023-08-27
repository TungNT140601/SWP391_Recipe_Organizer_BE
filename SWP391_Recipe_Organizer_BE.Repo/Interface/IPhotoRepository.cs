using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.Interface
{
    public interface IPhotoRepository : IGenericRepository<Photo>
    {
        Task<bool> AddRangePhoto(List<Photo> photos, string userId, string recipeId);
        void RemoveAll(string recipeId);
    }
}
