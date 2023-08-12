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
    public class PhotoRepository : GenericRepository<Photo>, IPhotoRepository
    {
        public PhotoRepository(RecipeOrganizerDBContext dBContext) : base(dBContext)
        {
        }
        public bool AddRangePhoto(List<Photo> photos)
        {
            try
            {
                if(photos != null)
                {
                    foreach (var item in photos)
                    {
                        dbSet.Add(item);
                    }
                    dBContext.SaveChanges();
                    return true;
                }
                else
                {
                    return false;
                }
            }catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
