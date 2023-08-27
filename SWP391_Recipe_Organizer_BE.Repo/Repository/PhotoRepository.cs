using SWP391_Recipe_Organizer_BE.Repo.DataAccess;
using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
using SWP391_Recipe_Organizer_BE.Ultility;
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
        public async Task<bool> AddRangePhoto(List<Photo> photos, string userId, string recipeId)
        {
            try
            {
                if (photos != null)
                {
                    foreach (var item in photos)
                    {
                        item.PhotoId = GenerateId.AutoGenerateId();
                        item.RecipeId = recipeId;
                        item.UserId = userId;
                        item.UploadTime = DateTime.Now;
                        item.IsDelete = false;
                        dbSet.Add(item);
                    }
                    await dBContext.SaveChangesAsync();
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public void RemoveAll(string recipeId)
        {
            try
            {
                var items = GetAll(x => x.RecipeId == recipeId).ToList();
                if (items != null)
                {
                    foreach (var item in items)
                    {
                        dbSet.Remove(item);
                    }
                    dBContext.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
