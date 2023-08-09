using Microsoft.EntityFrameworkCore;
using SWP391_Recipe_Organizer_BE.Repo.DataAccess;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.Repository
{
    public class GeneralRepository<T> : IGeneralRepository<T> where T : class
    {
        protected readonly RecipeOrganizerDBContext dBContext;
        protected readonly DbSet<T> dbSet;
        public GeneralRepository(RecipeOrganizerDBContext dBContext)
        {
            if (this.dBContext == null)
            {
                this.dBContext = dBContext;
            }
            dbSet = dBContext.Set<T>();
        }
        public bool Add(T item)
        {
            try
            {
                dbSet.Add(item);
                dBContext.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public T Get(object id)
        {
            try
            {
                var item = dbSet.Find(id);
                return item != null ? item : null;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public IEnumerable<T> GetAll()
        {
            try
            {
                var lst = dbSet.ToList();
                return lst;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool Remove(T item)
        {
            try
            {
                dbSet.Remove(item);
                dBContext.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool Update(T item)
        {
            try
            {
                dbSet.Update(item);
                dBContext.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
