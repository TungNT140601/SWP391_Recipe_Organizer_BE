using Microsoft.EntityFrameworkCore;
using SWP391_Recipe_Organizer_BE.Repo.DataAccess;
using SWP391_Recipe_Organizer_BE.Repo.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.Repository
{
    public class GenericRepository<T> : IGenericRepository<T> where T : class
    {
        protected readonly RecipeOrganizerDBContext dBContext;
        protected readonly DbSet<T> dbSet;
        public GenericRepository(RecipeOrganizerDBContext dBContext)
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

        public T Get(Func<T, bool> predicate, params Expression<Func<T, object>>[] includeProperties)
        {
            try
            {
                IQueryable<T> query = dbSet;

                foreach (var includeProperty in includeProperties)
                {
                    query = query.Include(includeProperty);
                }
                var items = query.Where(predicate).FirstOrDefault();
                return items;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public IEnumerable<T> GetAll(Func<T, bool>? predicate, params Expression<Func<T, object>>[] includeProperties)
        {
            try
            {
                IQueryable<T> query = dbSet;

                foreach (var includeProperty in includeProperties)
                {
                    query = query.Include(includeProperty);
                }
                var items = new List<T>();
                if (predicate != null)
                {
                    items = query.Where(predicate).ToList();
                }
                else
                {
                    items = query.ToList();
                }
                return items;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public bool Remove(object id)
        {
            try
            {
                var item = dbSet.Find(id);
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
