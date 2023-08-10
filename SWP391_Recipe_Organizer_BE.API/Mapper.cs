using AutoMapper;
using SWP391_Recipe_Organizer_BE.Repo.EntityModel;
using SWP391_Recipe_Organizer_BE.Repo.ViewModel;

namespace SWP391_Recipe_Organizer_BE.API
{
    public class Mapper: Profile
    {
        public Mapper()
        {
            CreateMap<UserAccountVM, UserAccount>();
            CreateMap<UserAccount, UserAccountVM>();
        }
    }
}
