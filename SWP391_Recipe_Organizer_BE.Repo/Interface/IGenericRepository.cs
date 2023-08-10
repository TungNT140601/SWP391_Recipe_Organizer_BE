using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.Interface
{
    public interface IGenericRepository<T> where T : class
    {
        T Get(object id);
        IEnumerable<T> GetAll(Func<T, bool> predicate, params Expression<Func<T, object>>[] includeProperties);
        bool Add(T item);
        bool Remove(object id);
        bool Update(T item);
    }
}
