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
    public class DirectionRepository : GenericRepository<Direction>, IDirectionRepository
    {
        public DirectionRepository(RecipeOrganizerDBContext dBContext) : base(dBContext)
        {
        }
        public bool Remove(string directionId, string recipeId)
        {
            try
            {
                var item = dbSet.Where(x => x.DirectionsId == directionId && x.RecipeId == recipeId).FirstOrDefault();
                if (item != null)
                {
                    dbSet.Remove(item);
                    dBContext.SaveChanges();
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
        public bool AddRange(List<Direction> directions, string recipeId)
        {
            try
            {
                foreach (var direction in directions)
                {
                    direction.DirectionsId = GenerateId.AutoGenerateId();
                    direction.RecipeId = recipeId;
                    dbSet.Add(direction);
                }
                dBContext.SaveChanges();
                return true;
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
                var directions = GetAll(x => x.RecipeId == recipeId).ToList();
                if(directions != null)
                {
                    foreach (var direction in directions)
                    {
                        dbSet.Remove(direction);
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
