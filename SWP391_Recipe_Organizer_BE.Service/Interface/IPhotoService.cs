using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Service.Interface
{
    public interface IPhotoService
    {
        Photo Get(string id);
        IEnumerable<Photo> GetByRecipeId(string id);
        IEnumerable<Photo> GetAll();
        bool Add(List<Photo> lst, string userId, string recipeId);
        bool Delete(string id);
        bool Update(Photo item);
    }
}
