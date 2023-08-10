using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.Interface
{
    public interface IGeneralRepository<T> where T : class
    {
        T Get(object id);
        IEnumerable<T> GetAll(params Expression<Func<T, object>>[] includeProperties);
        bool Add(T item);
        bool Remove(T item);
        bool Update(T item);
    }
}
