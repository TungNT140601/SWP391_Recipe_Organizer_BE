using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Ultility
{
    public class GenerateId
    {
        public static string AutoGenerateId()
        {
            Guid id = Guid.NewGuid();
            return id.ToString();
        }
    }
}
