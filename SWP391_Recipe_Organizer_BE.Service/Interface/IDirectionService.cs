using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Service.Interface
{
    public interface IDirectionService
    {
        Direction Get(string id);
        IEnumerable<Direction> GetAll();
        bool Add(Direction item);
        bool Remove(Direction item);
        bool Update(Direction item);
    }
}
