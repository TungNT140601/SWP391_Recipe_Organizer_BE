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
    public class PhotoService : IPhotoService
    {
        private readonly IPhotoRepository photoRepository;
        public PhotoService(IPhotoRepository photoRepository)
        {
            this.photoRepository = photoRepository;
        }
        public bool Add(List<Photo> lst)
        {
            try
            {
                return photoRepository.AddRangePhoto(lst);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public Photo Get(string id)
        {
            try
            {
                var photo = photoRepository.Get(x => x.PhotoId == id && x.IsDelete == false);
                return photo;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public IEnumerable<Photo> GetByRecipeId(string id)
        {
            try
            {
                var photo = photoRepository.GetAll(x => x.RecipeId == id && x.IsDelete == false, new System.Linq.Expressions.Expression<Func<Photo, object>>[]
                {
                    x => x.Recipe,
                    x => x.User
                });
                return photo;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public IEnumerable<Photo> GetAll()
        {
            try
            {
                return photoRepository.GetAll(x => x.IsDelete == false);
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
                var photo = photoRepository.Get(x => x.PhotoId == id && x.IsDelete == false);
                if (photo != null)
                {
                    photo.IsDelete = true;
                    return photoRepository.Update(photo);
                }
                else
                {
                    throw new Exception("Not Found Photo");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool Update(Photo item)
        {
            try
            {
                var photo = photoRepository.Get(x => x.PhotoId == item.PhotoId && x.IsDelete == false);
                if (photo != null)
                {
                    photo.PhotoName = item.PhotoName;
                    photo.IsDelete = false;
                    return photoRepository.Update(photo);
                }
                else
                {
                    throw new Exception("Not Found Photo");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
