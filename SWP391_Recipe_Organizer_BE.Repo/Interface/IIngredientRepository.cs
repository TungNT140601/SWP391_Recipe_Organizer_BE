﻿using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWP391_Recipe_Organizer_BE.Repo.Interface
{
    public interface IIngredientRepository : IGenericRepository<Ingredient>
    {
        Task<Ingredient> Get(string id);
    }
}
